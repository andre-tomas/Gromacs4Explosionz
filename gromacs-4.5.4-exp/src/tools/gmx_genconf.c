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

#include "maths.h"
#include "macros.h"
#include "copyrite.h"
#include "string2.h"
#include "smalloc.h"
#include "sysstuff.h"
#include "confio.h"
#include "statutil.h"
#include "vec.h"
#include "random.h"
#include "3dview.h"
#include "txtdump.h"
#include "readinp.h"
#include "names.h"
#include "sortwater.h"
#include "gmx_ana.h"

static void rand_rot(int natoms,rvec x[],rvec v[],vec4 xrot[],vec4 vrot[],
                     int *seed,rvec max_rot)
{
  mat4 mt1,mt2,mr[DIM],mtemp1,mtemp2,mtemp3,mxtot,mvtot;
  rvec xcm;
  real phi;
  int  i,m;
  
  clear_rvec(xcm);
  for(i=0; (i<natoms); i++)
    for(m=0; (m<DIM); m++) {
      xcm[m]+=x[i][m]/natoms;   /* get center of mass of one molecule  */
    }
  fprintf(stderr,"center of geometry: %f, %f, %f\n",xcm[0],xcm[1],xcm[2]);
  
  translate(-xcm[XX],-xcm[YY],-xcm[ZZ],mt1);  /* move c.o.ma to origin */
  for(m=0; (m<DIM); m++) {
    phi=M_PI*max_rot[m]*(2*rando(seed) - 1)/180;
    rotate(m,phi,mr[m]);
  }
  translate(xcm[XX],xcm[YY],xcm[ZZ],mt2);

  /* For mult_matrix we need to multiply in the opposite order
   * compared to normal mathematical notation.
   */
  mult_matrix(mtemp1,mt1,mr[XX]);
  mult_matrix(mtemp2,mr[YY],mr[ZZ]);
  mult_matrix(mtemp3,mtemp1,mtemp2);
  mult_matrix(mxtot,mtemp3,mt2);
  mult_matrix(mvtot,mr[XX],mtemp2);
  
  for(i=0; (i<natoms); i++) {
    m4_op(mxtot,x[i],xrot[i]);
    m4_op(mvtot,v[i],vrot[i]);
  }
}

static void move_x(int natoms,rvec x[],matrix box)
{
  int  i,m;
  rvec xcm;

  clear_rvec(xcm);
  for(i=0; (i<natoms); i++)
    for(m=0; (m<DIM); m++)
      xcm[m]+=x[i][m];
  for(m=0; (m<DIM); m++)
    xcm[m] = 0.5*box[m][m]-xcm[m]/natoms;
  for(i=0; (i<natoms); i++)
    for(m=0; (m<DIM); m++)
      x[i][m] += xcm[m];
}

