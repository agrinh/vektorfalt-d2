function T2 = heat_update_neumann(T, dx, dt, k)
%HEAT_UPDATE_NEUMANN Get the updated temperature vector after dt
%   T  - initial temperature row vector (length(T) > 2)
%   dx - x distance between points
%   dt - update after dt seconds
%   k  - heat constant
%
%   Solves the heat equation with Neumann boundry conditions.

Ttemp = -2*T(2:end-1);  % only update inner points
Ttemp = Ttemp + T(1, 3:end) + T(1, 1:end-2);  % + T_i+1 + T_i-1
Ttemp = [0, Ttemp, 0];
T2 = T + dt*k * Ttemp / dx^2;

% Approximate Neumann boundry
T2(1) = T2(2);
T2(end) = T2(end-1);
end