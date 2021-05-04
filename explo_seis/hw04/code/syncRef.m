clc;
delta = 0.001;
%ref = https://wiki.seg.org/wiki/Reflection_coefficient
imp = rho.*Vp;
%RC = reflection coefficient for each layer
num = length(imp);
RC = (imp(2:end) - imp(1:end-1)) ./ (imp(2:end) + imp(1:end-1));
tRC = [1:num-1] * delta;

figure;
subplot(1, 3, 1); 
plot(Vp, 1:numel(Vp));
set(gca,'ydir','reverse');
grid on;
xlabel('Vp (m)');
ylabel('TWT (ms)');

subplot(1, 3, 2);
plot(rho, 1:numel(rho),'r');
set(gca,'ydir','reverse');
grid on;
xlabel('rho (kg/m^3)');
ylabel('TWT (ms)');

subplot(1, 3, 3);
plot(RC, 1:numel(RC),'r');
set(gca,'ydir','reverse');
grid on;
xlabel('RC');
ylabel('TWT (ms)');

print("../image/RC", "-dpng", "-r600")

%how to design a minimum phase wavelet
%ref = https://wiki.seg.org/wiki/Making_a_wavelet_minimum-phase

disp(['two interface: 800 ms -0.1199; 1500 ms 0.1396'])
fm = 20; n = 2; %central frequency && peak vally ratio
t = [0:delta:2/fm];

minP = exp(-2 * fm^2 * t.^2 * log(n)) .* sin(2 * pi * fm * t);
minSync = conv(minP, RC);
tmin = [0:length(minSync)-1] * delta;

figure
subplot(3,1,1)
plot(t, minP);
ylabel(sprintf('min %dHz',fm))
grid on;
subplot(3,1,2)
plot(tRC, RC);
ylabel ('RC')
grid on;
subplot(3,1,3)
plot(tmin, minSync);
ylabel('sync')
print(sprintf("../image/syncMin%dHz", fm), "-dpng", "-r600")

zeroP = exp(-(pi * fm * t).^2).*(1 - 2 * (pi * fm * t).^2);
zeroSync = conv(zeroP, RC);
tzero = [0:length(zeroSync)-1] * delta;

figure
subplot(3,1,1)
plot(t, zeroP);
ylabel(sprintf('zero %dHz',fm))
grid on;
subplot(3,1,2)
plot(tRC, RC);
ylabel ('RC')
grid on;
subplot(3,1,3)
plot(tzero, zeroSync);
ylabel('sync')
print(sprintf("../image/syncZero%dHz", fm), "-dpng", "-r600")
