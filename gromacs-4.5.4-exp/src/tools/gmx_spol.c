/*
 * 
 *                This source code is part of
 * 
 *                 G   R   O   M   A   C   S
 * 
 *          GROningen MAchine for Chemical Simulations
 * 
 *                        VERSION 3.2.0
 * Written by David van der Spoel, Erik Lindahl, Berk Hess, and others.
 * Copyright (c) 1991-2000, University of Groningen, The Netherlands.
 * Copyright (c) 2001-2004, The GROMACS development team,
 * check out http://www.gromacs.org for more information.

 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * If you want to redistribute modifications, please consider that
 * scientific software is very special. Version control is crucial -
 * bugs must be traceable. We will be happy to consider code for
 * inclusion in the official distribution, but derived work must not
 * be called official GROMACS. Details are found in the README & COPYING
 * files - if they are missing, get the official version at www.gromacs.org.
 * 
 * To help us fund GROMACS development, we humbly ask that you cite
 * the papers on the package - you can find them in the top README file.
 * 
 * For more info, check our website at http://www.gromacs.org
 * 
 * And Hey:
 * Green Red Orange Magenta Azure Cyan Skyblue
 */
#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include "macros.h"
#include "statutil.h"
#include "smalloc.h"
#include "copyrite.h"
#include "gstat.h"
#include "vec.h"
#include "xvgr.h"
#include "pbc.h"
#include "index.h"
#include "tpxio.h"
#include "physics.h"
#include "gmx_ana.h"


static void calc_com_pbc(int nrefat,t_topology *top,rvec x[],t_pbc *pbc,
			 atom_id index[],rvec xref,int ePBC,matrix box)
{
  const real tol=1e-4;
  gmx_bool  bChanged;
  int   m,j,ai,iter;
  real  mass,mtot;
  rvec  dx,xtest;
  
  /* First simple calculation */
  clear_rvec(xref);
  mtot = 0;
  for(m=0; (m<nrefat); m++) {
    ai = index[m];
    mass = top->atoms.atom[ai].m;
    for(j=0; (j<DIM); j++)
      xref[j] += mass*x[ai][j];
    mtot += mass;
  }
  svmul(1/mtot,xref,xref);
  /* Now check if any atom is more than half the box from the COM */
  if (ePBC != epbcNONE) {
    iter = 0;
    do {
      bChanged = FALSE;
      for(m=0; (m<nrefat); m++) {
	ai   = index[m];
	mass = top->atoms.atom[ai].m/mtot;
	pbc_dx(pbc,x[ai],xref,dx);
	rvec_add(xref,dx,xtest);
	for(j=0; (j<DIM); j++)
	  if (fabs(xtest[j]-x[ai][j]) > tol) {
	    /* Here we have used the wrong image for contributing to the COM */
	    xref[j] += mass*(xtest[j]-x[ai][j]);
	    x[ai][j] = xtest[j];
	    bChanged = TRUE;
	  }
      }
      if (bChanged)
	printf("COM: %8.3f  %8.3f  %8.3f  iter = %d\n",xref[XX],xref[YY],xref[ZZ],iter);
      iter++;
    } while (bChanged);
  }
}

void spol_atom2molindex(int *n,int *index,t_block *mols)
{
  int nmol,i,j,m;

  nmol = 0;
  i=0;
  while (i < *n) {
    m=0;
    while(m < mols->nr && index[i] != mols->index[m])
      m++;
    if (m == mols->nr)
      gmx_fatal(FARGS,"index[%d]=%d does not correspond to the first atom of a molecule",i+1,index[i]+1);
    for(j=mols->index[m]; j<mols->index[m+1]; j++) {
      if (i >= *n || index[i] != j)
	gmx_fatal(FARGS,"The index group is not a set of whole molecules");
      i++;
    }
    /* Modify the index in place */
    index[nmol++] = m;
  }
  printf("There are %d molecules in the selection\n",nmol);

  *n = nmol;
}

