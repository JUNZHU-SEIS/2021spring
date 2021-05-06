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
vel=mysmooth(vel, 2);
imagesc(h*(1:N2), h*(1:N1), vel); colorbar();
xlabel('x[m]'); ylabel('z[m]'); 
title('Testing velocity model');
%% Runge-Kutta ray-tracing method
srcpos=[2;10]; % source point position [z,x] in grid coordinates 1<=srcpos(1)<=N1 & <=srcpos(2)<=N2
% imagesc(h*(1:N2), h*(1:N1), vel); colorbar;
hold on;
for ang=0:pi/40:pi/3 % the range of take-off angles of the rays from the source point
    p = [sin(ang);cos(ang)]; % ray parameter
    p = p/vel(srcpos(1),srcpos(2));
    curpos=srcpos.*[h; h];
    y0 = [curpos; p];
    [t, y] = ode45(@(t,y) RK_tracer(t, y, vel, h, h), [0 5], y0);
%     [rayx, rayz, rays, rayt]=tracer_adj(vel, h, h, p, srcpos, 0.1, 200000); %ray tracing
    plot(y(:, 2), y(:, 1),'color','r'); % ploting the ray
    drawnow;
end
plot(h*srcpos(2), h*srcpos(1), '*');
hold off;
xlabel('x[m]');
ylabel('z[m]');
title('Ray tracing results overlayed on the velocity model');