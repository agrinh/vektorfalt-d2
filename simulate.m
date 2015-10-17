function [ T ] = simulate( heat_update, T, dt, width, specific_heat, density)
%SIMULATE Run simulation updating heat using heat_update with timestep dt
% (With the figure in focus) Hold the enter key to run the simulation,
% left click in the figure with the mouse to stop.

frame_every = dt * 1e3;  % time in between plot updates

E = (273.15 + mean(T))*specific_heat * density;  % Average energy over time
Z = T;                                           % T over time
x = linspace(0, width, length(T));               % x positions
tstep = 0;                                          % time at each step

% Plot initial heat distribution
figure();
subplot(5, 3, 1:9);
h_dist = plot(x, T);
xlabel('x [m]');
ylabel('temperature [C]');

% hold after frame_every seconds for a plot update and hold for user input
t = 0;
next_update = 0;
while true
    % Update heat
    T = heat_update(T);
    t = t + dt;
    Z = [Z; T];
    E = [E; (273.15 + mean(T))*specific_heat * density];
    tstep = [tstep; t];
    
    % Update plot
    if next_update <= t
        next_update = t + frame_every;
        
        % Plot current heat distribution
        subplot(5, 3, 1:9);
        set(h_dist, 'YData', T);
        title(sprintf('Time: %0.2f[s]', t));
        
        % Plot history of heat distribution
        subplot(5, 3, 10:12);
        imagesc([0 t], [0 width], Z');
        xlabel('time [s]');
        ylabel('x [m]');
        
        % Plot energy history
        subplot(5, 3, 13:15);
        plot(tstep(2:end), diff(E)/dt);
        xlabel('time [s]');
        ylabel('avg. power [W/m^3]');
        
        if waitforbuttonpress == 0
            break;
        end
    end
end

end