int gmx_spol(int argc,char *argv[])
{
  t_topology *top;
  t_inputrec *ir;
  t_atom     *atom;
  char     title[STRLEN];
  t_trxstatus *status;
  int      nrefat,natoms,nf,ntot;
  real     t;
  rvec     *xtop,*x,xref,trial,dx={0},dip,dir;
  matrix   box;
  
  FILE    *fp;
  int     *isize,nrefgrp;
  atom_id **index,*molindex;
  char    **grpname;
  real    rmin2,rmax2,rcut,rcut2,rdx2=0,rtry2,qav,q,dip2,invbw;
  int     nbin,i,m,mol,a0,a1,a,d;
  double  sdip,sdip2,sinp,sdinp,nmol;
  int     *hist;
  t_pbc   pbc;
  gmx_rmpbc_t  gpbc=NULL;

  
  const char *desc[] = {
    "[TT]g_spol[tt] analyzes dipoles around a solute; it is especially useful",
    "for polarizable water. A group of reference atoms, or a center",
    "of mass reference (option [TT]-com[tt]) and a group of solvent",
    "atoms is required. The program splits the group of solvent atoms",
    "into molecules. For each solvent molecule the distance to the",
    "closest atom in reference group or to the COM is determined.",
    "A cumulative distribution of these distances is plotted.",
    "For each distance between [TT]-rmin[tt] and [TT]-rmax[tt]",
    "the inner product of the distance vector",
    "and the dipole of the solvent molecule is determined.",
    "For solvent molecules with net charge (ions), the net charge of the ion",
    "is subtracted evenly at all atoms in the selection of each ion.",
    "The average of these dipole components is printed.",
    "The same is done for the polarization, where the average dipole is",
    "subtracted from the instantaneous dipole. The magnitude of the average",
    "dipole is set with the option [TT]-dip[tt], the direction is defined",
    "by the vector from the first atom in the selected solvent group",
    "to the midpoint between the second and the third atom."
  };
 
  output_env_t oenv;
  static gmx_bool bCom = FALSE,bPBC = FALSE;
  static int  srefat=1;
  static real rmin=0.0,rmax=0.32,refdip=0,bw=0.01;
  t_pargs pa[] = {
    { "-com",  FALSE, etBOOL,  {&bCom},
      "Use the center of mass as the reference postion" },
    { "-refat",  FALSE, etINT, {&srefat},
      "The reference atom of the solvent molecule" },
    { "-rmin",  FALSE, etREAL, {&rmin}, "Maximum distance (nm)" },
    { "-rmax",  FALSE, etREAL, {&rmax}, "Maximum distance (nm)" },
    { "-dip",   FALSE, etREAL, {&refdip}, "The average dipole (D)" },
    { "-bw",    FALSE, etREAL, {&bw}, "The bin width" }
  };
  
  t_filenm fnm[] = {
    { efTRX, NULL,  NULL,  ffREAD },
    { efTPX, NULL,  NULL,  ffREAD },
    { efNDX, NULL,  NULL,  ffOPTRD },
    { efXVG, NULL,  "scdist.xvg",  ffWRITE }
  };
#define NFILE asize(fnm)

  CopyRight(stderr,argv[0]);
  parse_common_args(&argc,argv,PCA_CAN_TIME | PCA_CAN_VIEW | PCA_BE_NICE,
		    NFILE,fnm,asize(pa),pa,asize(desc),desc,0,NULL,&oenv);
  
  snew(top,1);
  snew(ir,1);
  read_tpx_top(ftp2fn(efTPX,NFILE,fnm),
	       ir,box,&natoms,NULL,NULL,NULL,top);
  
  /* get index groups */
  printf("Select a group of reference particles and a solvent group:\n"); 
  snew(grpname,2);
  snew(index,2);
  snew(isize,2);
  get_index(&top->atoms,ftp2fn_null(efNDX,NFILE,fnm),2,isize,index,grpname);

  if (bCom) {
    nrefgrp = 1;
    nrefat  = isize[0];
  } else {
    nrefgrp = isize[0];
    nrefat  = 1;
  }

  spol_atom2molindex(&(isize[1]),index[1],&(top->mols));
  srefat--;

  /* initialize reading trajectory:                         */
  natoms=read_first_x(oenv,&status,ftp2fn(efTRX,NFILE,fnm),&t,&x,box);

  rcut  = 0.99*sqrt(max_cutoff2(ir->ePBC,box));
  if (rcut == 0)
    rcut = 10*rmax;
  rcut2 = sqr(rcut);
  invbw = 1/bw;
  nbin = (int)(rcut*invbw)+2;
  snew(hist,nbin);

  rmin2 = sqr(rmin);
  rmax2 = sqr(rmax);

  nf = 0;
  ntot = 0;
  sdip  = 0;
  sdip2 = 0;
  sinp  = 0;
  sdinp = 0;

  molindex = top->mols.index;
  atom     = top->atoms.atom;
  
  gpbc = gmx_rmpbc_init(&top->idef,ir->ePBC,natoms,box);

  /* start analysis of trajectory */
  do {
    /* make molecules whole again */
    gmx_rmpbc(gpbc,natoms,box,x);

    set_pbc(&pbc,ir->ePBC,box);
    if (bCom)
      calc_com_pbc(nrefat,top,x,&pbc,index[0],xref,ir->ePBC,box);

    for(m=0; m<isize[1]; m++) {
      mol = index[1][m];
      a0 = molindex[mol];
      a1 = molindex[mol+1];
      for(i=0; i<nrefgrp; i++) {
	pbc_dx(&pbc,x[a0+srefat],bCom ? xref : x[index[0][i]],trial);
	rtry2 = norm2(trial);
	if (i==0 || rtry2 < rdx2) {
	  copy_rvec(trial,dx);
	  rdx2 = rtry2;
	}
      }
      if (rdx2 < rcut2)
	hist[(int)(sqrt(rdx2)*invbw)+1]++;
      if (rdx2 >= rmin2 && rdx2 < rmax2) {
	unitv(dx,dx);
	clear_rvec(dip);
	qav = 0;
	for(a=a0; a<a1; a++) {
	  qav += atom[a].q;
	}
	qav /= (a1 - a0);
	for(a=a0; a<a1; a++) {
	  q = atom[a].q - qav;
	  for(d=0; d<DIM; d++)
	    dip[d] += q*x[a][d];
	}
	for(d=0; d<DIM; d++)
	  dir[d] = -x[a0][d];
	for(a=a0+1; a<a0+3; a++) {
	  for(d=0; d<DIM; d++)
	    dir[d] += 0.5*x[a][d];
	}
	unitv(dir,dir);

	svmul(ENM2DEBYE,dip,dip);
	dip2 = norm2(dip);
	sdip  += sqrt(dip2);
	sdip2 += dip2;
	for(d=0; d<DIM; d++) {
	  sinp  += dx[d]*dip[d];
	  sdinp += dx[d]*(dip[d] - refdip*dir[d]);
	}

	ntot++;
      }
    }
    nf++;

  }  while (read_next_x(oenv,status,&t,natoms,x,box));
  
  gmx_rmpbc_done(gpbc);

  /* clean up */
  sfree(x);
  close_trj(status);
  
  fprintf(stderr,"Average number of molecules within %g nm is %.1f\n",
	  rmax,(real)ntot/(real)nf);
  if (ntot > 0) {
    sdip  /= ntot;
    sdip2 /= ntot;
    sinp  /= ntot;
    sdinp /= ntot;
    fprintf(stderr,"Average dipole:                               %f (D), std.dev. %f\n",
	    sdip,sqrt(sdip2-sqr(sdip)));
    fprintf(stderr,"Average radial component of the dipole:       %f (D)\n",
	    sinp);
    fprintf(stderr,"Average radial component of the polarization: %f (D)\n",
	    sdinp);
  }

  fp = xvgropen(opt2fn("-o",NFILE,fnm),
		"Cumulative solvent distribution","r (nm)","molecules",oenv);
  nmol = 0;
  for(i=0; i<=nbin; i++) {
    nmol += hist[i];
    fprintf(fp,"%g %g\n",i*bw,nmol/nf);
  }
  ffclose(fp);

  do_view(oenv,opt2fn("-o",NFILE,fnm),NULL);

  thanx(stderr);
  
  return 0;
}
