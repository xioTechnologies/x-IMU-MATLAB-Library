%% xIMUdataClass_ExampleUsage.m
% MATLAB x-IMU Library Version 3.2

addpath('xIMUclasses');     % include class library
close all;                  % close all figures
clear;                      % clear all variables
clc;                        % clear the command terminal

%% Import and plot data

xIMUdata = xIMUdataClass('exampleData\00000', 'InertialMagneticSampleRate', 256);
xIMUdata.Plot();

%% Use magnetometer data to calculate Earth's magnetic field strength

x = xIMUdata.CalInertialMagneticData.Magnetometer.X;
y = xIMUdata.CalInertialMagneticData.Magnetometer.Y;
z = xIMUdata.CalInertialMagneticData.Magnetometer.Z;
disp(sprintf('Earth''s magnetic field strength: %f G', mean(sqrt(x.^2 + y.^2 + z.^2))));

%% End of script