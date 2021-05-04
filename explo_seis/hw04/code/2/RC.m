function [rc]=RC(range)
global v1 v2 d1 d2 blind_zone delta
k = zeros(1,2000);
if range > blind_zone
	rc = 1;
    
else
    rc = 0;
    ref1 = sqrt(range^2 + 2*d1^2) / v1;
    ref2 = sqrt()
end
end

