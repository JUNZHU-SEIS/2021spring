#include <stdio.h>
#include <stdlib.h>
#include "layer.h"
#include "numc.h"

#define N 100000
#define LN 130
int main(int argc,char *argv[])
{
	//read ak135 
	float d, v, dep[136], h[135], vp[136];
	int i=0;
	FILE *fp;
	if ((fp=fopen("../../data/AK135CSV/ak135","r")) == NULL)
	{
		printf("\nerror on open the file");
		getchar();
		exit(0);
	}
	while(!feof(fp))	
	{
		fscanf(fp,"%f %f",&d,&v);
		dep[i]=d;
		vp[i]=v;
		i++;
//		printf("%f %f\n",d,v);
	}
	for (i=0;i<135;i++)
	{
		h[i]=dep[i+1]-dep[i];
//		printf("%f\n",h[i]);
	}

	int irtr,j;
	float dx=0,dt=0,p[N],x[N]={0.0},t[N]={0.0},tau[N]={0.0};
	
	linspace(0.05434,0.08979,N,p);

	for(i=0;i<N;i++)
	{
		for(j=0;j<LN;j++)
		{
			irtr = layerxt(p[i],h[j],1.0/vp[j],1.0/vp[j+1],&dx,&dt);
			x[i] += dx;
			t[i] += dt;
		}
		tau[i] = t[i]-p[i]*x[i];
	}
	printf("param delta tt tau\n");
	fp=fopen("../../output/tttable.txt","w");
	fprintf(fp, "param delta tt tau\n");
	for(i=0;i<N;i++)
	{
		printf("%f	%f	%f	%f\n",p[i],x[i]/111,t[i],tau[i]);
		fprintf(fp, "%f	%f	%f	%f\n",p[i],x[i]/111,t[i],tau[i]);
	}
	fclose(fp);
	return 0;
}