int gmx_genconf(int argc, char *argv[])
{
  const char *desc[] = {
    "[TT]genconf[tt] multiplies a given coordinate file by simply stacking them",
    "on top of each other, like a small child playing with wooden blocks.",
    "The program makes a grid of [IT]user defined[it]",
    "proportions ([TT]-nbox[tt]), ",
    "and interspaces the grid point with an extra space [TT]-dist[tt].[PAR]",
    "When option [TT]-rot[tt] is used the program does not check for overlap",
    "between molecules on grid points. It is recommended to make the box in",
    "the input file at least as big as the coordinates + ",
    "Van der Waals radius.[PAR]",
    "If the optional trajectory file is given, conformations are not",
    "generated, but read from this file and translated appropriately to",
    "build the grid."
    
  };
  const char *bugs[] = {
    "The program should allow for random displacement of lattice points." };

  int     vol;          
  t_atoms *atoms;       /* list with all atoms */
  char    title[STRLEN];
  rvec    *x,*xx,*v;        /* coordinates? */
  real    t;
  vec4    *xrot,*vrot;
  int     ePBC;
  matrix  box,boxx;          /* box length matrix */
  rvec    shift;         
  int     natoms;       /* number of atoms in one molecule  */
  int     nres;         /* number of molecules? */
  int     i,j,k,l,m,ndx,nrdx,nx,ny,nz;
  t_trxstatus *status;
  gmx_bool    bTRX;
  output_env_t oenv;
  
  t_filenm fnm[] = {
    { efSTX, "-f", "conf", ffREAD  },
    { efSTO, "-o", "out",  ffWRITE },
    { efTRX, "-trj",NULL,  ffOPTRD }
  };
#define NFILE asize(fnm)
  static rvec nrbox    = {1,1,1};
  static int  seed     = 0;          /* seed for random number generator */
  static int  nmolat   = 3;
  static int  nblock   = 1;
  static gmx_bool bShuffle = FALSE;
  static gmx_bool bSort    = FALSE;
  static gmx_bool bRandom  = FALSE;      /* False: no random rotations */
  static gmx_bool bRenum   = TRUE;       /* renumber residues */
  static rvec dist     = {0,0,0};    /* space added between molecules ? */
  static rvec max_rot  = {180,180,180}; /* maximum rotation */
  t_pargs pa[] = {
    { "-nbox",   FALSE, etRVEC, {nrbox},   "Number of boxes" },
    { "-dist",   FALSE, etRVEC, {dist},    "Distance between boxes" },
    { "-seed",   FALSE, etINT,  {&seed},   
      "Random generator seed, if 0 generated from the time" },
    { "-rot",    FALSE, etBOOL, {&bRandom}, "Randomly rotate conformations" },
    { "-shuffle",FALSE, etBOOL, {&bShuffle},"Random shuffling of molecules" },
    { "-sort",   FALSE, etBOOL, {&bSort},   "Sort molecules on X coord" },
    { "-block",  FALSE, etINT,  {&nblock},
      "Divide the box in blocks on this number of cpus" },
    { "-nmolat", FALSE, etINT,  {&nmolat}, 
      "Number of atoms per molecule, assumed to start from 0. "
      "If you set this wrong, it will screw up your system!" },
    { "-maxrot", FALSE, etRVEC, {max_rot}, "Maximum random rotation" },
    { "-renumber",FALSE,etBOOL, {&bRenum},  "Renumber residues" }
  };
  
  CopyRight(stderr,argv[0]);
  parse_common_args(&argc,argv,0,NFILE,fnm,asize(pa),pa,
		    asize(desc),desc,asize(bugs),bugs,&oenv);

  if (bRandom && (seed == 0))
    seed = make_seed();
		    
  bTRX = ftp2bSet(efTRX,NFILE,fnm);
  nx   = (int)(nrbox[XX]+0.5);
  ny   = (int)(nrbox[YY]+0.5);
  nz   = (int)(nrbox[ZZ]+0.5);
  
  if ((nx <= 0) || (ny <= 0) || (nz <= 0))
    gmx_fatal(FARGS,"Number of boxes (-nbox) should be larger than zero");
  if ((nmolat <= 0) && bShuffle)
    gmx_fatal(FARGS,"Can not shuffle if the molecules only have %d atoms",
		nmolat);
  
  vol=nx*ny*nz;     /* calculate volume in grid points (= nr. molecules) */

  get_stx_coordnum(opt2fn("-f",NFILE,fnm),&natoms); 
  snew(atoms,1);
  /* make space for all the atoms */
  init_t_atoms(atoms,natoms*vol,FALSE);
  snew(x,natoms*vol);              /* get space for coordinates of all atoms */
  snew(xrot,natoms);               /* get space for rotation matrix? */
  snew(v,natoms*vol);              /* velocities. not really needed? */ 
  snew(vrot,natoms); 
  /* set atoms->nr to the number in one box *
   * to avoid complaints in read_stx_conf   *
   */
  atoms->nr = natoms;
  read_stx_conf(opt2fn("-f",NFILE,fnm),title,atoms,x,v,&ePBC,box);

  nres=atoms->nres;                /* nr of residues in one element? */

  if (bTRX) {
    if (!read_first_x(oenv,&status,ftp2fn(efTRX,NFILE,fnm),&t,&xx,boxx))
      gmx_fatal(FARGS,"No atoms in trajectory %s",ftp2fn(efTRX,NFILE,fnm));
  } else {
    snew(xx,natoms);
    for(i=0; i<natoms; i++) {
      copy_rvec(x[i],xx[i]);
    }
  }
  
  
  for(k=0; (k<nz); k++) {          /* loop over all gridpositions    */
    shift[ZZ]=k*(dist[ZZ]+box[ZZ][ZZ]);
    
    for(j=0; (j<ny); j++) {
      shift[YY]=j*(dist[YY]+box[YY][YY])+k*box[ZZ][YY];
      
      for(i=0; (i<nx); i++)  {
	 shift[XX]=i*(dist[XX]+box[XX][XX])+j*box[YY][XX]+k*box[ZZ][XX];
	
	ndx=(i*ny*nz+j*nz+k)*natoms;
	nrdx=(i*ny*nz+j*nz+k)*nres;
	
	/* Random rotation on input coords */
	if (bRandom)
	  rand_rot(natoms,xx,v,xrot,vrot,&seed,max_rot);
	
	for(l=0; (l<natoms); l++) {
	  for(m=0; (m<DIM); m++) {
	    if (bRandom) {
	      x[ndx+l][m] = xrot[l][m];
	      v[ndx+l][m] = vrot[l][m];
	    }
	    else {
	      x[ndx+l][m] = xx[l][m];
	      v[ndx+l][m] = v[l][m];
	    }
	  }
	  if (ePBC == epbcSCREW && i % 2 == 1) {
	    /* Rotate around x axis */
	    for(m=YY; m<=ZZ; m++) {
	      x[ndx+l][m] = box[YY][m] + box[ZZ][m] - x[ndx+l][m];
	      v[ndx+l][m] = -v[ndx+l][m];
	    }
	  }
	  for(m=0; (m<DIM); m++) {
	    x[ndx+l][m] += shift[m];
	  }
	  atoms->atom[ndx+l].resind = nrdx + atoms->atom[l].resind;
	  atoms->atomname[ndx+l]=atoms->atomname[l];
	}

	for(l=0; (l<nres); l++) {
	  atoms->resinfo[nrdx+l] = atoms->resinfo[l];
	  if (bRenum)
	    atoms->resinfo[nrdx+l].nr += nrdx;
	}
	if (bTRX)
	  if (!read_next_x(oenv,status,&t,natoms,xx,boxx) && 
	      ((i+1)*(j+1)*(k+1) < vol))
	    gmx_fatal(FARGS,"Not enough frames in trajectory");
      }
    }
  }
  if (bTRX)
    close_trj(status);

  /* make box bigger */
  for(m=0; (m<DIM); m++)
    box[m][m] += dist[m];
  svmul(nx,box[XX],box[XX]);
  svmul(ny,box[YY],box[YY]);
  svmul(nz,box[ZZ],box[ZZ]);
  if (ePBC == epbcSCREW && nx % 2 == 0) {
    /* With an even number of boxes in x we can forgot about the screw */
    ePBC = epbcXYZ;
  }

  /* move_x(natoms*vol,x,box); */          /* put atoms in box? */

  atoms->nr*=vol;
  atoms->nres*=vol;
  
  /*depending on how you look at it, this is either a nasty hack or the way it should work*/
  if (bRenum)
    for (i=0;i<atoms->nres;i++)
	  atoms->resinfo[i].nr=i+1;
  
  
  if (bShuffle)
    randwater(0,atoms->nr/nmolat,nmolat,x,v,&seed);
  else if (bSort)
    sortwater(0,atoms->nr/nmolat,nmolat,x,v);
  else if (opt2parg_bSet("-block",asize(pa),pa))
    mkcompact(0,atoms->nr/nmolat,nmolat,x,v,nblock,box);
  
  write_sto_conf(opt2fn("-o",NFILE,fnm),title,atoms,x,v,ePBC,box);
  
  thanx(stderr);
  
  return 0;
}
