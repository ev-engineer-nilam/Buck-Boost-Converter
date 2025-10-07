% buck_boost_converter.m
% Simple Buck-Boost Converter Simulation in MATLAB
% Author: [Your Name]

%% Parameters
Vin = 12;          % Input voltage (V)
D = 0.6;           % Duty cycle
R = 10;            % Load resistance (ohm)
L = 200e-6;        % Inductor (H)
C = 470e-6;        % Capacitor (F)
fs = 50e3;         % Switching frequency (Hz)
T = 1/fs;          % Switching period

% Time settings
t_end = 0.01;      % Simulation time (s)
dt = T/100;        % Time step
t = 0:dt:t_end;

% Initialize variables
IL = zeros(size(t));
Vc = zeros(size(t));
Vo = zeros(size(t));

%% Simulation loop
for k = 2:length(t)
    % Switch ON
    if mod(t(k), T) < D*T
        dIL = (Vin - Vc(k-1)) / L * dt;
    else
        % Switch OFF
        dIL = (-Vc(k-1)) / L * dt;
    end
    
    IL(k) = IL(k-1) + dIL;
    Vc(k) = Vc(k-1) + (IL(k)/C - Vc(k-1)/(R*C)) * dt;
    Vo(k) = Vc(k);
end

%% Plot Results
figure;
plot(t, Vo, 'r', 'LineWidth', 1.5);
xlabel('Time (s)'); ylabel('Output Voltage (V)');
title('Buck-Boost Converter Output Voltage');
grid on;
saveas(gcf, 'Results/buck_boost_output.png');
