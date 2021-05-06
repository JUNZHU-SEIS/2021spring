n1=100;
n2=200;
h=25;

v0=1600; K=0.5; z=(1:n1)*h; beta=K/(v0+K*z(2));
vz=v0+K*z;
vel=vz'.*ones(1,n2);
deltangl=pi/200;
alpha0=[0:deltangl:pi/2];
x1=1./(beta*tan(alpha0))+h*10;
z1=-1/beta+h*2;
r1=1./(beta*sin(alpha0));
theta=[0:pi/2^10:2*pi];
u=x1+r1.*cos(theta');
v=z1+r1.*sin(theta');

sln=1./vel;

% calculating traveltime table
srcx1=2; % source position
srcx2=10;% receiver position
ttbl=mysmooth(tt(sln, n1, n2, h, srcx1, srcx2),2);
imagesc(h*((1:n2)), h*((1:n1)), ttbl); colorbar;
xlabel('x[m]');
ylabel('z[m]');
title('Traveltime table [sec]');
%%
% raypath by steepest decent
recx1=70; % receiver z-position
recx2=120;% receiver x-position
dtdz=diff(ttbl, 1, 1);
dtdz=[dtdz; dtdz(n1-1,:)];
dtdx=diff(ttbl, 1, 2);
dtdx=[dtdx dtdx(:,n2-1)];
x=[recx1; recx2];
nitr=500;
path=zeros(nitr, 2);
for itr=1:nitr-1
    path(itr, :)=x;
    ix1=int32(x(1));
    ix2=int32(x(2));
    if(abs(ix1-srcx1)<2 && abs(ix2-srcx2)<2); break; end;
    r=ttbl(ix1, ix2);
    g=[dtdz(ix1, ix2) dtdx(ix1, ix2)];
    dx=g'*r;
    dr=g*dx;
    alpha=-2;%% fixed step length
    while(1)
        x0=x+alpha*dx/norm(dx);
        if(x0(1)<1 || x0(2)<1); 
            alpha=alpha*0.5; 
        else
            break;
        end;
    end
    x=x+alpha*dx/norm(dx);
end
path(itr+1, :)=[srcx1 srcx2];
imagesc(h*((1:n2)), h*((1:n1)), vel); colorbar;
hold on;
for i=1:length(x1)
    plot(u(:,i), v(:,i), 'k')
end
%plot(h*path(1:itr,2), h*path(1:itr,1), 'color', [rand rand rand]);
plot(h*path(1:itr,2), h*path(1:itr,1), 'w');
plot(h*srcx2, h*srcx1, 'r*');
plot(h*recx2, h*recx1, 'g*');
hold off;
grid;
xlabel('x[m]');
ylabel('z[m]');
title('Two-point ray tracing results overlayed on the velocity model');