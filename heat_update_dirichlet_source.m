function T2 = heat_update_dirichlet_source(T, u, dx, dt, k)
%HEAT_UPDATE Get the updated temperature vector after dt
%   T  - initial temperature row vector (length(T) > 2)
%   u  - heatsource density (W/m^-3)
%   dx - x distance between points
%   dt - update after dt seconds
%   k  - heat constant
%
%   Solves the heat equation for Dirichlet boundry conditions.

Ttemp = -2*T(2:end-1);  % only update inner points
Ttemp = Ttemp + T(1, 3:end) + T(1, 1:end-2);  % + T_i+1 + T_i-1
dT = k * Ttemp / dx^2 + u(2:end-1);
dT = [0, dT, 0];  % endpoints constant
T2 = T + dt * dT;

end