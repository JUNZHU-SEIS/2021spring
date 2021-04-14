%getRay() is the kernel function
clear all
close all
global ray npts 
%po: position of source
po.x=0; po.z=12.81;
%ps: positio of receiver
ps.x=18.14; ps.z=-1.07;
%grid cofigurations
nx=100;nz=100;dx=1;dz=1;
%constant velocity model
%vz: velocity along the z axis
%vx: velocity along the x axis
%v0: 
vz=0; vx=1; v0=3;
[Velo, Vx, Vz]=v_field(nx,nz,vx,vz,v0,dx,dz);

%add random velocity field
[vxp, vzp]=add_random(nz,nx);
Vx = Vx + vxp; Vz = Vz + vzp;

max_npts=1000;
%
initial(po,ps,max_npts,v0,vx,vz,dx,dz,Velo,Vx,Vz);
%100: maximum iteration number
%1.e-8: termination threshold of updating travel time

getRay(100, 1.e-8);

%figure;

%--------------------------------------------------------------------------
%uncomment the % if you want to plot the theoretical ray path
%hold on
%--------------------------------------------------------------------------

%plotpath(ray);
%travel time calculated by bending
t1 = traveltime(npts,ray)