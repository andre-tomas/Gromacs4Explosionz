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
#include <string.h>
#include <math.h>

#include "string2.h"
#include "typedefs.h"
#include "gmx_fatal.h"
#include "vec.h"
#include "smalloc.h"
#include "enxio.h"
#include "statutil.h"
#include "names.h"
#include "copyrite.h"
#include "macros.h"
#include "xvgr.h"
#include "gstat.h"
#include "physics.h"
#include "matio.h"
#include "strdb.h"
#include "gmx_ana.h"


static int search_str2(int nstr,char **str,char *key)
{
  int  i,n;
  int  keylen = strlen(key);
  /* Linear search */
  n=0;
  while( (n<keylen) && ((key[n]<'0') || (key[n]>'9')) )
    n++;
  for(i=0; (i<nstr); i++) 
    if (gmx_strncasecmp(str[i],key,n)==0)
      return i;

  return -1;
}

int gmx_enemat(int argc,char *argv[])
{
  const char *desc[] = {
    "[TT]g_enemat[tt] extracts an energy matrix from the energy file ([TT]-f[tt]).",
    "With [TT]-groups[tt] a file must be supplied with on each",
    "line a group of atoms to be used. For these groups matrix of",
    "interaction energies will be extracted from the energy file",
    "by looking for energy groups with names corresponding to pairs",
    "of groups of atoms. E.g. if your [TT]-groups[tt] file contains:[BR]",
    "[TT]2[tt][BR]",
    "[TT]Protein[tt][BR]",
    "[TT]SOL[tt][BR]",
    "then energy groups with names like 'Coul-SR:Protein-SOL' and ",
    "'LJ:Protein-SOL' are expected in the energy file (although",
    "[TT]g_enemat[tt] is most useful if many groups are analyzed",
    "simultaneously). Matrices for different energy types are written",
    "out separately, as controlled by the",
    "[TT]-[no]coul[tt], [TT]-[no]coulr[tt], [TT]-[no]coul14[tt], ",
    "[TT]-[no]lj[tt], [TT]-[no]lj14[tt], ",
    "[TT]-[no]bham[tt] and [TT]-[no]free[tt] options.",
    "Finally, the total interaction energy energy per group can be ",
    "calculated ([TT]-etot[tt]).[PAR]",
    
    "An approximation of the free energy can be calculated using:",
    "E(free) = E0 + kT log( <exp((E-E0)/kT)> ), where '<>'",
    "stands for time-average. A file with reference free energies",
    "can be supplied to calculate the free energy difference",
    "with some reference state. Group names (e.g. residue names)",
    "in the reference file should correspond to the group names",
    "as used in the [TT]-groups[tt] file, but a appended number",
    "(e.g. residue number) in the [TT]-groups[tt] will be ignored",
    "in the comparison."
  };
  static gmx_bool bSum=FALSE;
  static gmx_bool bMeanEmtx=TRUE;
  static int  skip=0,nlevels=20;
  static real cutmax=1e20,cutmin=-1e20,reftemp=300.0;
  static gmx_bool bCoulSR=TRUE,bCoulLR=FALSE,bCoul14=FALSE;
  static gmx_bool bLJSR=TRUE,bLJLR=FALSE,bLJ14=FALSE,bBhamSR=FALSE,bBhamLR=FALSE,
    bFree=TRUE;
  t_pargs pa[] = {
    { "-sum",  FALSE, etBOOL, {&bSum},
      "Sum the energy terms selected rather than display them all" },
    { "-skip", FALSE, etINT,  {&skip},
      "Skip number of frames between data points" },
    { "-mean", FALSE, etBOOL, {&bMeanEmtx},
      "with [TT]-groups[tt] extracts matrix of mean energies instead of "
      "matrix for each timestep" },
    { "-nlevels", FALSE, etINT, {&nlevels},"number of levels for matrix colors"},
    { "-max",FALSE, etREAL, {&cutmax},"max value for energies"},
    { "-min",FALSE, etREAL, {&cutmin},"min value for energies"},
    { "-coul", FALSE, etBOOL, {&bCoulSR},"extract Coulomb SR energies"},
    { "-coulr", FALSE, etBOOL, {&bCoulLR},"extract Coulomb LR energies"},
    { "-coul14",FALSE, etBOOL, {&bCoul14},"extract Coulomb 1-4 energies"},
    { "-lj", FALSE, etBOOL, {&bLJSR},"extract Lennard-Jones SR energies"},
    { "-lj", FALSE, etBOOL, {&bLJLR},"extract Lennard-Jones LR energies"},
    { "-lj14",FALSE, etBOOL, {&bLJ14},"extract Lennard-Jones 1-4 energies"},
    { "-bhamsr",FALSE, etBOOL, {&bBhamSR},"extract Buckingham SR energies"},
    { "-bhamlr",FALSE, etBOOL, {&bBhamLR},"extract Buckingham LR energies"},
    { "-free",FALSE, etBOOL, {&bFree},"calculate free energy"},
    { "-temp",FALSE, etREAL, {&reftemp},
      "reference temperature for free energy calculation"}
  };
  /* We will define egSP more energy-groups: 
     egTotal (total energy) */
#define egTotal egNR
#define egSP 1
  gmx_bool       egrp_use[egNR+egSP];
  ener_file_t in;
  FILE       *out;
  int        timecheck=0;
  gmx_enxnm_t *enm=NULL;
  t_enxframe *fr;
  int        teller=0;
  real       sum;
  gmx_bool       bCont,bRef;
  gmx_bool       bCutmax,bCutmin;
  real       **eneset,*time=NULL;
  int        *set,i,j,k,prevk,m=0,n,nre,nset,nenergy;
  char       **groups = NULL;
  char       groupname[255],fn[255];
  int        ngroups;
  t_rgb      rlo,rhi,rmid;
  real       emax,emid,emin;
  real       ***emat,**etot,*groupnr;
  double     beta,expE,**e,*eaver,*efree=NULL,edum;
  char       label[234];
  char       **ereflines,**erefres=NULL;
  real       *eref=NULL,*edif=NULL;
  int        neref=0;
  output_env_t oenv;

  t_filenm   fnm[] = {
    { efEDR, "-f", NULL, ffOPTRD },
    { efDAT, "-groups", "groups.dat", ffREAD },
    { efDAT, "-eref",   "eref.dat", ffOPTRD },
    { efXPM, "-emat",   "emat", ffWRITE },
    { efXVG, "-etot",   "energy", ffWRITE }
  };
#define NFILE asize(fnm)

  CopyRight(stderr,argv[0]);
  parse_common_args(&argc,argv,PCA_CAN_VIEW | PCA_CAN_TIME | PCA_BE_NICE,
		    NFILE,fnm,asize(pa),pa,asize(desc),desc,0,NULL,&oenv);
  
  egrp_use[egCOULSR]=bCoulSR;
  egrp_use[egLJSR]=bLJSR;
  egrp_use[egBHAMSR]=bBhamSR;
  egrp_use[egCOULLR]=bCoulLR;
  egrp_use[egLJLR]=bLJLR;
  egrp_use[egBHAMLR]=bBhamLR;
  egrp_use[egCOUL14]=bCoul14;
  egrp_use[egLJ14]=bLJ14;
  egrp_use[egTotal]=TRUE;
  
  bRef=opt2bSet("-eref",NFILE,fnm);
  in=open_enx(ftp2fn(efEDR,NFILE,fnm),"r");
  do_enxnms(in,&nre,&enm);
  
  if (nre == 0)
    gmx_fatal(FARGS,"No energies!\n");
  
  bCutmax=opt2parg_bSet("-max",asize(pa),pa);
  bCutmin=opt2parg_bSet("-min",asize(pa),pa);

  nenergy = 0;

  /* Read groupnames from input file and construct selection of 
     energy groups from it*/
  
  fprintf(stderr,"Will read groupnames from inputfile\n");
  ngroups = get_lines(opt2fn("-groups",NFILE,fnm), &groups);
  fprintf(stderr,"Read %d groups\n",ngroups);
  snew(set,sqr(ngroups)*egNR/2);
  n=0;
  prevk=0;
  for (i=0; (i<ngroups); i++) {
    fprintf(stderr,"\rgroup %d",i);
    for (j=i; (j<ngroups); j++)
      for(m=0; (m<egNR); m++) 
	if (egrp_use[m]) {
	  sprintf(groupname,"%s:%s-%s",egrp_nm[m],groups[i],groups[j]);
#ifdef DEBUG
	  fprintf(stderr,"\r%-15s %5d",groupname,n);
#endif
	  for(k=prevk; (k<prevk+nre); k++)
	    if (strcmp(enm[k%nre].name,groupname) == 0) {
	      set[n++] = k;
	      break;
	    }
	  if (k==prevk+nre)
	    fprintf(stderr,"WARNING! could not find group %s (%d,%d)"
		    "in energy file\n",groupname,i,j);
	  else
	    prevk = k;
	}
  }
  fprintf(stderr,"\n");
  nset=n;
  snew(eneset,nset+1);
  fprintf(stderr,"Will select half-matrix of energies with %d elements\n",n);

  /* Start reading energy frames */  
  snew(fr,1);
  do {
    do {
      bCont=do_enx(in,fr);
      if (bCont)
	timecheck=check_times(fr->t);
    } while (bCont && (timecheck < 0));
    
    if (timecheck == 0) {
#define DONTSKIP(cnt) (skip) ? ((cnt % skip) == 0) : TRUE
      
      if (bCont) {
	fprintf(stderr,"\rRead frame: %d, Time: %.3f",teller,fr->t);
	
	if ((nenergy % 1000) == 0) {
	  srenew(time,nenergy+1000);
	  for(i=0; (i<=nset); i++)
	    srenew(eneset[i],nenergy+1000);
	}
	time[nenergy] = fr->t;
	sum=0;
	for(i=0; (i<nset); i++) {
	  eneset[i][nenergy] = fr->ener[set[i]].e;
	  sum += fr->ener[set[i]].e;
	}
	if (bSum) 
	  eneset[nset][nenergy] = sum;
	nenergy++;
      }
      teller++;
    }
  } while (bCont && (timecheck == 0));
  
  fprintf(stderr,"\n");

  fprintf(stderr,"Will build energy half-matrix of %d groups, %d elements, "
	  "over %d frames\n",ngroups,nset,nenergy);
  
  snew(emat,egNR+egSP);
  for(j=0; (j<egNR+egSP); j++)
    if (egrp_use[m]) {
      snew(emat[j],ngroups);
      for (i=0; (i<ngroups); i++)
	snew(emat[j][i],ngroups);
    }
  snew(groupnr,ngroups);
  for (i=0; (i<ngroups); i++)
    groupnr[i] = i+1;
  rlo.r  = 1.0, rlo.g  = 0.0, rlo.b  = 0.0;
  rmid.r = 1.0, rmid.g = 1.0, rmid.b = 1.0;
  rhi.r  = 0.0, rhi.g  = 0.0, rhi.b  = 1.0;
  if (bMeanEmtx) {
    snew(e,ngroups);
    for (i=0; (i<ngroups); i++) 
      snew(e[i],nenergy);
    n = 0;
    for (i=0; (i<ngroups); i++) {
      for (j=i; (j<ngroups); j++) {
	for (m=0; (m<egNR); m++) {
	  if (egrp_use[m]) {
	    for (k=0; (k<nenergy); k++) {
	      emat[m][i][j] += eneset[n][k];
	      e[i][k] += eneset[n][k];/* *0.5; */
	      e[j][k] += eneset[n][k];/* *0.5; */
	    }
	    n++;
	    emat[egTotal][i][j]+=emat[m][i][j];
	    emat[m][i][j]/=nenergy;
	    emat[m][j][i]=emat[m][i][j];
	  }
	}
	emat[egTotal][i][j]/=nenergy;
	emat[egTotal][j][i]=emat[egTotal][i][j];
      }
    }
    if (bFree) {
      if (bRef) {
	fprintf(stderr,"Will read reference energies from inputfile\n");
	neref = get_lines(opt2fn("-eref",NFILE,fnm), &ereflines);
	fprintf(stderr,"Read %d reference energies\n",neref);
	snew(eref, neref);
	snew(erefres, neref);
	for(i=0; (i<neref); i++) {
	  snew(erefres[i], 5);
	  sscanf(ereflines[i],"%s %lf",erefres[i],&edum);
	  eref[i] = edum;
	}
      }
      snew(eaver,ngroups);
      for (i=0; (i<ngroups); i++) {
	for (k=0; (k<nenergy); k++)
	  eaver[i] += e[i][k];
	eaver[i] /= nenergy;
      }
      beta = 1.0/(BOLTZ*reftemp);
      snew(efree,ngroups);
      snew(edif,ngroups);
      for (i=0; (i<ngroups); i++) {
	expE=0;
	for (k=0; (k<nenergy); k++) {
	  expE += exp(beta*(e[i][k]-eaver[i]));
	}
	efree[i] = log(expE/nenergy)/beta + eaver[i];
	if (bRef) {
	  n = search_str2(neref,erefres,groups[i]);
	  if (n != -1) {
	    edif[i] = efree[i]-eref[n];
	  } else {
	    edif[i] = efree[i];
	    fprintf(stderr,"WARNING: group %s not found "
		    "in reference energies.\n",groups[i]);
	  }
	} else 
	  edif[i]=0;
      }
    }
   
    emid = 0.0;/*(emin+emax)*0.5;*/
    for(m=0; (m<egNR); m++)
      egrp_nm[m]=egrp_nm[m];
    egrp_nm[egTotal]="total";
    for (m=0; (m<egNR+egSP); m++) 
      if (egrp_use[m]) {
	emin=1e10;
	emax=-1e10;
	for (i=0; (i<ngroups); i++) {
	  for (j=i; (j<ngroups); j++) {
	    if (emat[m][i][j] > emax)
	      emax=emat[m][i][j];
	    else if (emat[m][i][j] < emin)
	      emin=emat[m][i][j];
	  }
	}
	if (emax==emin)
	  fprintf(stderr,"Matrix of %s energy is uniform at %f "
		  "(will not produce output).\n",egrp_nm[m],emax);
	else {
	  fprintf(stderr,"Matrix of %s energy ranges from %f to %f\n",
		  egrp_nm[m],emin,emax);
	  if ((bCutmax) || (emax>cutmax)) emax=cutmax;
	  if ((bCutmin) || (emin<cutmin)) emin=cutmin;
	  if ((emax==cutmax) || (emin==cutmin))
	    fprintf(stderr,"Energy range adjusted: %f to %f\n",emin,emax);
	  
	  sprintf(fn,"%s%s",egrp_nm[m],ftp2fn(efXPM,NFILE,fnm));
	  sprintf(label,"%s Interaction Energies",egrp_nm[m]);
	  out=ffopen(fn,"w");
	  if (emin>=emid)
	    write_xpm(out,0,label,"Energy (kJ/mol)",
		      "Residue Index","Residue Index",
		      ngroups,ngroups,groupnr,groupnr,emat[m],
		      emid,emax,rmid,rhi,&nlevels);
	  else if (emax<=emid)
	    write_xpm(out,0,label,"Energy (kJ/mol)",
		      "Residue Index","Residue Index",
		      ngroups,ngroups,groupnr,groupnr,emat[m],
		      emin,emid,rlo,rmid,&nlevels);
	  else
	    write_xpm3(out,0,label,"Energy (kJ/mol)",
		       "Residue Index","Residue Index",
		       ngroups,ngroups,groupnr,groupnr,emat[m],
		       emin,emid,emax,rlo,rmid,rhi,&nlevels);
	  ffclose(out);
	}
      }
    snew(etot,egNR+egSP);
    for (m=0; (m<egNR+egSP); m++) {
      snew(etot[m],ngroups);
      for (i=0; (i<ngroups); i++) {
	for (j=0; (j<ngroups); j++) 
	  etot[m][i]+=emat[m][i][j];
      }
    }

    out=xvgropen(ftp2fn(efXVG,NFILE,fnm),"Mean Energy","Residue","kJ/mol",
                 oenv);
    xvgr_legend(out,0,NULL, oenv);
    j=0;
    for (m=0; (m<egNR+egSP); m++) 
      if (egrp_use[m])
	fprintf(out,"@ legend string %d \"%s\"\n",j++,egrp_nm[m]);
    if (bFree)
      fprintf(out,"@ legend string %d \"%s\"\n",j++,"Free");
    if (bFree)
      fprintf(out,"@ legend string %d \"%s\"\n",j++,"Diff");
    fprintf(out,"@TYPE xy\n");
    fprintf(out,"#%3s","grp");
    for (m=0; (m<egNR+egSP); m++)
      if (egrp_use[m])
	fprintf(out," %9s",egrp_nm[m]);
    if (bFree)
      fprintf(out," %9s","Free");
    if (bFree)
      fprintf(out," %9s","Diff");
    fprintf(out,"\n");
    for (i=0; (i<ngroups); i++) {
      fprintf(out,"%3.0f",groupnr[i]);
      for (m=0; (m<egNR+egSP); m++)
	if (egrp_use[m])
	  fprintf(out," %9.5g",etot[m][i]);
      if (bFree)
	fprintf(out," %9.5g",efree[i]);
      if (bRef)
	fprintf(out," %9.5g",edif[i]);
      fprintf(out,"\n");
    }
    ffclose(out);
  } else {
    fprintf(stderr,"While typing at your keyboard, suddenly...\n"
	    "...nothing happens.\nWARNING: Not Implemented Yet\n");
/*
    out=ftp2FILE(efMAT,NFILE,fnm,"w");
    n=0;
    emin=emax=0.0;
    for (k=0; (k<nenergy); k++) {
      for (i=0; (i<ngroups); i++)
	for (j=i+1; (j<ngroups); j++)
	  emat[i][j]=eneset[n][k];
      sprintf(label,"t=%.0f ps",time[k]);
      write_matrix(out,ngroups,1,ngroups,groupnr,emat,label,emin,emax,nlevels);
      n++;
    }
    ffclose(out);
*/
  }
  close_enx(in);
  
  thanx(stderr);
  
  return 0;
}
