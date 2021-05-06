function [v_gradx, v_gradz]=grad(vel, dx, dz)
[nz, nx]=size(vel);
v_gradx=zeros(nz, nx); % x-vel gradient
v_gradz=zeros(nz, nx); % z-vel gradient
for m=1:nx-1
    v_gradx(:, m) = (-vel(:, m)+vel(:, m+1))/dx;
end
v_gradx(:, nx) = v_gradx(:, nx-1); % extrapolating the gradient for edge
v_gradx = v_gradx;
for m=1:nz-1
    v_gradz(m, :) = (-vel(m, :)+vel(m+1, :))/dz;
end
v_gradz(nz, :) = v_gradz(nz-1, :); % extrapolating the gradient for edge
v_gradz = v_gradz;
end