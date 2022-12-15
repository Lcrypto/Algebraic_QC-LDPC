#ifndef __GeneraGF2n__
#define __GeneraGF2n__

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int CorrimientoDireita(short int *Z,short int X[], short int Nupla)
{
	short int i;
	
	for(i=2;i<=Nupla;i++) Z[Nupla-i+1]=X[Nupla-i];
	Z[0]=0;
	return 0;
}


int XorVetorial(short int *Z,short int X[],short int Y[], short int Nupla)
{
	short int i;
	for(i=0;i<Nupla;i++) Z[i]=X[i]^Y[i];
	return 0;
}

int EscreveEmArchivo(char Archivo[],short int Z[],short int m,short int indice)
{
	FILE *fd=NULL;
	short int i;

	fd=fopen(Archivo,"a");

	fprintf(fd,"%d\t",indice);

	for(i=0;i<m;i++)
	{
		fprintf(fd,"%d",Z[i]);
	}
	fprintf(fd,"\n");

	fclose(fd);

	return 0;
}

/*
 Archivo: E' o archivo onde se salvaram os dados
 P: E' o polinomio p(x) na sua forma vetorial
 m: E' o grau do polinomio 
 */
int GeneraGF(char Archivo[],short int P[],short int m)
{

	short int *B=NULL;
	short int i;

	B=(short int *)calloc((m+1),sizeof(short int));
	B[0]=1;

	remove(Archivo);

	i=0;
	EscreveEmArchivo(Archivo,B,m,i);

	do{
	i=i+1;
	CorrimientoDireita(B,B,m+1);

	if(B[m]==1) XorVetorial(B,B,P,m+1);

	EscreveEmArchivo(Archivo,B,m,i);


	}while(i != (((short int)pow(2,m))-2));

	free(B);

	return 0;
}

#endif
