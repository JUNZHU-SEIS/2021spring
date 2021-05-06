function dydt = RK_tracer(t, y, vel, dz, dx)
% 1st order ODE system for ray-tracing based on lecture notes of
% advances in seismic exploration (Spring 2018)
% J. Li 4/18/2018
% inputs:
% vel: velocity (nz, nx)
% dz, dz grid spacing

% Computing partial derivatives of velocity fields
[nz, nx] = size(vel);
v_gradx = zeros(nz, nx); % x-vel gradient
v_gradz = zeros(nz, nx); % z-vel gradient
for m = 1:nx-1
    v_gradx(:, m) = (-vel(:, m)+vel(:, m+1))/dx;
end
v_gradx(:, nx) = v_gradx(:, nx-1); % extrapolating the gradient for edge
for m = 1:nz-1
    v_gradz(m, :) = (-vel(m, :)+vel(m+1, :))/dz;
end
v_gradz(nz, :) = v_gradz(nz-1, :); % extrapolating the gradient for edge

iz = min(nz, max(1, round(y(1)/dz + 1)));
ix = min(nx, max(1, round(y(2)/dx + 1)));

vs = vel(iz, ix);

dydt = zeros(4, 1);

dydt(1) = vs*vs*y(3);
dydt(2) = vs*vs*y(4);

dydt(3) = -1/vs*v_gradz(iz, ix);
dydt(4) = -1/vs*v_gradx(iz, ix);

% for is=1:scount
% %     ipos=int32(curpos.*[1/dz; 1/dx]+1);
%     ipos=round(curpos.*[1/dz; 1/dx]+1);
%     iz=ipos(1);
%     ix=ipos(2);
%     if (ix>0 && ix<= nx && iz>0 && iz<= nz)
%         vs=vel(iz, ix);
%         
%         deltaT = step_len/vs;
%         dxzds = vs*vs*p*deltaT;
%         curpos = curpos + dxzds;
%         
%         p = p + (-1/vs)*deltaT*[v_gradz(iz, ix);v_gradx(iz, ix)];
%         
%         tau = tau + deltaT;
% 
%         z(is)=curpos(1)/dz;
%         x(is)=curpos(2)/dx;
%         s(is)=is;
%         t(is)=tau;
%     else
%         z(is:scount)=z(is-1);
%         x(is:scount)=x(is-1);
%         s(is:scount)=s(is-1);
%         t(is:scount)=t(is-1);
%         break;
%     end
% end