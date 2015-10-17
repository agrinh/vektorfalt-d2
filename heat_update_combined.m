function T2 = heat_update_combined(T, dx, dt, k)
%HEAT_UPDATE_COMBINED Get the updated temperature vector after dt
%   T  - initial temperature row vector (length(T) > 2)
%   dx - x distance between points
%   dt - update after dt seconds
%   k  - heat constant
%
%   Solves the heat equation with Dirichlet boundry to the left and Neumann
%   boundry to the right.

Ttemp = -2*T(2:end-1);  % only update inner points
Ttemp = Ttemp + T(1, 3:end) + T(1, 1:end-2);  % + T_i+1 + T_i-1
Ttemp = [0, Ttemp, 0];
T2 = T + dt*k * Ttemp / dx^2;

% Approximate Dirchlet and Neumann
T2(end) = T2(end-1);
end