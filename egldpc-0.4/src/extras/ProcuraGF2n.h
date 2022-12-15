#ifndef __ProcuraGF2n__
#define __ProcuraGF2n__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "Imprimindo.h"
#include "GeneraGF2n.h"

/* 
 Dou um Vetor e procuto o Indice

 Archivo: Archivo onde esta a tabela GF(2^n)
 Vetor: N-upla que que conheco
 Nupla: O grau da N-upla

 Retorna: O indice da N-upla ou -1 se nao achou.
 */
short int ProcuraIndiceGF2n(char Archivo[],short int Vetor[],short int Nupla)
{
	FILE *fd=NULL;
	short int i;
	int NN;
	char *V=NULL;
	char *Tmp=NULL;
	short int indice,s=0;

	for(i=0;i<Nupla;i++)
	{
		s=Vetor[i]+s;
	}
	if(s==0) return -1;


	V=(char *)calloc(Nupla+1,sizeof(char));
	Tmp=(char *)calloc(Nupla+1,sizeof(char));

	for(i=0;i<Nupla;i++)
	{
		V[i]=Vetor[i]+'0';
	}

	fd=fopen(Archivo,"r");

	for(i=0;!feof(fd);i++)
	{
		NN=fscanf(fd,"%hd\t%s\n",&indice,Tmp);
		if(strncmp(Tmp,V,Nupla)==0) 
		{
			fclose(fd);
			free(V);
			free(Tmp);
			return indice;
		}
	}

	fclose(fd);

	free(V);
	free(Tmp);

	return -1;
}

/* 
 Dou um Indice e procuro o vetor

 Archivo: Archivo onde esta a tabela GF(2^n)
 Vetor: N-upla que deseja-se Procurar
 Nupla: O grau da N-upla
 Indice: indice do Vetor que procuro

 Retorna: O indice que conheco da N-upla ou -1 se nao achou.
 */
short int ProcuraVetorGF2n(char Archivo[],short int *Vetor,short int Nupla, short int Indice)
{
	FILE *fd=NULL;
	short int i;
	int NN;
	char *Tmp=NULL;
	short int Ind;

	
	if(-1==Indice)
	{ 
		for(i=0;i<Nupla;i++)
		{
			Vetor[i]=0;
		}
		return -1;
	}

	Indice=Indice%((short int)(pow(2,Nupla)-1));

	Tmp=(char *)calloc(Nupla+1,sizeof(char));

	do{
		fd=fopen(Archivo,"r");
	}while(fd==NULL);

	for(i=0;feof(fd)==0;i++)
	{
		NN=fscanf(fd,"%hd\t%s\n",&Ind,Tmp);
		if(Ind==Indice)
		{ 
			for(i=0;i<Nupla;i++)
			{
				Vetor[i]=Tmp[i]-'0';
			}
			fclose(fd);
			free(Tmp);
			return Indice;
		}
	}

	fclose(fd);

	free(Tmp);

	return -1;
}

/*
 Dou o Indice1 e Indice2 fazo a soma vetorial e retorno o indice da soma

 Archivo: Archivo da tabela
 Indice1: Indice do vetor a somar
 Indice2: Indice do vetor a somar

 Retorna: O indice do resultado da soma dos vetores dos indices Indice1 e Indice2
 */
short int ProcuraIndiceDeSomaDeIndicesGF2n(char Archivo[],short int Indice1,short int Indice2 ,short int Nupla)
{
	short int *Vetor1=NULL;
	short int *Vetor2=NULL;
	short int *Vetor3=NULL;
	short int Indice;

	Vetor1=(short int *)calloc(Nupla,sizeof(short int));
	Vetor2=(short int *)calloc(Nupla,sizeof(short int));
	Vetor3=(short int *)calloc(Nupla,sizeof(short int));

	ProcuraVetorGF2n(Archivo,Vetor1,Nupla,Indice1);
	ProcuraVetorGF2n(Archivo,Vetor2,Nupla,Indice2);

	XorVetorial(Vetor3,Vetor1,Vetor2,Nupla);


	Indice=ProcuraIndiceGF2n(Archivo,Vetor3,Nupla);

	free(Vetor1);
	free(Vetor2);
	free(Vetor3);

	return Indice;
}

short int AcheiNegativosNaLinha(short int Linha[],short int PontosPorLinha)
{
	short int i;

	for(i=0;i<PontosPorLinha;i++)
	{
		if(Linha[i]<0) return 1;
	}

	return 0;
}
short int ProcuraIndiceLivreEmGF2n(short int Vetor[],short int Nupla)
{
	short int i;

	for(i=0;i<Nupla;i++)
	{
		if(Vetor[i]==0) return i;
	}

	return -1;
}

short int ProcuraVetoresMinimosDaLinha(short int **Minimo, short int Linha[],short int Pontos,short int Total)
{
	short int i,j;

	// Encuentro os grau de Todos os vetores con corrimientos
	for(i=0;i<Pontos;i++)
	{
		for(j=0;j<Pontos;j++)
		{
			Minimo[i][j]=Linha[j]-Linha[i];
			if(Minimo[i][j]<0) Minimo[i][j]=Minimo[i][j]+Total;
		}
		OrdenaLinha(Minimo[i],Pontos);	
	}


	return 0;
}


