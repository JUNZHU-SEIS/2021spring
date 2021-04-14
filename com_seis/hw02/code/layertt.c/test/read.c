#include <math.h>
#include <stdio.h>
#include<stdlib.h>
void main()
{FILE *logs,*out2,*parameter;
int i;
float DEPTH,GR,SP,CAL,AC,LLD,LLS,DEN,CNL;
float SPsh,GRsh,SPsd,GRsd,CNLsh,psh,pf,pma;
float Vsh1,Vsh2,Vsh, Phi,PhiN,PhiD,PhiDb,PhiDsh,Sw,So;
char c[200];
pf=1.0;
pma=2.65;
logs=fopen("logs.txt","r");
out2=fopen("out2.txt","w");
parameter=fopen("parameter.txt","r");
fprintf(out2,"Depth/m      Vsh/%%         Phi/%%        So/%%         Phi2/%%        So2/%%\n");
fgets(c,200,logs);  


fscanf(parameter,"%f  %f  %f  %f  %f  %f ",&SPsd,&SPsh,&GRsd,&GRsh,&CNLsh,&psh);
for(i=1;i<=881;i++)
{fscanf(logs,"%f  %f  %f  %f  %f  %f  %f  %f  %f",&DEPTH,&GR,&SP,&CAL,&LLD,&LLS,&AC,&DEN,&CNL);
printf("Depth=%f\n",DEPTH);  
Vsh1=(SP-SPsd)/(SPsh-SPsd);
Vsh2=(GR-GRsd)/(GRsh-GRsd);
if(Vsh1<Vsh2) Vsh=Vsh1;
else  Vsh=Vsh2;

if(Vsh>0.5)
{
Phi=0;
So=0;
}
else
{
PhiN=CNL/100-Vsh*CNLsh/100;
PhiDb=(pma-DEN)/(pma-pf);
PhiDsh=(pma-psh)/(pma-pf);
PhiD=PhiDb-Vsh*PhiDsh;
Phi=(PhiN+PhiD)/2;
Sw=pow(0.2/Phi/Phi/LLD,0.5);
So=1-Sw;
}

Vsh=Vsh*100;
Phi=Phi*100;
So=So*100;

fprintf(out2,"%8.3f    %8.4f%%    %8.4f%%    %8.4f%% \n",DEPTH,Vsh,Phi,So);
}
fclose(logs);
fclose(parameter);
fclose(out2);
printf("Finished.\n");
}
