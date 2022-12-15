#include <stdio.h>
#include <stdlib.h>

#include "extras/ProcuraGF2n.h"
#include "extras/checkmatrixegldpc.h"

short int AndLinhasEZero(short int X[], short int PontosX,short int Y[], short int PontosY)
{
	short int i,GrauX,GrauY,M,S;
	short int *Tmp1=NULL;
	short int *Tmp2=NULL;

	GrauX=ProcuraGrauDaLinha(X,PontosX);
	GrauY=ProcuraGrauDaLinha(Y,PontosY);
	if(GrauX>GrauY) M=GrauX;
	else		M=GrauY;

	Tmp1=(short int *)calloc(M+1,sizeof(short int));
	Tmp2=(short int *)calloc(M+1,sizeof(short int));

	for(i=0;i<PontosX;i++)	Tmp1[X[i]]=1;
	for(i=0;i<PontosY;i++)	Tmp2[Y[i]]=1;

	for(i=0;i<M+1;i++)	Tmp1[i]=Tmp1[i]&Tmp2[i];


	for(i=0,S=0;i<M+1;i++)	S=S^Tmp1[i];

	free(Tmp1);
	free(Tmp2);

	return S;
}

short int CorrimientoDeLinha(short int *LinhaH,short int LinhaPadrao[],short int PontosH,short int j,short int N)
{
	int i;

	for(i=0;i<PontosH;i++)
	{
		LinhaH[i]=(LinhaPadrao[i]+j)%N;
	}

	return 0;
}

int main(int argc, char *argv[])
{ 
	short int N,J,K,Pontos,i,j,S,OK,n;
	short int *LinhaG=NULL;
	short int PontosG;
	short int *LinhaH=NULL;
	short int PontosH;
	short int NumLinhasPadrao;
	short int **LinhaPadrao=NULL;
	float Rc;
	DataX *datax=NULL;

	FILE *fd=NULL;

	datax=CargarDatos(argc,argv);
	if(datax==NULL)
	{
		printf("Error el paquete datam.\n");
		return 0;
	}

	fd=fopen(datax->Salida,"r");
	if(fd==NULL)		
	{
		printf("\nERROR: No se pudo abrir el archivo %s.\n\n",datax->Salida); 
		return 0;
	}


	n=fscanf(fd,"N=\t%hd\n",&N);	printf("N=\t%hd\n",N);
	n=fscanf(fd,"K=\t%hd\n",&K);	printf("K=\t%hd\n",K);
	n=fscanf(fd,"Rc=\t%f\n",&Rc);	printf("Rc=\t%f\n",Rc);
	n=fscanf(fd,"J=\t%hd\n",&J);	printf("J=\t%hd\n",J);
	n=fscanf(fd,"LINHAS-PADRAO:\t%hd\n",&NumLinhasPadrao);	printf("LINHAS-PADRAO:\t%hd\n",NumLinhasPadrao);
	n=fscanf(fd,"LINHAS:\t%hd\n",&PontosH);	printf("LINHAS:\t%hd\n",PontosH);

	LinhaPadrao=(short int**)calloc(NumLinhasPadrao,sizeof(short int *));
	for(i=0;i<NumLinhasPadrao;i++) LinhaPadrao[i]=(short int*)calloc(PontosH,sizeof(short int));


	for(i=0;i<NumLinhasPadrao;i++)	
	{
		for(j=0;j<PontosH;j++)
		{
			n=fscanf(fd,"%hd\t",&LinhaPadrao[i][j]);
			printf("%hd\t",LinhaPadrao[i][j]);
		}
		printf("\n");
	}

	n=fscanf(fd,"POLI-GERA:\t%hd\n",&PontosG);	printf("POLI-GERA:\t%hd\n",PontosG);

	LinhaG=(short int*)calloc(PontosG,sizeof(short int));
	for(j=0;j<PontosG;j++)
	{
		n=fscanf(fd,"%hd\t",&LinhaG[j]);
		printf("%hd\t",LinhaG[j]);
	}
	printf("\n");

	////////////////////////////////////////////////////////////////////////

	LinhaH=(short int*)calloc(PontosH,sizeof(short int));

	for(i=0,OK=0;i<NumLinhasPadrao;i++)
	{

		for(j=0,S=0;j<N;j++)
		{
			CorrimientoDeLinha(LinhaH,LinhaPadrao[i],PontosH,j,N);

			S=S+AndLinhasEZero(LinhaH,PontosH,LinhaG,PontosG);
		}
		if(S==0)	printf("LinhaPadrao[%2hd]..........OK\n",i);
		else		printf("LinhaPadrao[%2hd]..........ERROR\n",i);
		OK=OK+S;
	}

	if(OK==0)	printf("Matriz H e G ............OK\n");
	else		printf("Matriz H e G ............ERROR\n");

	////////////////////////////////////////////////////////////////////////

	for(i=0;i<NumLinhasPadrao;i++)	free(LinhaPadrao[i]);
	free(LinhaPadrao);

	fclose(fd);

	free(LinhaG);
	free(LinhaH);

	return 0;
}
