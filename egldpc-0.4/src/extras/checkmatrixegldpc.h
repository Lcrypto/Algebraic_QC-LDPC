/*
 * checkmatrixegldpc.h
 * 
 * Copyright 2011 Fernando Pujaico Rivera <fernando.pujaico.rivera@gmail.com>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 */

#ifndef _CHECKMATRIXEGLDPC_H_
#define _CHECKMATRIXEGLDPC_H_

#include <stdlib.h>
#include <config.h>
#include <string.h>


typedef struct
{
	char *Salida;
}DataX;

void ImprimirAyuda(void)
{
	printf("\n");
	printf("check-matrix-egldpc %s\n",VERSION);
	printf("\n");
	printf("\tDRESCRIPCION:\n");
	printf("\t\tVerifica las matrices creadas con %s. Debe ser entregado\n",PACKAGE_NAME);
	printf("\t\tel nombre del archivo de la matriz.\n");
	printf("\t\t\n");
	printf("\tUSO:\t\n");
	printf("\t\n");
	printf("check-matrix-egldpc\t[-v][--in Nombre][--help]\n");
	printf("\n");
	printf("\t-v\n");
	printf("\t\tDevuelve el nombre y versión actual del programa.\n");
	printf("\t\n");
	printf("\t--in Nombre\n");
	printf("\t\tDonde \"Nombre\" es el nombre del archivo que contiene los \n");
	printf("\t\tdatos del código EG-LDPC.\n");
	printf("\t\n");
	printf("\t--help\n");
	printf("\t\tMuestra esta ayuda.\n");
	printf("\t\n");

}

void ImprimirVersion(void)
{
	printf("\ncheck-matrix-egldpc %s\n\n",VERSION);
}

DataX *CargarDatos(int argc,char **argv)
{
	DataX *M=NULL;
	int n,i;

	M=(DataX *)calloc(sizeof(DataX),1);

	M->Salida=NULL;


	if(argc==1) 
	{
		ImprimirAyuda(); 
		exit(EXIT_SUCCESS);
	}

	if( (argc==2) && (strcmp(argv[1],"-v")==0) ) 
	{
		ImprimirVersion(); 
		exit(EXIT_SUCCESS);
	}

	if( (argc==2) && (strcmp(argv[1],"--help")==0) ) 
	{
		ImprimirAyuda(); 
		exit(EXIT_SUCCESS);
	}

	for(i=1;i<argc;i++)
	{

		if(strcmp(argv[i],"--in")==0)
		{
			if(i+1<argc)	
			{
				n=strlen(argv[i+1]);
				M->Salida=(char *)calloc(n+1,1);
				if(M->Salida==NULL)	exit(EXIT_SUCCESS);

				strcpy(M->Salida,argv[i+1]);
			}
			else	
			{
				printf("ERROR: Debes indicar el valor --in Nombre\n");
				exit(EXIT_SUCCESS);
			}
			i++;
		}

	}

	if(M->Salida==NULL)
	{
		printf("ERROR: Debes indicar el valor --in Nombre\n");
		exit(EXIT_SUCCESS);
	}
	printf("\n%s\n",M->Salida);

	n=strlen(M->Salida);
	for(i=0;i<n;i++) printf("=");
	printf("\n\n");

	return M;
}


#endif /* _ARCHIVO_H_H_ */