short int ProcuraGrauDoVetor(short int Vetor[],short int Nupla)
{
	int i;

	for(i=0;i<Nupla;i++)
	{
		if(Vetor[Nupla-i-1]==1)	return (Nupla-i-1);
	}
	return -1;
}

short int ProcuraGrauDaLinha(short int Linha[],short int PontosPorLinha)
{
	int i,Grau;
	Grau=Linha[0];
	for(i=1;i<PontosPorLinha;i++)
	{
		if(Linha[i]>Grau) Grau=Linha[i];
	}
	return Grau;
}



//Divide Polinomio PolD entre o polinomio PolQ e retorn o Polinomio residuo
short int *ProcuraResiduoDeDivisao(short int *PontosPolRes, short int PolD[],short int PontosPolD,short int PolQ[],short int PontosPolQ)
{
	short int *Soma=NULL;
	short int *PolRes=NULL;
	short i,j,GrauPolD,GrauPolQ,ID,GrauAtual;

	
	
	GrauPolD=ProcuraGrauDaLinha(PolD,PontosPolD);
	GrauPolQ=ProcuraGrauDaLinha(PolQ,PontosPolQ);


	Soma=(short int *)calloc(GrauPolD+1,sizeof(short int));

	///// gero Soma com PolD /////
	for(i=0;i<PontosPolD;i++)	Soma[PolD[i]]=1;
	//////////////////////////

	
	GrauAtual=ProcuraGrauDoVetor(Soma,GrauPolD+1);

	if(GrauPolQ!=0)
	{
		while(GrauAtual>=GrauPolQ)
		{
			ID=GrauAtual-GrauPolQ;	

			for(i=0;i<PontosPolQ;i++)
			{
				Soma[PolQ[i]+ID]=Soma[PolQ[i]+ID]^1;
			}
	
			GrauAtual=ProcuraGrauDoVetor(Soma,GrauPolD+1); 
		}
	}
	else 
	{
		for(i=0;i<PontosPolD;i++)	Soma[PolD[i]]=0;
	}
	
	*PontosPolRes=0;
	for(i=0;i<=GrauPolD;i++) *PontosPolRes=*PontosPolRes+Soma[i];

	if(*PontosPolRes>0)
	{
		PolRes=(short int *)calloc(*PontosPolRes,sizeof(short int));
		for(i=0,j=0;i<=GrauPolD;i++) 
		{	
			if(Soma[i]==1)	{	PolRes[j]=i;	j++;	}
		}
	}
	free(Soma);


	return PolRes;
}


// Procura o maximo comun divisor de LinhaMCD e Linha1 e o carrega em LinhaMCD
short int ProcuraMCD(short int **LinhaMCD,short int *PontosLinhaMCD,short int Linha1[],short int PontosL1)
{
	short int a,b,i;
	short int *PolD=NULL;
	short int *PolQ=NULL;
	short int *PolRes=NULL;
	short int PontosPD,PontosPQ,PontosPR;

	a=ProcuraGrauDaLinha(*LinhaMCD,*PontosLinhaMCD);
	b=ProcuraGrauDaLinha(Linha1,PontosL1);
	if(a>b)
	{
		PontosPD=*PontosLinhaMCD;
		PolD=(short int *)calloc(PontosPD,sizeof(short int));			
		for(i=0;i<PontosPD;i++) PolD[i]=(*LinhaMCD)[i];

		PontosPQ=PontosL1;
		PolQ=(short int *)calloc(PontosPQ,sizeof(short int));		
		for(i=0;i<PontosPQ;i++) PolQ[i]=Linha1[i];
	}
	else
	{
		PontosPQ=*PontosLinhaMCD;
		PolQ=(short int *)calloc(PontosPQ,sizeof(short int));		
		for(i=0;i<PontosPQ;i++) PolQ[i]=(*LinhaMCD)[i];

		PontosPD=PontosL1;
		PolD=(short int *)calloc(PontosPD,sizeof(short int));		
		for(i=0;i<PontosPD;i++) PolD[i]=Linha1[i];
	}

	do{
		if(PolRes!=NULL) free(PolRes);
		PolRes=ProcuraResiduoDeDivisao(&PontosPR,PolD,PontosPD,PolQ,PontosPQ);

		if(PolD!=NULL) free(PolD);
		PontosPD=PontosPQ;
		PolD=(short int *)calloc(PontosPD,sizeof(short int));
		for(i=0;i<PontosPD;i++)	PolD[i]=PolQ[i];

		if(PolQ!=NULL)free(PolQ);
		PontosPQ=PontosPR;
		if(PontosPQ>0)	
		{
			PolQ=(short int *)calloc(PontosPQ,sizeof(short int));
			for(i=0;i<PontosPQ;i++)	PolQ[i]=PolRes[i];
		}
		else		PolQ=NULL;
			

	}while(PontosPR>0);

	if((*LinhaMCD)!=NULL) free((*LinhaMCD));
	*PontosLinhaMCD=PontosPD;
	(*LinhaMCD)=(short int *)calloc(*PontosLinhaMCD,sizeof(short int));
	for(i=0;i<(*PontosLinhaMCD);i++)	(*LinhaMCD)[i]=PolD[i];

	free(PolQ);
	free(PolD);
	free(PolRes);
	return 0;
}

