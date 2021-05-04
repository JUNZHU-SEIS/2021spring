clear
Vp = zeros(2000, 1);
rho = zeros(2000, 1);

t_var = [300, 800, 1500];
%%
Vp(1:t_var(1)) = linspace(1500, 2000, t_var(1));
Vp(t_var(1)+1:t_var(2)) = linspace(2000, 2200, t_var(2)-t_var(1));
Vp(t_var(2)+1:t_var(3)) = linspace(1900, 1950,  t_var(3)-t_var(2));
Vp(t_var(3)+1:end) = linspace(2300, 2500,  numel(Vp)-t_var(3));

rho(1:t_var(1)) = linspace(2000, 2500, t_var(1));
rho(t_var(1)+1:t_var(2)) = linspace(2500, 2400, t_var(2)-t_var(1));
rho(t_var(2)+1:t_var(3)) = linspace(2200, 2300,  t_var(3)-t_var(2));
rho(t_var(3)+1:end) = linspace(2600, 2650,  numel(rho)-t_var(3));

rng('default');
Vp_pert = 100*randn(numel(Vp), 1);
Vp_pert = smoothdata(Vp_pert, 1, 'gaussian', 10);

rho_pert = 50*randn(numel(rho), 1);
rho_pert = smoothdata(rho_pert, 1, 'gaussian', 10);

Vp = Vp + Vp_pert;
rho = rho + rho_pert;

figure;
subplot(1, 2, 1); 
plot(Vp, 1:numel(Vp));
set(gca,'ydir','reverse');
grid on;
xlabel('Vp (m)');
ylabel('TWT (ms)');

subplot(1, 2, 2);
plot(rho, 1:numel(rho),'r');
set(gca,'ydir','reverse');
grid on;
xlabel('rho (kg/m^3)');
ylabel('TWT (ms)');
