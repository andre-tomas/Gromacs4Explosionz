/*
 *                This source code is part of
 *
 *                 G   R   O   M   A   C   S
 *
 * Copyright (c) 1991-2000, University of Groningen, The Netherlands.
 * Copyright (c) 2001-2009, The GROMACS Development Team
 *
 * Gromacs is a library for molecular simulation and trajectory analysis,
 * written by Erik Lindahl, David van der Spoel, Berk Hess, and others - for
 * a full list of developers and information, check out http://www.gromacs.org
 *
 * This program is free software; you can redistribute it and/or modify it under 
 * the terms of the GNU Lesser General Public License as published by the Free 
 * Software Foundation; either version 2 of the License, or (at your option) any 
 * later version.
 * As a special exception, you may use this file as part of a free software
 * library without restriction.  Specifically, if other files instantiate
 * templates or use macros or inline functions from this file, or you compile
 * this file and link it with other files to produce an executable, this
 * file does not by itself cause the resulting executable to be covered by
 * the GNU Lesser General Public License.  
 *
 * In plain-speak: do not worry about classes/macros/templates either - only
 * changes to the library have to be LGPL, not an application linking with it.
 *
 * To help fund GROMACS development, we humbly ask that you cite
 * the papers people have written on it - you can find them on the website!
 */
#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <math.h>

#include "vec.h"
#ifdef GMX_THREAD_SHM_FDECOMP
#include "thread_mpi.h"
#endif

#include "nb_kernel110.h"

/*
 * Gromacs nonbonded kernel nb_kernel110
 * Coulomb interaction:     Normal Coulomb
 * VdW interaction:         Lennard-Jones
 * water optimization:      No
 * Calculate forces:        yes
 */
double debye_length;

double *epsilon_array;
double *sigma_array;
int *ATOM_Z;

float poly3(float p1, float p2, float p3, float p4, int x)
{
    return p1 * pow(x, 3) + p2 * pow(x, 2) + p3 * x + p4;
};

float poly1(float p1, float p2, int x)
{
    return (x == 0) ? 0.0 : p1 * x + p2;
};

float scaleRmin(int Z, int charge)
{
    int e = Z - charge;
    float p1 = 0;
    float p2 = 0;
    float p3 = 0;
    float p4 = 0;

    switch (Z)
    {

 	case 1:
        p1 = 0;
        p2 = 0;
        p3 = 0;
        p4 = 1;
        break;
    case 6:
        p1 = 0.004985;
        p2 = -0.04608;
        p3 = 0.2332;
        p4 = 0.1831;
        break;
    case 7:
        p1 = 0.004306;
        p2 = -0.04864;
        p3 = 0.2493;
        p4 = 0.161;
        break;
    case 8:
        p1 = 0.0033;
        p2 = -0.04291;
        p3 = 0.2366;
        p4 = 0.1633;
        break;
    case 11:
        p1 = 0.002899;
        p2 = -0.04709;
        p3 = 0.2532;
        p4 = 0.05435;
        break;
    case 16:
        p1 = 0.0004371;
        p2 = -0.008512;
        p3 = 0.07822;
        p4 = 0.2666;
        break;
    case 17:
        p1 = 0.000274;
        p2 = -0.005513;
        p3 = 0.05835;
        p4 = 0.2547;
        break;
    }
    return poly3(p1, p2, p3, p4, e);
};

float scaleEpsilon(int Z, int charge)
{
    int e = Z - charge;
    float p1 = 0;
    float p2 = 0;
    switch (Z)
    {
	case 1:
        p1 = 0;
        p2 = 1;
        break;
    case 6:
        p1 = 0.1096;
        p2 = 0.3422;
        break;
    case 7:
        p1 = 0.09189;
        p2 = 0.3567;
        break;
    case 8:
        p1 = 0.079;
        p2 = 0.3679;
        break;
    case 11:
        p1 = 0.06471;
        p2 = 0.2822;
        break;
    case 16:
        p1 = 0.04305;
        p2 = 0.3499;
        break;
    case 17:
        p1 = 0.04093;
        p2 = 0.2997;
        break;
    }
    return poly1(p1, p2, e);
};

// Below is the kernel computation - the actual calculation of non-bonded interactions.

