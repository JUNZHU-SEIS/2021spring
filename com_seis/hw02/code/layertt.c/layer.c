#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define pi 3.141592654
int layerxt(float p,float h,float utop,float ubot,float *dx,float *dt)
{
	int irtr;
	float eta1,eta2,tau1,tau2,dtau,x1,x2,u1,u2,v1,v2,b;
	if(p > utop)
	{
		*dx=0.0;
		*dt=0.0;
		irtr=0;
		return irtr;
	}
	else if(h == 0.0)
	{
		*dx=0.0;
		*dt=0.0;
		irtr=-1;
		return irtr;
	}

	u1=utop;
	u2=ubot;
	v1=1./u1;
	v2=1./u2;
	b=(v2-v1)/h;

	eta1=sqrt(u1*u1-p*p);

	if(b ==0)
	{
		*dx=h*p/eta1;
		*dt=h*u1*u1/eta1;
		irtr=1;
		return irtr;
	}

	x1=eta1/(u1*b*p);
	tau1=(log((u1+eta1)/p)-eta1/u1)/b;

	if(p > ubot)
	{
		*dx=x1;
		dtau=tau1;
		*dt=dtau+p*(*dx);
		irtr=2;
		return irtr;
	}

	irtr=1;

	eta2=sqrt(u2*u2-p*p);
	x2=eta2/(u2*b*p);
	tau2=(log((u2+eta2)/p)-eta2/u2)/b;

	*dx=x1-x2;
	dtau=tau1-tau2;

	*dt=dtau+p*(*dx);

	return irtr;
}

void ttime(float p0, float dep[145], float vp[145], float *x, float *t)
{
	int i, ittr;
	float h, utop, ubot, dx, dt;
	*x = 0; *t = 0;
	// 144 layers in total
	for (i=0;i<10;i++)
	{
		h = dep[i+1] - dep[i];
		utop = 1/vp[i];
		ubot = 1/vp[i+1];
		ittr = layerxt(p0,h,utop,ubot,&dx,&dt);
//		printf("p0 %f layer %d thickness %f utop %f ubot %f\n ittr %d dx %f dt %f\n",p0,i+1,dep[i+1]-dep[i],1/vp[i],1/vp[i+1],ittr,dx,dt);
		if (ittr==0)
		{
			break;
		}
		else
		{
			*x += 2*dx;
			*t += 2*dt;
		}
	}
//	printf("x %f t %f\n",*x, *t);
}

int main()
{
// read the data
	float d, v, dep[145], vp[145], v0;
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
//		printf("%f, %f\n",dep[i], vp[i]);
		i++;
	}
	v0 = 5.8;
//	printf("%f %f\n",dep[0], vp[0]);

// calculate travel time table
	float takeoff[360], p0[360], X[360], T[360], x, t;
	printf("TRAVEL TIME TABLE CALCULATED BY Jun Zhu\ntakeoff angle (deg)\tray parameter\trange (deg)\ttravel time (second)\n");
	for (i=0;i<360;i++)
	{
		takeoff[i] = i/4.0*(pi/180);
		p0[i] = sin(takeoff[i])/v0;
		ttime(p0[i], dep, vp, &x, &t);
		X[i] = x; T[i] = t;
		printf("%.2f %.2f %.2f %.2f\n",takeoff[i]*(180/pi),p0[i],x/111,t);
//		printf("-takeoff angle %f---------------ray parameter %f-\n\n",takeoff[i]*(180/pi), p0[i]);
	}

// print the travel time table
	return 0;
}
