%% Exercise 1
% (With the figure in focus) Hold the enter key to run the simulation,
% left click in the figure with the mouse to stop.

% enviroment constants
d = 30;  % width of wall (cm)
T0 = 0;  % starting temperature of wall (C)
Ti = 22;  % inside temperature (C)

% material constants
% CHECK UNITS
conductivity = 3;  % lambda - 0.4W/mK
density = 1.1;  % rho - g/cm^3
specific_heat = 1;  % c - J/gC
k = conductivity / (specific_heat * density);

% solution constants
m = 30;  % number of points
K = 0.5;  % time step scale
dx = d/(m-1);  % x step
dt = K * dx^2 / k;  % time step

T = T0 * ones(1, m);
T(1, 1) = Ti;
t = 0;

figure();
while waitforbuttonpress
    T = heat_update(T, dx, dt, k);
    t = t + dt;
    plot(T);
    title(sprintf('Time: %0.2f', t));
end