void nb_kernel110(
                    int *           p_nri,
                    int *           iinr,
                    int *           jindex,
                    int *           jjnr,
                    int *           shift,
                    real *          shiftvec,
                    real *          fshift,
                    int *           gid,
                    real *          pos,
                    real *          faction,
                    real *          charge,
                    real *          p_facel,
                    real *          p_krf,
                    real *          p_crf,
                    real *          Vc,
                    int *           type,
                    int *           p_ntype,
                    real *          vdwparam,
                    real *          Vvdw,
                    real *          p_tabscale,
                    real *          VFtab,
                    real *          invsqrta,
                    real *          dvda,
                    real *          p_gbtabscale,
                    real *          GBtab,
                    int *           p_nthreads,
                    int *           count,
                    void *          mtx,
                    int *           outeriter,
                    int *           inneriter,
                    real *          work)
{
    int           nri,ntype,nthreads;
    real          facel,krf,crf,tabscale,gbtabscale;
    int           n,ii,is3,ii3,k,nj0,nj1,jnr,j3,ggid;
    int           nn0,nn1,nouter,ninner;
    real          shX,shY,shZ;
    real          fscal,tx,ty,tz;
    real          rinvsq, r;
    real          iq;
    real          qq,vcoul,vctot;
    int           nti;
    int           tj;
    real          rinvsix;
    real          Vvdw6,Vvdwtot;
    real          Vvdw12;
    real          ix1,iy1,iz1,fix1,fiy1,fiz1;
    real          jx1,jy1,jz1;
    real          dx11,dy11,dz11,rsq11,rinv11;
    real          c6,c12;

    nri              = *p_nri;         
    ntype            = *p_ntype;       
    nthreads         = *p_nthreads;    
    facel            = *p_facel;       
    krf              = *p_krf;         
    crf              = *p_crf;         
    tabscale         = *p_tabscale;  
	double sigmas;
	double epsilons;
	double sigma6;
    float rmin;
	double sigma1;
	double epsilon1;
	double sigma2;
	double epsilon2;

    /* Reset outer and inner iteration counters */
    nouter           = 0;              
    ninner           = 0;              

    /* Loop over thread workunits */

// printf("c6[i]= %lf,c12[i]= %lf, ATOM_Z[i]= %i \n",sigma_array[0],epsilon_array[0],ATOM_Z[0]);
// printf("c6[i]= %lf,c12[i]= %lf, ATOM_Z[i]= %i \n",sigma_array[1],epsilon_array[1],ATOM_Z[1]);

	//exit(0);
	debye_length = 1000;
    
    do
    {
#ifdef GMX_THREAD_SHM_FDECOMP
        tMPI_Thread_mutex_lock((tMPI_Thread_mutex_t *)mtx);
        nn0              = *count;         
		
        /* Take successively smaller chunks (at least 10 lists) */
        nn1              = nn0+(nri-nn0)/(2*nthreads)+10;
        *count           = nn1;            
        tMPI_Thread_mutex_unlock((tMPI_Thread_mutex_t *)mtx);
        if(nn1>nri) nn1=nri;
#else
	    nn0 = 0;
		nn1 = nri;
#endif
        /* Start outer loop over neighborlists */

		//printf("Hi im in nb_kernel110\n");
        //printf("DEBYE LENGTH IN nbkernel110.c: %lf\n", debye_length);
        
        for(n=nn0; (n<nn1); n++)
        {

            /* Load shift vector for this list */
            is3              = 3*shift[n];     
            shX              = shiftvec[is3];  
            shY              = shiftvec[is3+1];
            shZ              = shiftvec[is3+2];

            /* Load limits for loop over neighbors */
            nj0              = jindex[n];      
            nj1              = jindex[n+1];    

            /* Get outer coordinate index */
            ii               = iinr[n];        
            ii3              = 3*ii;           

            /* Load i atom data, add shift vector */
            ix1              = shX + pos[ii3+0];
            iy1              = shY + pos[ii3+1];
            iz1              = shZ + pos[ii3+2];

            /* Load parameters for i atom */
            iq               = facel*(charge[ii]);
            nti              = 2*ntype*type[ii];

            /* Zero the potential energy for this list */
            vctot            = 0;              
            Vvdwtot          = 0;              

            /* Clear i atom forces */
            fix1             = 0;              
            fiy1             = 0;              
            fiz1             = 0;       

            /* Calculate new sigma and epsilon based on charge and atomic number Z */
			sigma1 = (sigma_array[type[ii]])*scaleRmin(ATOM_Z[type[ii]], floor(charge[ii]));
			epsilon1 = (epsilon_array[type[ii]]) * scaleEpsilon(ATOM_Z[type[ii]], floor(charge[ii]));

			//printf("sigma1: %6.4lf, atomz: %i, charge: %lf \n", sigma1,ATOM_Z[type[ii]], charge[ii]);
			//printf("epsilon1: %6.4lf\n", epsilon1);

			//exit(0);
            for(k=nj0; (k<nj1); k++)
            {

                /* Get j neighbor index, and coordinate index */
                jnr              = jjnr[k];        
                j3               = 3*jnr;          

                /* load j atom coordinates */
                jx1              = pos[j3+0];      
                jy1              = pos[j3+1];      
                jz1              = pos[j3+2];      

                /* Calculate distance */
                dx11             = ix1 - jx1;      
                dy11             = iy1 - jy1;      
                dz11             = iz1 - jz1;      
                rsq11            = dx11*dx11+dy11*dy11+dz11*dz11;

                /* Calculate 1/r and 1/r2 */
                rinv11           = gmx_invsqrt(rsq11);
				r 				 = rsq11*rinv11;

                /* Load parameters for j atom */
                qq               = iq*(charge[jnr]); 
                tj               = nti+2*type[jnr];
                c6               = vdwparam[tj];   
                c12              = vdwparam[tj+1]; 
                rinvsq           = rinv11*rinv11;

				//printf("TYPE1: %i, TYPE2: %i, LJ PARAM inN nbkernel110.c: c6 : %lf, c12 : %lf\n",type[ii],type[jnr], c6, c12); 

                /* Coulomb interaction */
                //vcoul            = qq*rinv11;   
				vcoul            = qq*rinv11*((r + debye_length)/(debye_length))*exp((-r)/debye_length);   
				//fscal            = vcoul*rinvsq*((r + debye_length)/(debye_length));           
                vctot            = vctot+vcoul;    

            	/* Calculate new sigma and epsilon based on charge and atomic number Z */
			
				if ( (ATOM_Z[type[jnr]]==1 && charge[jnr] == 1) || (ATOM_Z[type[ii]]==1 && charge[ii] ==1))	{

					c6 = 0;
					c12 = 0;
				}
			
				else {
	
				if (type[ii] == type[jnr] && charge[ii]==charge[jnr]) {
					sigmas = sigma1;
					epsilons = epsilon1;

				}

				else {
					sigma2 = (sigma_array[type[jnr]])*scaleRmin(ATOM_Z[type[jnr]], floor(charge[jnr]));
					epsilon2 = (epsilon_array[type[jnr]]) * scaleEpsilon(ATOM_Z[type[jnr]], floor(charge[jnr]));

					sigmas = 0.5*(sigma1 + sigma2);
					epsilons = pow(epsilon1*epsilon2, 0.5);
				}
				
				sigma6 = pow(sigmas, 6);
				c6 = 4*epsilons*sigma6;
				c12 = 4*epsilons*sigma6*sigma6; // write c12 = c6*sigma6

				}

				//printf("c6: %lf, c12: %lf, chargeii: %lf, chargejnr: %lf, chargeii: %lf, chargejnr: %lf \n", c6, c12, charge[ii], charge[jnr], floor(charge[ii]), floor(charge[jnr]));
	
				c6 = 0;
				c12 = 0;

				//sigma_array[type[ii]],epsilon_array[type[ii]],ATOM_Z[type[ii]];
				//sigma_array[type[jnr]],epsilon_array[type[jnr]],ATOM_Z[type[jnr]];

				//printf("TYPE1: %i, TYPE2: %i, LJ PARAM inN nbkernel110.c: c6 : %lf, c12 : %lf\n",type[ii],type[jnr], c6, c12); 

                /* Lennard-Jones interaction */
				if (c6 > 0) {
                rinvsix          = rinvsq*rinvsq*rinvsq;
                Vvdw6            = c6*rinvsix;     
                Vvdw12           = c12*rinvsix*rinvsix;
                Vvdwtot          = Vvdwtot+Vvdw12-Vvdw6;
                //fscal            = (vcoul+12.0*Vvdw12-6.0*Vvdw6)*rinvsq;
                fscal            = (vcoul+12.0*Vvdw12-6.0*Vvdw6)*rinvsq;

				}
				else {
     
                Vvdwtot          = 0;
                //fscal            = (vcoul+12.0*Vvdw12-6.0*Vvdw6)*rinvsq;
                fscal            = (vcoul)*rinvsq;
			
				}

       		    //printf("LJ PARAM inN nbkernel110.c: c6 : %lf, c12 : %lf\n", c6, c12);

                /* Calculate temporary vectorial force */
                tx               = fscal*dx11;     
                ty               = fscal*dy11;     
                tz               = fscal*dz11;     

                /* Increment i atom force */
                fix1             = fix1 + tx;      
                fiy1             = fiy1 + ty;      
                fiz1             = fiz1 + tz;      

                /* Decrement j atom force */
                faction[j3+0]    = faction[j3+0] - tx;
                faction[j3+1]    = faction[j3+1] - ty;
                faction[j3+2]    = faction[j3+2] - tz;

                /* Inner loop uses 38 flops/iteration */
            }
            

            /* Add i forces to mem and shifted force list */
            faction[ii3+0]   = faction[ii3+0] + fix1;
            faction[ii3+1]   = faction[ii3+1] + fiy1;
            faction[ii3+2]   = faction[ii3+2] + fiz1;
            fshift[is3]      = fshift[is3]+fix1;
            fshift[is3+1]    = fshift[is3+1]+fiy1;
            fshift[is3+2]    = fshift[is3+2]+fiz1;

            /* Add potential energies to the group for this list */
            ggid             = gid[n];         
            Vc[ggid]         = Vc[ggid] + vctot;
            Vvdw[ggid]       = Vvdw[ggid] + Vvdwtot;

            /* Increment number of inner iterations */
            ninner           = ninner + nj1 - nj0;

            /* Outer loop uses 12 flops/iteration */
        }
        

        /* Increment number of outer iterations */
        nouter           = nouter + nn1 - nn0;
    }
    while (nn1<nri);
    

    /* Write outer/inner iteration count to pointers */
    *outeriter       = nouter;         
    *inneriter       = ninner;         
}





