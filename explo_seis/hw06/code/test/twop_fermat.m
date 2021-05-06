%% Two-point ray-tracing using Fermat's principle
% According to Fermat's principle, the ray-path that connects two points
% in the medium is the minimum time ($$\tau $$) path. A ray path can be
% parametrized a series of points {(xsrc, zsrc), (x1, z1), (x2, z2), ...,
% (recx, recz)}. 
%
% We can solve for the pairs  (x1, z1), (x2, z2),... that minimize the
% traveltime of the ray. This a non-linear problem that involve numerical
% calculation of derivatives 
% $$ {\partial \tau \over \partial x_i} $$ and $$ {\partial \tau \over
% \partial z_i} $$.
%
% For VSP survey with transmitted waves, the z1, z2,... are fixed at incrementing values, and
% we solve only for x1, x2, ...etc. This assumes VOZ and no head/diving 
% waves, because that would require at least two z-values to be equal.

% test velocity model
nz=50; nx=50;
vel=ones(nz,nx)*2000; % unit: m/s
vel( 5:10, :)=1500;
vel( 20:25, :)=3000;
sln=1./vel;
h=10; % grid spacing unit:  m
imagesc((1:nx)+.5, (1:nz)+.5,  vel); colorbar; grid on;
% geometry
r_x=1;
s_z=1;
ns=10:10:nx;%2:2:nx;
nr=40;%2:2:nz;

[rays_z, rays_x]=getRays(sln, nz, nx, ns, nr, s_z, r_x, h);
raysz_orig=rays_z;
raysx_orig=rays_x;

% Plotting the rays
imagesc(h*((1:nx)+.5), h*((1:nz)+.5),  vel); colorbar; grid on; 
hold on;
for is_x=1:length(ns)
    s_x=ns(is_x);
    for ir_z=1:length(nr)
        r_z=nr(ir_z);
        nseg=length(s_z:sign(r_z-s_z):r_z);
        ray_z=reshape(rays_z(is_x, ir_z, 1:nseg), 1, nseg);
        ray_x=reshape(rays_x(is_x, ir_z, 1:nseg), 1, nseg);
        plot(h*ray_x, h*ray_z, 'color', [rand rand rand]);
    end
end
hold off; 
xlabel('x[m]');
ylabel('z[m]');
title('Two-point ray tracing using Fermat''s principal');
%%
% The method above will give the nearest Fermat ray to the starting
% solution. This way we can choose which ray we want by having a starting ray
% close to it. Nevertheless, this is not the most efficient method if we
% want the raypaths of first arrivals.