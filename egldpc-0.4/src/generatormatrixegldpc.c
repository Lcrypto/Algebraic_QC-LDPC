#include <string.h>
#include <math.h>

#include "extras/Imprimindo.h"
#include "extras/GeneraGF2n.h"
#include "extras/ProcuraGF2n.h"
#include "extras/extras.h"

int main(int argc, char *argv[])
{
	DataM *datam=NULL;

	FILE *fd=NULL;

	short int IndiceAlpha;
	short int i,id,N,Ind_bA1,J,K;

	short int A0,A1;

	short int *b=NULL;
	short int *GF2n=NULL;
	short int *bA1=NULL;
	short int *Gx=NULL;
	short int ElemGx;
	short int PontosPorLinha;
	
	short int *Linha=NULL;
	short int *LinhaMCD=NULL;
	short int PontosLinhaMCD=0;
	short int **LinhaMinima=NULL;
	short int **LinhaPadrao=NULL; // As linhas padrao ciclicamente geram toda a matriz
	short int PrimeraVuelta=1;

	datam=CargarDatos(argc,argv);
	if(datam==NULL)
	{
		printf("Error el paquete datam.\n");
		return 0;
	}

	N=(short int)(pow(2,datam->Grau)-1);
	GF2n=(short int *)calloc(N,sizeof(short int));
	bA1=(short int *)calloc(N,sizeof(short int));

	GeneraGF(datam->ArchivoGF2n,datam->PolPrimitivoBin,datam->Grau);


	IndiceAlpha=(short int)((pow(2,datam->m*datam->s)-1)/(pow(2,datam->s)-1));		//<--- beta=alpha^IndiceAlpha 

	PontosPorLinha=(short int)pow(2,datam->s);

	J=(short int)((pow(2,datam->s*(datam->m-1))-1)*(pow(2,datam->s*datam->m)-1)/(pow(2,datam->s)-1));

	LinhaPadrao=(short int**)calloc(J/N,sizeof(short int*));
	for(i=0;i<(J/N);i++)
	LinhaPadrao[i]=(short int*)calloc(PontosPorLinha,sizeof(short int));

	Linha=(short int *)calloc(PontosPorLinha,sizeof(short int));
	b=(short int *)calloc(PontosPorLinha,sizeof(short int));
	////////   2^s   ////////
	b[0]=0; b[1]=0; 
	for(i=2;i<PontosPorLinha;i++) b[i]=IndiceAlpha*(i-1);
	/////////////////////////

	A0=0;			//<--- Indice do ponto de inicio
	A1=1;			//<--- Indice da Direcao inicial da linha
	
	do
	{
		LimpandoVetorShort(GF2n,N);

		b[0]=-A1-1;
	
		for(i=0;i<PontosPorLinha;i++)
		{
			Ind_bA1=b[i]+A1;
			id=ProcuraIndiceDeSomaDeIndicesGF2n(datam->ArchivoGF2n,A0,Ind_bA1,datam->Grau);	

			if(Ind_bA1>=0) 	{ Ind_bA1=Ind_bA1%N;	bA1[Ind_bA1]=1;	}
			if(id>=0)	{ id=id%N;	GF2n[id]=1;	}
			Linha[i]=id; 
		}

		printf("LINHA-BIT :");
		ImprimindoVetorShort(GF2n,N);
		printf("LINHA     :");ImprimindoLinha(Linha,PontosPorLinha);

		if(!AcheiNegativosNaLinha(Linha,PontosPorLinha))
		{
		
			LinhaMinima=(short int**)calloc(PontosPorLinha,sizeof(short int*));
			for(i=0;i<PontosPorLinha;i++)
			LinhaMinima[i]=(short int*)calloc(PontosPorLinha,sizeof(short int));

			ProcuraVetoresMinimosDaLinha(LinhaMinima, Linha,PontosPorLinha,N);

			/////////////// Carrego primera LinhaMCD ///////////////
			if(PrimeraVuelta==1)
			{
				if(LinhaMCD!=NULL)	{free(LinhaMCD);}
				LinhaMCD=(short int *)calloc(PontosPorLinha,sizeof(short int));
	
				for(i=0;i<PontosPorLinha;i++) LinhaMCD[i]=LinhaMinima[0][i];
				PontosLinhaMCD=PontosPorLinha;
				PrimeraVuelta=0;
			}
			////////////////////////////////////////////////////////

			for(i=0;i<PontosPorLinha;i++)
			{
				printf("LINHA-[%2hd]:",i);
				ImprimindoLinha(LinhaMinima[i],PontosPorLinha);
				// Procura o MCD de LinhaMCD e LinhaMinima[i] e o carrega em LinhaMCD
				ProcuraMCD(&LinhaMCD,&PontosLinhaMCD,LinhaMinima[i],PontosPorLinha);
			
 
			}

			printf("LINHA-MCD [%2hd]:",PontosLinhaMCD); 
			ImprimindoLinha(LinhaMCD,PontosLinhaMCD);			
			// A Linha Padrao e' MCD de todas as linhas minimas
			// LinhaPadrao e um arreglo de Linhas Padroes.
			// J/N e a quantidade de Linhas Padrao
			ProcuraLinhaPadrao(LinhaPadrao,J/N,LinhaMinima,PontosPorLinha);

			for(i=0;i<PontosPorLinha;i++)	{free(LinhaMinima[i]);LinhaMinima[i]=NULL;}
			free(LinhaMinima);LinhaMinima=NULL;

		}
		printf("\n\n"); 

		A1=ProcuraIndiceLivreEmGF2n(bA1,N);

	}while(A1>=0);

	//LinhaMCD ja e' o MCD de todas as Linhas minimas
	// Gx e' o G(x) e ElemGx e a quantidade de elementos
	if(Gx!=NULL) free(Gx);
	Gx=ProcuraPolinomioGerador(&ElemGx,LinhaMCD,PontosLinhaMCD,N);
	
	fd=fopen(datam->Salida,"w");
	
	printf("<<Reporte>>\n");

	printf("N=\t%hd\n",N);
	fprintf(fd,"N=\t%hd\n",N);
	
	K=ProcuraGrauDaLinha(LinhaMCD,PontosLinhaMCD);
	printf("K=\t%hd\n",K);
	fprintf(fd,"K=\t%hd\n",K);

	printf("Rc=\t%6.4f\n",K/(1.0*N));
	fprintf(fd,"Rc=\t%6.4f\n",K/(1.0*N));

	printf("J=\t%hd\n",J);
	fprintf(fd,"J=\t%hd\n",J);

	printf("LINHAS-PADRAO:\t%hd\n",J/N);
	fprintf(fd,"LINHAS-PADRAO:\t%hd\n",J/N);

	printf("LINHAS:\t%hd\n",PontosPorLinha);
	fprintf(fd,"LINHAS:\t%hd\n",PontosPorLinha);
	for(i=0;i<(J/N);i++)
	ImprimindoLinha(LinhaPadrao[i],PontosPorLinha);
	for(i=0;i<(J/N);i++)
	FileImprimindoLinha(fd,LinhaPadrao[i],PontosPorLinha);
	

	printf("POLI-GERA:\t%hd\n",ElemGx);
	fprintf(fd,"POLI-GERA:\t%hd\n",ElemGx);
	ImprimindoLinha(Gx,ElemGx);
	FileImprimindoLinha(fd,Gx,ElemGx);

	printf("<<Fin Del programa>>\n");

	fclose(fd);

	for(i=0;i<(J/N);i++)	free(LinhaPadrao[i]);
	free(LinhaPadrao);

	free(Gx);

	free(GF2n);
	free(bA1);
	free(Linha);
	free(b);

	return 0;
}
