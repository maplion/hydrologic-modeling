%% Heat Diffusion -- Implicit Differentiation
% This is an example of the finite difference method in which we solve the
% 1-dimensional heat diffusion equation using an explicit formulation

% GEOS 518
% Spring 2016
% Ryan Dammrose

%% Close all; clear all
close all; clear all; clf;

%% Define variables for model
% Defining initial and boundary conditions.

temperatureLeftSide = 273.15; % Temperature on the left side of the rod [K]     (TL)
temperatureRightSide = 373.15; % Temperature on the right side of the rod [K]   (TR)
initialTemperature = 293.15; % Initial temperature (assumed uniform) [K]        (Ti)

% Define characteristics of the domain
leftMostCoordinate = 0; % [mm]                                                  (xL)
rightMostCoordinate = 400; % [mm]                                               (xR)
numberOfNodes = 100; % Number of nodes to simulate [d/l]                        (Nx)

% Define characteristics of model run
initialTime = 0; % Initial time [s]                                             (ti)
finalTime = 24*3600; % Final time [s]                                           (tf)
numberOfTimeSteps = 50000; %                                                    (Nt)

% Define material properties
thermalDiffusivity = 1; % Thermal diffusivity of rock [mm/s]                    (Dt)

%% Model Pre-processing Steps
temperatureMatrix = zeros(numberOfNodes, numberOfTimeSteps); % A storage container for simulated temperatures 
    % (T)
temperatureVectorTp1 = zeros(numberOfNodes, 1); % Temperature vector at time t + 1 
    % (Ttp1)
temperatureVectorT = zeros(numberOfNodes, 1); % Temperature vector at time t 
    % (Tt)
spatialContainer = linspace(leftMostCoordinate, rightMostCoordinate, numberOfNodes); % A storage container for the spatial dimension [mm] 
    % (x)
timeContainer = linspace(initialTime, finalTime, numberOfTimeSteps); % A storage container for the time dimension [s] 
    % (t)
spatialResolution = spatialContainer(2) - spatialContainer(1); % [mm] 
    % (dx)
temporalResolution = timeContainer(2) - timeContainer(1); % [s] 
    % (dt)
alpha = (thermalDiffusivity * temporalResolution) / spatialResolution^2;

%% Define second difference and identity matrices
I = eye(numberOfNodes); % numberOfNodes * numberOfNodes identity matrices
Delta2 = diag(ones(numberOfNodes - 1, 1), 1) + ...
    diag(-2 * ones(numberOfNodes, 1)) + ...
    diag(ones(numberOfNodes - 1, 1), -1); % Second difference matrix

%% Main simulation Loop

for i=1:numberOfTimeSteps
    if(i==1)
        temperatureVectorTp1 = initialTemperature * ones(numberOfNodes,1); % At the initial time step, set temperatureMatrix at time t+1 equal to initialTime
        temperatureVectorTp1(1) = temperatureLeftSide;
        temperatureVectorTp1(end) = temperatureRightSide;
    else
        temperatureVectorT = temperatureMatrix(:, i - 1);
        
        % Ensure that boundary conditions are preserved each go around.
        Delta2(1, :) = [1, zeros(1, numberOfNodes - 1)];
        Delta2(end, :) = [zeros(1, numberOfNodes - 1), 1];
        
        temperatureVectorTp1 = temperatureVectorT + alpha * Delta2 * temperatureVectorT; % Forecast temperature distribution at t+1
        temperatureVectorTp1(1) = temperatureLeftSide;
        temperatureVectorTp1(end) = temperatureRightSide;        
    end
    
    temperatureMatrix(:, i) = temperatureVectorTp1; % Note: Colon means "all rows"
    if(mod(i, 200) == 0)
        figure(1);
        plot(spatialContainer, temperatureVectorTp1); hold on;
        xlabel('Distance [mm]');
        ylabel('Temperature [K]');
    end
end

%% Plotting results
figure(2);
surf(timeContainer, temperatureVectorTp1, temperatureMatrix, 'EdgeColor', 'None');
xlabel('Time [s]');
ylabel('Distance [mm]');
zlabel('Temperature [K]');
