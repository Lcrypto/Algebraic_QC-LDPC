#ifndef __IMPRIMINDO_H__
#define __IMPRIMINDO_H__
#include <stdio.h>
#include <stdlib.h>

short int LimpandoVetorShort(short int Vetor[],short int Nupla)
{
	short int i;

	
	for(i=0;i<Nupla;i++)
	{
		Vetor[i]=0;
	}

	return 0;
}



short int ImprimindoVetorShort(short int Vetor[],short int Nupla)
{
	short int i;

	
	for(i=0;i<Nupla;i++)
	{
		putchar(Vetor[i]+'0');
	}
	putchar('\n');

	return 0;
}


short int OrdenaLinha(short int *Linha,short int Pontos)
{
	short int i,j;
	short int tmp;
	
	for(j=0;j<Pontos;j++)
	{
		for(i=1;i<(Pontos-j);i++)
		{
			if(Linha[i]<Linha[i-1]) 
			{
				tmp=Linha[i];
				Linha[i]=Linha[i-1];
				Linha[i-1]=tmp;
			}
		}
	}

	return 0;
}

short int ImprimindoLinha(short int Vetor[],short int Nupla)
{
	short int i;

	
	for(i=0;i<Nupla;i++)
	{
		printf("%hd\t",Vetor[i]);
	}
	putchar('\n');

	return 0;
}

short int FileImprimindoLinha(FILE *fd,short int Vetor[],short int Nupla)
{
	short int i;
	
	if(fd==NULL) return -1;
	
	for(i=0;i<Nupla;i++)
	{
		fprintf(fd,"%hd\t",Vetor[i]);
	}
	fprintf(fd,"\n");

	return 0;
}



#endif