/** \fn short int *ProcuraPolinomioGerador(short int *ElemGfunc, short int Linha1[],short int PontosPorLinha,short int N)
 *  \brief Procura o Polinomio gerador G(x).
 *  \param ElemGfunc A funcao carrega aqui a quantidade de elementos de G(x).
 *  \param Linha1 O polinomio que e' o MCD de todas as linhas de H.
 *  \param PontosPorLinha A quantidade de pontos da Linha1.
 *  \param N Quantidade de colunas de H.
 *  \return O vetor G(x). 
 */
short int *ProcuraPolinomioGerador(short int *ElemGfunc, short int Linha1[],short int PontosPorLinha,short int N)
{
	short int *G=NULL;
	short int *Soma=NULL;
	short int *Gfunc=NULL;
	short int *Linha=NULL;
	short i,j,GrauLinha,ID,NAtual,tmp=0;

	Linha=(short int *)calloc(PontosPorLinha,sizeof(short int));
	for(i=0;i<PontosPorLinha;i++) Linha[i]=Linha1[i];
	
	Soma=(short int *)calloc(N+1,sizeof(short int));
	G=(short int *)calloc(N+1,sizeof(short int));

	///// gero X^N+1 /////
	Soma[0]=1; Soma[N]=1;
	//////////////////////////

	GrauLinha=ProcuraGrauDaLinha(Linha,PontosPorLinha);

	//// Procuro Polinomio reciproco ////
	for(i=0;i<PontosPorLinha;i++) Linha[i]=GrauLinha-Linha[i];
	/////////////////////////////////////
	NAtual=ProcuraGrauDoVetor(Soma,N+1);

	if(GrauLinha!=0)
	{
		while(NAtual>=GrauLinha)
		{
			ID=NAtual-GrauLinha;
			G[ID]=1;
	
			for(i=0;i<PontosPorLinha;i++)
			{
				if(Linha[i]>=0) Soma[Linha[i]+ID]=Soma[Linha[i]+ID]^1;
			}
	
			NAtual=ProcuraGrauDoVetor(Soma,N+1); 
		}
	}
	else {Soma[0]=0;Soma[N]=0;G[0]=1;G[N]=1;}
	
	tmp=0;
	for(i=0;i<=N;i++) tmp=tmp+Soma[i];

	*ElemGfunc=0;
	for(i=0;i<=N;i++) *ElemGfunc=*ElemGfunc+G[i];

	Gfunc=(short int *)calloc(*ElemGfunc,sizeof(short int));
	for(i=0,j=0;i<=N;i++) 
	{	
		if(G[i]==1)	{	Gfunc[j]=i;	j++;	}
	}

	free(G);
	free(Soma);
	free(Linha);

	return Gfunc;
}


short int LinhaEstaVacia(short int Linha[],short int Pontos)
{
	short int s,i;
	for(i=0,s=0;i<Pontos;i++)
	{
		s=s+Linha[i];
	}

	if(s==0) return 1;

	return 0;
}

short int ComparaLinhas(short int Linha1[],short int Linha2[],short int Pontos)
{
	int i,j,s1;

	if(LinhaEstaVacia(Linha1,Pontos)==1) return -1;
	if(LinhaEstaVacia(Linha2,Pontos)==1) return -1;

	for(i=0,s1=0;i<Pontos;i++)
	{
		for(j=0;j<Pontos;j++) 
		{
			if(Linha1[i]==Linha2[j]) s1=s1+1;
		}
	}


	if(s1==Pontos)	return 0;

	return -1;

}

short int ProcuraLinhaPadrao(short int **LinhaPadrao,short int NumPad,short int **LinhaMinima,short int Pontos)
{
	short int *Grau=NULL;
	short int IdMinGrau,i,j,OK;
	
	Grau=(short int*)calloc(Pontos,sizeof(short int));
	for(i=0;i<Pontos;i++)	Grau[i]=ProcuraGrauDaLinha(LinhaMinima[i],Pontos);

	IdMinGrau=0;
	for(i=1;i<Pontos;i++) if(Grau[i]<Grau[IdMinGrau]) IdMinGrau=i;

	OK=0;
	for(i=0;i<NumPad;i++)
	{
		if(ComparaLinhas(LinhaPadrao[i],LinhaMinima[IdMinGrau],Pontos)==0) OK=1;
	}
	
	if(OK==0)
	{
	
	
		for(i=0;i<NumPad;i++)
		{
			if(LinhaEstaVacia(LinhaPadrao[i],Pontos)==1) 
			{
				for(j=1;j<Pontos;j++) LinhaPadrao[i][j]=LinhaMinima[IdMinGrau][j];
				i=NumPad;
			}
		}		
	}
	free(Grau);
	return 0;
}

#endif

