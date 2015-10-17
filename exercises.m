%% Setup

% enviroment constants
d  = .3;  % width of wall (m)
Ti = 22;  % temperature of inwards facing wall (C)

% material constants for dry concrete
conductivity  = 1.05;        % lambda - W/mK (from 0.4 - 1.7)
density       = 1.95 * 1e3;  % rho - kg/m^3 (from 1.5 - 2.4)
specific_heat = 0.92 * 1e3;  % c - J/kgK
k = conductivity / (specific_heat * density);

% solution constants
m  = 50;            % number of points
K  = 0.5;           % time step scale
dx = d/(m-1);       % x step
dt = K * dx^2 / k;  % time step

%% Exercise 1
T0 = 0;  % starting temperature of wall (C)

T = T0 * ones(1, m);
T(1, 1) = Ti;   
heat_update = @(T)heat_update_dirichlet(T, dx, dt, k);
simulate(heat_update, T, dt, d, specific_heat, density);

%% Exercise 2
T0 = 100;  % starting temperature of wall (C)

x = 0:dx:d;
T = T0 * x .* (d - x) / d^2;
heat_update = @(T)heat_update_neumann(T, dx, dt, k);
simulate(heat_update, T, dt, d, specific_heat, density);

%% Exercise 3
T0 = 0;  % starting temperature of wall (C)

T = T0 * ones(1, m);
T(1, 1) = Ti;
heat_update = @(T)heat_update_combined(T, dx, dt, k);
simulate(heat_update, T, dt, d, specific_heat, density);

%% Exercise 4
T0 = 0;    % starting temperature of wall (C)
s  = 1e3;  % heat source density in wall

T = T0 * ones(1, m);
u = (s / specific_heat / density) * ones(1, m);
heat_update = @(T)heat_update_dirichlet_source(T, u, dx, dt, k);
simulate(heat_update, T, dt, d, specific_heat, density);