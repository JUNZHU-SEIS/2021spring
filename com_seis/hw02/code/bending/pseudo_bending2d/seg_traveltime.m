function t=seg_traveltime(p1, p2)
%calculate travel time along the segment
d=distance(p1, p2);
s=slow_ave(p1, p2);
t=d*s;
