%% Example_DataSyncronisation.m
 
addpath('ximu_matlab_library'); % include library
close all;                      % close all figures
clear;                          % clear all variables
clc;                            % clear the command terminal
 
%% Synopsis
 
% Synchronisation requires that an event effecting all x-IMUs can be
% observed in the data of each x-IMU.  ExampleData_DataSyncronisation
% contains data logged from 2 x-IMUs sitting on a desk.  The desk was
% tapped 5 times at the start of the dataset and 5 times again at the end
% of the dataset.
%
% The SyncroniseData function is used to synchronise the data from the
% separate x-IMUs by specifying the time of the first tap observed within
% each x-IMU's data (as StartEvent).
%
% Minor drift between the clocks of each x-IMU may mean that data initially
% synchronised becomes out of sync after an extended period of time.  This
% can be corrected by specifying the time of the last tap observed within
% each x-IMU's data (as EndEvent).
 
%% Import data from directory
 
xIMUdataStruct = ImportDirectory('ExampleData_DataSyncronisation')
 
%% Manually synchronise data
 
startTimes = [2.844 2.766];     % observed times (before synchronisation) of first tap within accelerometer data
endTimes = [24.957 24.891];     % observed times (before synchronisation) of 'last tap within accelerometer data (not necessary here)
xIMUdataStruct = SyncroniseData(xIMUdataStruct, 'StartEvent', startTimes, 'EndEvent', endTimes);
 
%% Plot synchronised data
 
xIMUdataCells = struct2cell(xIMUdataStruct);    % create cell array for enumerated access
h1 = xIMUdataCells{1}.CalInertialMagneticData;  % object handles for more readable code
h2 = xIMUdataCells{2}.CalInertialMagneticData;
 
figure('Name', 'Synchronised Accelerometer Data');
ax(1) = subplot(2,1,1);
hold on;
plot(h1.Time, h1.Accelerometer.X, 'r');
plot(h1.Time, h1.Accelerometer.Y, 'g');
plot(h1.Time, h1.Accelerometer.Z, 'b');
legend('X', 'Y', 'Z');
xlabel('TIme (s)');
ylabel(strcat('Acceleration (g)'));
title('x-IMU A - Accelerometer');
hold off;
ax(2) = subplot(2,1,2);
hold on;
plot(h2.Time, h2.Accelerometer.X, 'r');
plot(h2.Time, h2.Accelerometer.Y, 'g');
plot(h2.Time, h2.Accelerometer.Z, 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel(strcat('Acceleration (g)'));
title('x-IMU B - Accelerometer');
hold off;
linkaxes(ax,'x');
 
%% End of script


