function [Velo, Vx, Vz]=v_field(nx,nz,ax,az,v0,dx,dz)
%nx, nz: number of grids
%ax, az: 
%v0
%dx, dz: grid spacing

%initialization
Velo=zeros(nz,nx);Vx=zeros(nz,nx);Vz=zeros(nz,nx);
%Velocity potential
for i=1:nz
    for j=1:nx
        Velo(i,j)=(i-1)*dz*az+(j-1)*dx*ax+v0;
    end
end
%d(Velocity potential)/dz = v@z
for i=1:nz-1
    for j=1:nx
        Vz(i,j)=(Velo(i+1,j)-Velo(i,j))/dz;
    end
end
Vz(nz,:)=Vx(nz-1,:);
%d(Velocity potential)/dx = v@x
for i=1:nz
    for j=1:nx-1
        Vx(i,j)=(Velo(i,j+1)-Velo(i,j))/dx;
    end
end
Vx(:,nx)=Vx(:,nx-1);