/*
 * Gromacs nonbonded kernel nb_kernel110nf
 * Coulomb interaction:     Normal Coulomb
 * VdW interaction:         Lennard-Jones
 * water optimization:      No
 * Calculate forces:        no
 */
void nb_kernel110nf(
                    int *           p_nri,
                    int *           iinr,
                    int *           jindex,
                    int *           jjnr,
                    int *           shift,
                    real *          shiftvec,
                    real *          fshift,
                    int *           gid,
                    real *          pos,
                    real *          faction,
                    real *          charge,
                    real *          p_facel,
                    real *          p_krf,
                    real *          p_crf,
                    real *          Vc,
                    int *           type,
                    int *           p_ntype,
                    real *          vdwparam,
                    real *          Vvdw,
                    real *          p_tabscale,
                    real *          VFtab,
                    real *          invsqrta,
                    real *          dvda,
                    real *          p_gbtabscale,
                    real *          GBtab,
                    int *           p_nthreads,
                    int *           count,
                    void *          mtx,
                    int *           outeriter,
                    int *           inneriter,
                    real *          work)
{
    int           nri,ntype,nthreads;
    real          facel,krf,crf,tabscale,gbtabscale;
    int           n,ii,is3,ii3,k,nj0,nj1,jnr,j3,ggid;
    int           nn0,nn1,nouter,ninner;
    real          shX,shY,shZ;
    real          rinvsq;
    real          iq;
    real          qq,vcoul,vctot;
    int           nti;
    int           tj;
    real          rinvsix;
    real          Vvdw6,Vvdwtot;
    real          Vvdw12;
    real          ix1,iy1,iz1;
    real          jx1,jy1,jz1;
    real          dx11,dy11,dz11,rsq11,rinv11;
    real          c6,c12;

    nri              = *p_nri;         
    ntype            = *p_ntype;       
    nthreads         = *p_nthreads;    
    facel            = *p_facel;       
    krf              = *p_krf;         
    crf              = *p_crf;         
    tabscale         = *p_tabscale;    

    /* Reset outer and inner iteration counters */
    nouter           = 0;              
    ninner           = 0;              

    /* Loop over thread workunits */
    
    do
    {
#ifdef GMX_THREAD_SHM_FDECOMP
        tMPI_Thread_mutex_lock((tMPI_Thread_mutex_t *)mtx);
        nn0              = *count;         
		
        /* Take successively smaller chunks (at least 10 lists) */
        nn1              = nn0+(nri-nn0)/(2*nthreads)+10;
        *count           = nn1;            
        tMPI_Thread_mutex_unlock((tMPI_Thread_mutex_t *)mtx);
        if(nn1>nri) nn1=nri;
#else
	    nn0 = 0;
		nn1 = nri;
#endif
        /* Start outer loop over neighborlists */
        
        for(n=nn0; (n<nn1); n++)
        {

            /* Load shift vector for this list */
            is3              = 3*shift[n];     
            shX              = shiftvec[is3];  
            shY              = shiftvec[is3+1];
            shZ              = shiftvec[is3+2];

            /* Load limits for loop over neighbors */
            nj0              = jindex[n];      
            nj1              = jindex[n+1];    

            /* Get outer coordinate index */
            ii               = iinr[n];        
            ii3              = 3*ii;           

            /* Load i atom data, add shift vector */
            ix1              = shX + pos[ii3+0];
            iy1              = shY + pos[ii3+1];
            iz1              = shZ + pos[ii3+2];

            /* Load parameters for i atom */
            iq               = facel*charge[ii];
            nti              = 2*ntype*type[ii];

            /* Zero the potential energy for this list */
            vctot            = 0;              
            Vvdwtot          = 0;              

            /* Clear i atom forces */
            
            for(k=nj0; (k<nj1); k++)
            {

                /* Get j neighbor index, and coordinate index */
                jnr              = jjnr[k];        
                j3               = 3*jnr;          

                /* load j atom coordinates */
                jx1              = pos[j3+0];      
                jy1              = pos[j3+1];      
                jz1              = pos[j3+2];      

                /* Calculate distance */
                dx11             = ix1 - jx1;      
                dy11             = iy1 - jy1;      
                dz11             = iz1 - jz1;      
                rsq11            = dx11*dx11+dy11*dy11+dz11*dz11;

                /* Calculate 1/r and 1/r2 */
                rinv11           = gmx_invsqrt(rsq11);

                /* Load parameters for j atom */
                qq               = iq*charge[jnr]; 
                tj               = nti+2*type[jnr];
                c6               = vdwparam[tj];   
                c12              = vdwparam[tj+1]; 
                rinvsq           = rinv11*rinv11;  

                /* Coulomb interaction */
                vcoul            = qq*rinv11;      
                vctot            = vctot+vcoul;    

                /* Lennard-Jones interaction */
                rinvsix          = rinvsq*rinvsq*rinvsq;
                Vvdw6            = c6*rinvsix;     
                Vvdw12           = c12*rinvsix*rinvsix;
                Vvdwtot          = Vvdwtot+Vvdw12-Vvdw6;

                /* Inner loop uses 24 flops/iteration */
            }
            

            /* Add i forces to mem and shifted force list */

            /* Add potential energies to the group for this list */
            ggid             = gid[n];         
            Vc[ggid]         = Vc[ggid] + vctot;
            Vvdw[ggid]       = Vvdw[ggid] + Vvdwtot;

            /* Increment number of inner iterations */
            ninner           = ninner + nj1 - nj0;

            /* Outer loop uses 6 flops/iteration */
        }
        

        /* Increment number of outer iterations */
        nouter           = nouter + nn1 - nn0;
    }
    while (nn1<nri);
    

    /* Write outer/inner iteration count to pointers */
    *outeriter       = nouter;         
    *inneriter       = ninner;         
}


