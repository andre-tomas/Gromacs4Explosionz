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
#include "gmx_ana.h"


static void calc_com_pbc(int nrefat,t_topology *top,rvec x[],t_pbc *pbc,
			 atom_id index[],rvec xref,gmx_bool bPBC,matrix box)
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
  if (bPBC) {
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

int gmx_sorient(int argc,char *argv[])
{
  t_topology top;
  int      ePBC;
  char     title[STRLEN];
  t_trxstatus *status;
  int      natoms;
  real     t;
  rvec     *xtop,*x;
  matrix   box;
  
  FILE    *fp;
  int     i,j,p,sa0,sa1,sa2,n,ntot,nf,m,*hist1,*hist2,*histn,nbin1,nbin2,nrbin;
  real    *histi1,*histi2,invbw,invrbw;
  double  sum1,sum2;
  int     *isize,nrefgrp,nrefat;
  atom_id **index;
  char    **grpname;
  real    inp,outp,two_pi,nav,normfac,rmin2,rmax2,rcut,rcut2,r2,r,mass,mtot;
  real    c1,c2;
  char    str[STRLEN];
  gmx_bool    bTPS;
  rvec    xref,dx,dxh1,dxh2,outer;
  gmx_rmpbc_t gpbc=NULL;
  t_pbc   pbc;
  const char *legr[] = { "<cos(\\8q\\4\\s1\\N)>", 
	 	         "<3cos\\S2\\N(\\8q\\4\\s2\\N)-1>" };
  const char *legc[] = { "cos(\\8q\\4\\s1\\N)", 
		         "3cos\\S2\\N(\\8q\\4\\s2\\N)-1" };
  
  const char *desc[] = {
    "[TT]g_sorient[tt] analyzes solvent orientation around solutes.", 
    "It calculates two angles between the vector from one or more",
    "reference positions to the first atom of each solvent molecule:[BR]",
    "theta1: the angle with the vector from the first atom of the solvent",
    "molecule to the midpoint between atoms 2 and 3.[BR]",
    "theta2: the angle with the normal of the solvent plane, defined by the",
    "same three atoms, or when the option [TT]-v23[tt] is set",
    "the angle with the vector between atoms 2 and 3.[BR]",
    "The reference can be a set of atoms or",
    "the center of mass of a set of atoms. The group of solvent atoms should",
    "consist of 3 atoms per solvent molecule.",
    "Only solvent molecules between [TT]-rmin[tt] and [TT]-rmax[tt] are",
    "considered for [TT]-o[tt] and [TT]-no[tt] each frame.[PAR]",
    "[TT]-o[tt]: distribtion of cos(theta1) for rmin<=r<=rmax.[PAR]",
    "[TT]-no[tt]: distribution of cos(theta2) for rmin<=r<=rmax.[PAR]",
    "[TT]-ro[tt]: <cos(theta1)> and <3cos^2(theta2)-1> as a function of the",
    "distance.[PAR]",
    "[TT]-co[tt]: the sum over all solvent molecules within distance r",
    "of cos(theta1) and 3cos^2(theta2)-1 as a function of r.[PAR]",
    "[TT]-rc[tt]: the distribution of the solvent molecules as a function of r"
  };
 
  output_env_t oenv;
  static gmx_bool bCom = FALSE,bVec23=FALSE,bPBC = FALSE;
  static real rmin=0.0,rmax=0.5,binwidth=0.02,rbinw=0.02;
  t_pargs pa[] = {
    { "-com",  FALSE, etBOOL,  {&bCom},
      "Use the center of mass as the reference postion" },
    { "-v23",  FALSE, etBOOL,  {&bVec23},
      "Use the vector between atoms 2 and 3" },
    { "-rmin",  FALSE, etREAL, {&rmin}, "Minimum distance (nm)" },
    { "-rmax",  FALSE, etREAL, {&rmax}, "Maximum distance (nm)" },
    { "-cbin",  FALSE, etREAL, {&binwidth}, "Binwidth for the cosine" },
    { "-rbin",  FALSE, etREAL, {&rbinw}, "Binwidth for r (nm)" },
    { "-pbc",   FALSE, etBOOL, {&bPBC}, "Check PBC for the center of mass calculation. Only necessary when your reference group consists of several molecules." }
  };
  
  t_filenm fnm[] = {
    { efTRX, NULL,  NULL,  ffREAD },
    { efTPS, NULL,  NULL,  ffREAD },
    { efNDX, NULL,  NULL,  ffOPTRD },
    { efXVG, NULL,  "sori.xvg",  ffWRITE },
    { efXVG, "-no", "snor.xvg",  ffWRITE },
    { efXVG, "-ro", "sord.xvg",  ffWRITE },
    { efXVG, "-co", "scum.xvg",  ffWRITE },
    { efXVG, "-rc", "scount.xvg",  ffWRITE }
  };
#define NFILE asize(fnm)

  CopyRight(stderr,argv[0]);
  parse_common_args(&argc,argv,PCA_CAN_TIME | PCA_CAN_VIEW | PCA_BE_NICE,
		    NFILE,fnm,asize(pa),pa,asize(desc),desc,0,NULL,&oenv);
  
  two_pi = 2/M_PI;

  bTPS = (opt2bSet("-s",NFILE,fnm) || !opt2bSet("-n",NFILE,fnm) || bCom);
  if (bTPS) {
    read_tps_conf(ftp2fn(efTPS,NFILE,fnm),title,&top,&ePBC,&xtop,NULL,box,
		  bCom);
  }

  /* get index groups */
  printf("Select a group of reference particles and a solvent group:\n"); 
  snew(grpname,2);
  snew(index,2);
  snew(isize,2);
  if (bTPS) {
    get_index(&top.atoms,ftp2fn_null(efNDX,NFILE,fnm),2,isize,index,grpname);
  } else {
    get_index(NULL,ftp2fn(efNDX,NFILE,fnm),2,isize,index,grpname);
  }

  if (bCom) {
    nrefgrp = 1;
    nrefat  = isize[0];
  } else {
    nrefgrp = isize[0];
    nrefat  = 1;
  }

  if (isize[1] % 3)
    gmx_fatal(FARGS,"The number of solvent atoms (%d) is not a multiple of 3",
		isize[1]);

  /* initialize reading trajectory:                         */
  natoms=read_first_x(oenv,&status,ftp2fn(efTRX,NFILE,fnm),&t,&x,box);

  rmin2 = sqr(rmin);
  rmax2 = sqr(rmax);
  rcut  = 0.99*sqrt(max_cutoff2(guess_ePBC(box),box));
  if (rcut == 0)
    rcut = 10*rmax;
  rcut2 = sqr(rcut);

  invbw = 1/binwidth;
  nbin1 = 1+(int)(2*invbw + 0.5);
  nbin2 = 1+(int)(invbw + 0.5);

  invrbw = 1/rbinw;
  
  snew(hist1,nbin1);
  snew(hist2,nbin2);
  nrbin = 1+(int)(rcut/rbinw);
  if (nrbin == 0)
    nrbin = 1;
  snew(histi1,nrbin);
  snew(histi2,nrbin);
  snew(histn,nrbin);

  ntot = 0;
  nf = 0;
  sum1 = 0;
  sum2 = 0;

  if (bTPS) {
    /* make molecules whole again */
    gpbc = gmx_rmpbc_init(&top.idef,ePBC,natoms,box);
  }
  /* start analysis of trajectory */
  do {
    if (bTPS) {
      /* make molecules whole again */
      gmx_rmpbc(gpbc,natoms,box,x);
    }
    
    set_pbc(&pbc,ePBC,box);
    n    = 0;
    inp  = 0;
    outp = 0;
    for(p=0; (p<nrefgrp); p++) {
      if (bCom)
	calc_com_pbc(nrefat,&top,x,&pbc,index[0],xref,bPBC,box);
      else
	copy_rvec(x[index[0][p]],xref);

      for(m=0; m<isize[1]; m+=3) {
	sa0 = index[1][m];
	sa1 = index[1][m+1];
	sa2 = index[1][m+2];
	range_check(sa0,0,natoms);
	range_check(sa1,0,natoms);
	range_check(sa2,0,natoms);
	pbc_dx(&pbc,x[sa0],xref,dx);
	r2  = norm2(dx);
	if (r2 < rcut2) {
	  r = sqrt(r2);
	  if (!bVec23) {
	    /* Determine the normal to the plain */
	    rvec_sub(x[sa1],x[sa0],dxh1);
	    rvec_sub(x[sa2],x[sa0],dxh2);
	    rvec_inc(dxh1,dxh2);
	    svmul(1/r,dx,dx);
	    unitv(dxh1,dxh1);
	    inp = iprod(dx,dxh1);
	    cprod(dxh1,dxh2,outer);
	    unitv(outer,outer);
	    outp = iprod(dx,outer);
	  } else {
	    /* Use the vector between the 2nd and 3rd atom */
	    rvec_sub(x[sa2],x[sa1],dxh2);
	    unitv(dxh2,dxh2);
	    outp = iprod(dx,dxh2)/r;
	  }
	  {
	    int ii = (int)(invrbw*r);
	    range_check(ii,0,nrbin);
	    histi1[ii] += inp;
	    histi2[ii] += 3*sqr(outp) - 1;
	    histn[ii]++;
	  }
	  if ((r2>=rmin2) && (r2<rmax2)) {
	    int ii1 = (int)(invbw*(inp + 1));
	    int ii2 = (int)(invbw*fabs(outp));
	    
	    range_check(ii1,0,nbin1);
	    range_check(ii2,0,nbin2);
	    hist1[ii1]++;
	    hist2[ii2]++;
	    sum1 += inp;
	    sum2 += outp;
	    n++;
	  }
	}
      }
    }
    ntot += n;
    nf++;

  }  while (read_next_x(oenv,status,&t,natoms,x,box));

  /* clean up */
  sfree(x);
  close_trj(status);
  gmx_rmpbc_done(gpbc);
  
  /* Add the bin for the exact maximum to the previous bin */
  hist1[nbin1-1] += hist1[nbin1];
  hist2[nbin2-1] += hist2[nbin2];
  
  nav     = (real)ntot/(nrefgrp*nf);
  normfac = invbw/ntot;
  
  fprintf(stderr,  "Average nr of molecules between %g and %g nm: %.1f\n",
	  rmin,rmax,nav);
  if (ntot > 0) {
    sum1 /= ntot;
    sum2 /= ntot;
    fprintf(stderr,"Average cos(theta1)     between %g and %g nm: %6.3f\n",
	    rmin,rmax,sum1);
    fprintf(stderr,"Average 3cos2(theta2)-1 between %g and %g nm: %6.3f\n",
	    rmin,rmax,sum2);
  }
  
  sprintf(str,"Solvent orientation between %g and %g nm",rmin,rmax);
  fp=xvgropen(opt2fn("-o",NFILE,fnm), str,"cos(\\8q\\4\\s1\\N)","",oenv); 
  if (output_env_get_print_xvgr_codes(oenv))
    fprintf(fp,"@ subtitle \"average shell size %.1f molecules\"\n",nav);
  for(i=0; i<nbin1; i++) {
    fprintf(fp,"%g %g\n",(i+0.5)*binwidth-1,2*normfac*hist1[i]);
  }
  ffclose(fp);
  
  sprintf(str,"Solvent normal orientation between %g and %g nm",rmin,rmax);
  fp=xvgropen(opt2fn("-no",NFILE,fnm), str,"cos(\\8q\\4\\s2\\N)","",oenv);
  if (output_env_get_print_xvgr_codes(oenv))
    fprintf(fp,"@ subtitle \"average shell size %.1f molecules\"\n",nav);
  for(i=0; i<nbin2; i++) {
    fprintf(fp,"%g %g\n",(i+0.5)*binwidth,normfac*hist2[i]);
  }
  ffclose(fp);

  
  sprintf(str,"Solvent orientation");
  fp=xvgropen(opt2fn("-ro",NFILE,fnm),str,"r (nm)","",oenv);
  if (output_env_get_print_xvgr_codes(oenv))
    fprintf(fp,"@ subtitle \"as a function of distance\"\n");
  xvgr_legend(fp,2,legr,oenv);
  for(i=0; i<nrbin; i++)
    fprintf(fp,"%g %g %g\n",(i+0.5)*rbinw,
	    histn[i] ? histi1[i]/histn[i] : 0,
	    histn[i] ? histi2[i]/histn[i] : 0);
  ffclose(fp);
  
  sprintf(str,"Cumulative solvent orientation");
  fp=xvgropen(opt2fn("-co",NFILE,fnm),str,"r (nm)","",oenv);
  if (output_env_get_print_xvgr_codes(oenv))
    fprintf(fp,"@ subtitle \"as a function of distance\"\n");
  xvgr_legend(fp,2,legc,oenv);
  normfac = 1.0/(nrefgrp*nf);
  c1 = 0;
  c2 = 0;
  fprintf(fp,"%g %g %g\n",0.0,c1,c2);
  for(i=0; i<nrbin; i++) {
    c1 += histi1[i]*normfac;
    c2 += histi2[i]*normfac;
    fprintf(fp,"%g %g %g\n",(i+1)*rbinw,c1,c2);
  }
  ffclose(fp);

  sprintf(str,"Solvent distribution");
  fp=xvgropen(opt2fn("-rc",NFILE,fnm),str,"r (nm)","molecules/nm",oenv);
  if (output_env_get_print_xvgr_codes(oenv))
    fprintf(fp,"@ subtitle \"as a function of distance\"\n");
  normfac = 1.0/(rbinw*nf);
  for(i=0; i<nrbin; i++) {
    fprintf(fp,"%g %g\n",(i+0.5)*rbinw,histn[i]*normfac);
  }
  ffclose(fp);

  do_view(oenv, opt2fn("-o",NFILE,fnm),NULL);
  do_view(oenv, opt2fn("-no",NFILE,fnm),NULL);
  do_view(oenv, opt2fn("-ro",NFILE,fnm),"-nxy");
  do_view(oenv, opt2fn("-co",NFILE,fnm),"-nxy");

  thanx(stderr);
  
  return 0;
}
