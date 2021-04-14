function plotpath(path)
n=length(path);
%save aaa;stop
for k=1:n
    xx(k)=path{k}.x;
    yy(k)=path{k}.z;
end
plot(xx,yy);
grid on
h = gca;  % Handle to currently active axes
set(h, 'YDir', 'reverse');
set(h, 'GridLineStyle', ':')
print('../../../image/raypath','-dpng','-r600')
%Dtp = max(yy)