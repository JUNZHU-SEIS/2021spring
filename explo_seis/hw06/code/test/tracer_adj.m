function [x,z,s,t]=tracer_adj(vel, dx, dz, dir, srcpos, step_len, scount)
% A ray tracer function
% inputs:
%   vel    (2D) - velocity model
%   dx, dz (#)  - sampling interval in x & z directions
%   dir (2VEC)  - take off direction 
%   
% outputs:
%   x, y (VEC) - positions along the ray
%   s    (VEC) - distances from the source point
%   t    (VEC) - travel-time distances from the source

% modified by J. Li 4/12/2018
x=zeros(scount,1);
z=x; 
s=x; 
t=x;
tau=0;
% Computing partial derivatives of velocity fields
[nz, nx]=size(vel);
v_gradx=zeros(nz, nx); % x-vel gradient
v_gradz=zeros(nz, nx); % z-vel gradient
for m=1:nx-1
    v_gradx(:, m) = (-vel(:, m)+vel(:, m+1))/dx;
end
v_gradx(:, nx) = v_gradx(:, nx-1); % extrapolating the gradient for edge
% v_gradx = -v_gradx./vel.^2;
for m=1:nz-1
    v_gradz(m, :) = (-vel(m, :)+vel(m+1, :))/dz;
end
v_gradz(nz, :) = v_gradz(nz-1, :); % extrapolating the gradient for edge
% v_gradz=-v_gradz./vel.^2;

p=dir/norm(dir)/vel(srcpos(1),srcpos(2));
curpos=srcpos.*[dz;dx];

for is=1:scount
%     ipos=int32(curpos.*[1/dz; 1/dx]+1);
    ipos=round(curpos.*[1/dz; 1/dx]+1);
    iz=ipos(1);
    ix=ipos(2);
    if (ix>0 && ix<= nx && iz>0 && iz<= nz)
        vs=vel(iz, ix);
        
        deltaT = step_len/vs;
        dxzds = vs*vs*p*deltaT;
        curpos = curpos + dxzds;
        
        p = p + (-1/vs)*deltaT*[v_gradz(iz, ix);v_gradx(iz, ix)];
        
        tau = tau + deltaT;

        z(is)=curpos(1)/dz;
        x(is)=curpos(2)/dx;
        s(is)=is;
        t(is)=tau;
    else
        z(is:scount)=z(is-1);
        x(is:scount)=x(is-1);
        s(is:scount)=s(is-1);
        t(is:scount)=t(is-1);
        break;
    end
end