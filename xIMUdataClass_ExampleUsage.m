%% xIMUdataClass_ExampleUsage.m
% MATLAB x-IMU Library Version 5.0

addpath('xIMUclasses');     % include class library
close all;                  % close all figures
clear;                      % clear all variables
clc;                        % clear the command terminal

%% Import and plot data

xIMUdata = xIMUdataClass('exampleData\00000');
xIMUdata.Plot();

%% View properties of the objects by typing their name

xIMUdata
xIMUdata.CalInertialMagneticData

%% Example use of data

disp(strcat('Data was collected on: ''', xIMUdata.DateTimeData.String{1}, ''''));

samplePeriod = xIMUdata.CalInertialMagneticData.SamplePeriod;
numberOfSamples = xIMUdata.CalInertialMagneticData.NumPackets;
disp(sprintf('Total time of data: %f seconds', numberOfSamples*samplePeriod));

x = xIMUdata.CalInertialMagneticData.Magnetometer.X;
y = xIMUdata.CalInertialMagneticData.Magnetometer.Y;
z = xIMUdata.CalInertialMagneticData.Magnetometer.Z;
disp(sprintf('Earth''s magnetic field strength: %f G', mean(sqrt(x.^2 + y.^2 + z.^2))));

disp(strcat('Final command was: ''', xIMUdata.CommandData.Message{end}, ''''));

%% End of script