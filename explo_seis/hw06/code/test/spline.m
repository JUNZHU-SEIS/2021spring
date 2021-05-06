%% Building a testing velocity model
% This is just one testing model. Feel free to change it. 
% Note that ray tracing works better in smooth models. Use the "mysmooth.m" tool
% to smooth your velocity model
%
% These parameters has to be set currently. If you use your own velocity model
% change these parameters accordingly.
h=25; %m sampling interval of the velocity field
N1=100;% number of elements in the z-direction
N2=200;% number of elements in the x-direction

vel=(1:N1)'*((1:N2)*0+1)*20+700;
vel(1:N1/2,:)=vel(1:N1/2,:)+500;
vel(1:N1/5,:)=vel(1:N1/5,:)*0+1500;

[x, z]=meshgrid(1:N2, 1:N1);
[xx, zz]=meshgrid(1:0.1:N2, 1:0.1:N1);
vel = interp2(x,z,vel,xx,zz);

%vel=mysmooth(vel, 3);

figure();
imagesc(h*(1:0.1:N2), h*(1:0.1:N1), vel); colorbar;
xlabel('x[m]'); ylabel('z[m]'); 
title('Testing velocity model');
%% Runge-Kutta ray-tracing method
srcpos=[1;10];  % source point position
recx=120;        % receiver x-position
recz=70;        % receiver z-position
% search variables
samp=pi/40;     % seach interval
arange=0:samp:pi/3;
hold on;
for iang=1:length(arange) % the range of take-off angles of the rays from the source point
    ang=arange(iang);
    p = [sin(ang);cos(ang)]; % ray parameter
    p = p/vel(10*srcpos(1), 10*srcpos(2));
    curpos = srcpos.*[h; h];
    y0 = [curpos; p];
    %accuracy control
    option = odeset('RelTol',1e-8,'AbsTol',[1e-8; 1e-8; 1e-8; 1e-8]);
    [t,y] = ode45(@(t,y) RK_tracer(t,y,vel,h/10,h/10), [0 5], y0, option);
    px = y(:,2); pz = y(:,1);
    plot(px, pz,'color','w'); % ploting the ray
    drawnow;
end
plot(h*srcpos(2), h*srcpos(1), '*');
hold off;
xlabel('x[m]');
ylabel('z[m]');
title('Ray tracing results overlayed on the velocity model');