function t=traveltime(npts,ray)
%npts: number of points along the ray
%ray: cell of point positions (x, z)
t = 0;
for i =2:npts
    t=t+seg_traveltime( ray{i-1}, ray{i});
end