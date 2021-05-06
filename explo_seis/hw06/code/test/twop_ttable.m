%% Two-point ray-tracing using traveltime tables
%
% Traveltime are fast to compute. So they can be used in ray tracing. The
% first arrival ray path is the steepest descent path from the receiver to
% the source in the traveltime table. So, we can get the ray path by
% applying the steepest decent method with fixed step length.
%
% *TODO*
%
% * Move receiver to z=5. What ray is found now?
% * Local gradient methods like steepest decent assume continuous differentiable
% functions. Are traveltime tables differentiable everywhere? 
% Where would the traveltime table be discontinuous? Can you *break* this
% method based on this weakness? 

% test velocity
n1=100;
n2=200;
h=25;
vel=(1:n1)'*((1:n2)*0+1)*10+1200;
vel(1:n1/2,:)=vel(1:n1/2,:)+500;
vel(1:n1/5,:)=vel(1:n1/5,:)*0+1500;
vel=mysmooth(vel, 1);
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
plot(h*path(1:itr,2), h*path(1:itr,1), 'color', [rand rand rand]);
plot(h*srcx2, h*srcx1, 'r*');
plot(h*recx2, h*recx1, 'g*');
hold off;
grid;
xlabel('x[m]');
ylabel('z[m]');
title('Two-point ray tracing results overlayed on the velocity model');