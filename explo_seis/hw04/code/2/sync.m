f0 = 20;
t = [-0.1:0.001:0.1];
global ricker v1 d1 v2 d2 delta
delta = 0.001;
ricker = (1-2*(pi*f0*t).^2).*exp(-(pi*f0*t).^2);
v1 = 2000; d1 = 500;
v2 = 2500; d2 = 1000;
global rc1 rc2 blind_zone
rc1 = 1; rc2 = 1;
%plot(t, ricker)
%saveas(gcf, "../../image/Ricker.jpg")
critical_angle = asin(v1/v2); blind_zone = 2*d1*tan(critical_angle);
rc = RC(100)