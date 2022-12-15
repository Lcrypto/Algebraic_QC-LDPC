/*
 * extras.h
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

#ifndef _EXTRAS_H_
#define _EXTRAS_H_


#include <stdlib.h>
#include <config.h>
#include <string.h>

#ifdef __WIN32__
  #define bzero(a, b) memset(a, 0x0, b)
#endif

typedef struct
{
	int Grau;
	short int  *PolPrimitivoBin;
	short int m;
	short int s;
	char *ArchivoGF2n;
	char *Salida;
}DataM;

void ImprimirAyuda(void)
{
	printf("\n");
	printf("%s\n",PACKAGE_STRING);
	printf("\n");
	printf("\tDRESCRIPCION:\n");
	printf("\t\tCrea un código EG-LDPC tipo-I con un matriz de verificación\n");
	printf("\t\tde paridad H de N columnas y J lineas y una matriz generadora\n");
	printf("\t\tG de K lineas y N columnas, polinomios representarán a las\n");
	printf("\t\tlineas. Estas matrices son creadas a partir de una EG(m,2^s),\n");
	printf("\t\tque es una geometría euclidiana de dimensión \"m\" y \"2^s\"\n");
	printf("\t\tpuntos por dimensión. Es necesario entregar como datos \"m\"\n");
	printf("\t\to \"s\" y el polinomio primitivo generador de la EG, el \n");
	printf("\t\tpolinomio debe tener grado n=m*s, N=2^n-1.\n");
	printf("\t\t\n");
	printf("\tUSO:\t\n");
	printf("\t\n");
	printf("%s\t[-v][-m NumM][-s NumS][--pos-one Pos]\n",PACKAGE_NAME);
	printf("\t\t\t[--out Nombre][--gf2n ArchivoGF2n]\n");
	printf("\t\t\t[--help]\n");
	printf("\n");
	printf("\t-v\n");
	printf("\t\tDevuelve el nombre y versión actual del programa.\n");
	printf("\t\n");
	printf("\t-m NumM\n");
	printf("\t\t\"NumM\" es el valor \"m\" de la EG(m,2^s).\n");
	printf("\t\tSi solo indicas \"m\", \"s\" se calcula como n/m donde \"n\"\n");
	printf("\t\tes el grado del polinomio primitivo.\n");
	printf("\t\n");
	printf("\t-s NumS\n");
	printf("\t\t\"NumS\" es el valor \"s\" de la EG(m,2^s).\n");
	printf("\t\tSi solo indicas \"s\", \"m\" se calcula como n/s donde \"n\"\n");
	printf("\t\tes el grado del polinomio primitivo.\n");
	printf("\t\n");
	printf("\t--pos-one Pos\n");
	printf("\t\t\"Pos\" es la posición de un uno del polinomio primitivo.\n");
	printf("\t\tm*s debe coincidir con \"n\" el grado del polinomio.\n");
	printf("\t\n");
	printf("\t--out Nombre\n");
	printf("\t\tDonde \"Nombre\" es el nombre del archivo que contiene los \n");
	printf("\t\tdatos de la matriz EG-LDPC.\n");
	printf("\t\tPor defecto usa los datos de configuración para generar el\n");
	printf("\t\tnombre.\n");
	printf("\t\n");
	printf("\t--gf2n ArchivoGF2n\n");
	printf("\t\tDonde \"ArchivoGF2n\" es el nombre del archivo de la geometría\n");
	printf("\t\teuclidiana donde se escribe GF*(2^{ms}) en la primera columna\n");
	printf("\t\ty EG*(ms,2) en la segunda [ equivalente EG*(m,2^s) ], para el\n");
	printf("\t\tpolinomio generador indicado con --pos-one. El * indica que el\n");
	printf("\t\telemento cero no esta incluido.\n");
	printf("\t\n");
	printf("\t--help\n");
	printf("\t\tMuestra esta ayuda.\n");
	printf("\t\n");

}

void ImprimirVersion(void)
{
	printf("\n%s\n\n",PACKAGE_STRING);
}

DataM *CargarDatos(int argc,char **argv)
{
	DataM *M=NULL;
	int n,i,II;
	short int dato;
	short int *PolTmp=NULL;
	char tmp[1024];
	char polinomio[256];

	bzero(polinomio,256);
	bzero(tmp,1024);

	M=(DataM *)calloc(sizeof(DataM),1);

	M->ArchivoGF2n=NULL;
	M->Salida=NULL;
	M->Grau=0;
	M->PolPrimitivoBin=NULL;
	M->m=0;
	M->s=0;

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

	II=0;
	for(i=1;i<argc;i++)
	{

		if(strcmp(argv[i],"-m")==0)
		{
			if(i+1<argc)	
			{
				M->m=atoi(argv[i+1]);
			}
			else	
			{
				printf("ERROR: Debes indicar el valor -m NumM\n");
				exit(EXIT_SUCCESS);
			}
			i++;
		}
		else if(strcmp(argv[i],"-s")==0)
		{
			if(i+1<argc)	
			{
				M->s=atoi(argv[i+1]);
			}
			else	
			{
				printf("ERROR: Debes indicar el valor -s NumS\n");
				exit(EXIT_SUCCESS);
			}
			i++;
		}
		else if(strcmp(argv[i],"--pos-one")==0)
		{
			if(i+1<argc)	
			{
				PolTmp=(short int *)realloc(PolTmp,II+1);

				if(PolTmp==NULL)	exit(EXIT_SUCCESS);

				PolTmp[II]=atoi(argv[i+1]);
				II++;
			}
			else	
			{
				printf("ERROR: Debes indicar el valor --pos-one Pos\n");
				exit(EXIT_SUCCESS);
			}
			i++;
		}
		else if(strcmp(argv[i],"--out")==0)
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
				printf("ERROR: Debes indicar el valor --out Nombre\n");
				exit(EXIT_SUCCESS);
			}
			i++;
		}
		else if(strcmp(argv[i],"--gf2n")==0)
		{
			if(i+1<argc)	
			{
				n=strlen(argv[i+1]);
				M->ArchivoGF2n=(char *)calloc(n+1,1);
				if(M->ArchivoGF2n==NULL)	exit(EXIT_SUCCESS);

				strcpy(M->ArchivoGF2n,argv[i+1]);
			}
			else	
			{
				printf("ERROR: Debes indicar el valor --gf2n ArchivoGF2n\n");
				exit(EXIT_SUCCESS);
			}
			i++;
		}

	}

	if(PolTmp==NULL)
	{
		printf("ERROR: Debes indicar el polinomio primitivo con --pos-ones\n");
		exit(EXIT_SUCCESS);
	}
	else
	{
		for(i=1;i<II;i++)
		{
			if(PolTmp[i]<PolTmp[i-1])
			{
				dato=PolTmp[i-1];
				PolTmp[i-1]=PolTmp[i];
				PolTmp[i]=dato;
			}
		}
		M->Grau=PolTmp[II-1];// Aquí cargo el grado del polinomio primitivo.

		M->PolPrimitivoBin=(short int *)calloc(M->Grau+1,sizeof(short int));

		// Aquí cargo el polinomio primitivo.
		for(i=0;i<II;i++)	M->PolPrimitivoBin[PolTmp[i]]=1;
			
	}

	if( (M->m==0)&&(M->s==0) )
	{
		printf("ERROR: Debes indicar el valor -m NumM o -s NumS.\n");
		exit(EXIT_SUCCESS);
	}

	if( (M->m==0))
	{
		M->m=M->Grau/M->s;
		if(M->m==0)
		{
			printf("ERROR: El valor \"m\" calculado salió 0.\n");
			exit(EXIT_SUCCESS);
		}
		if(M->m==1)
		{
			printf("ERROR: El valor \"m\" calculado salió 1, es 2 como minimo.\n");
			exit(EXIT_SUCCESS);
		}
	}

	if( (M->s==0))
	{
		M->s=M->Grau/M->m;
		if(M->s==0)
		{
			printf("ERROR: El valor \"s\" calculado salió 0.\n");
			exit(EXIT_SUCCESS);
		}
	}

	printf("m    = %d\n",M->m);
	printf("s    = %d\n",M->s);
	printf("Grado= %d\n",M->Grau);
	if((M->s*M->m)!=M->Grau) 
	{
		printf("ERROR: Hubo una incongruencia m*s debe ser igual al grado del polinomio.\n");
		exit(EXIT_SUCCESS);
	}
	printf("PolPrimitivo= {");
	for(i=0;i<=M->Grau;i++)printf("\t%d",M->PolPrimitivoBin[i]);
	printf("\t}\n");
	printf("PolPrimitivo= ");
	for(i=0;i<=M->Grau;i++)
	{
		if(M->PolPrimitivoBin[i]==1)
		{
			if(i==0)	strcpy(polinomio,"1");
			else		
			{
				sprintf(tmp,"+X^%d%c",i,0);
				strcat(polinomio,tmp);
			}
		}
	}
	printf("%s\n",polinomio);

	if(M->ArchivoGF2n==NULL)
	{
		sprintf(tmp,"GF(2^%d)_%s.gf2n%c",M->Grau,polinomio,0);
		n=strlen(tmp);
		M->ArchivoGF2n=(char *)calloc(n+1,1);
		strncpy(M->ArchivoGF2n,tmp,n);
	}
	printf("GF(2^%d)     = %s\n",M->Grau,M->ArchivoGF2n);

	if(M->Salida==NULL)
	{
		sprintf(tmp,"m%d_s%d_%s.dat%c",M->m,M->s,polinomio,0);
		n=strlen(tmp);
		M->Salida=(char *)calloc(n+1,1);
		strncpy(M->Salida,tmp,n);
	}
	printf("\n%s\n",M->Salida);

	n=strlen(M->Salida);
	for(i=0;i<n;i++) printf("=");
	printf("\n\n");

	return M;
}

#endif /* _EXTRAS_H_ */
