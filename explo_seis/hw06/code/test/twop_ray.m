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
figure;
imagesc(h*(1:N2), h*(1:N1), vel); colorbar;
xlabel('x[m]'); ylabel('z[m]'); 
title('Testing velocity model');
%% Two point ray-tracing by searching for the optimal take-off angle(s) 
% The optimal take-off angle will send the ray right to the receiver position.
% This is a non-linear optimization problem because there could be many
% ray paths between the source and receiver. Why? Before we choose the
% optimal angle, we search a sample set of all possible angles and find the
% closest ray to the receiver. What we get is a function of how close the
% ray came about the receiver. A ray that connect the source to the 
% receiver should have zero distance from the receiver. 
%
% *TODO*
%
% * See the following figure. Does the function touch zero value? Why?
srcpos=[1;10];  % source point position
recx=120;        % receiver x-position
recz=70;        % receiver z-position
% search variables
samp=pi/2^10;     % seach interval
optangl=0;      % optimal take off angle
mindist=10000;
arange=0:samp:2*pi;
dist=arange*0;
for iang=1:length(arange) % the range of take-off angles of the rays from the source point
    ang=arange(iang);
    p=[sin(ang);cos(ang)]; % ray parameter
    [rayx, rayz, rays, rayt]=tracer(vel, h, h, p, srcpos, 20000); %ray tracing
    val=min(sqrt((h*(rayx-recx)).^2+(h*(rayz-recz)).^2));
    dist(iang)=val;
    if(val<=mindist)
        optangl=ang;
        mindist=val;
    end
end
plot(arange, dist);
grid;
xlabel('take-off angle (radian)');
ylabel('minimum distance to receiver [m]');
%%
% * Does the ray touches the receiver? how is that related the function
% above? Try increasing the sampling of take-off angles search above. Is
% there a new ray that passes closer to the target position.
p=[sin(optangl);cos(optangl)]; % ray parameter
[rayx, rayz, rays, rayt]=tracer(vel, h, h, p, srcpos, 20000); %ray tracing
imagesc(h*(1:N2), h*(1:N1), vel); colorbar();
hold on;
plot(h*rayx, h*(rayz),'color',[rand rand rand]); % ploting the ray
plot(h*srcpos(2), h*srcpos(1), 'r*');
plot(h*recx, h*recz, 'k*');
hold off;
grid;
xlabel('x[m]');
ylabel('z[m]');
title('Two-point ray tracing results overlayed on the velocity model');
%%
% We can do a local-gradient optimization (like steepest decent) to find the ray that actually connect
% the source to the receiver. The optimal trace found by the search method
% above could be used as a starting solution of the optimization.
%
% *TODO*
%
% * How would you search for every possible ray paths between the source and receiver?
% * Comment on this exhaustive search method in terms of cost? Consider
% a big survey that has 100's of shot points and 100's of receivers.
%
