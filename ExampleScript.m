% ExampleScript.m
%
% This script demonstrates basic usage of the x-IMU MATLAB Library showing
% how data can be easily imported visualised and the library class
% structures are used to organise and access data.

%% Start of script
 
addpath('ximu_matlab_library');     % include library
close all;                          % close all figures
clear;                              % clear all variables
clc;                                % clear the command terminal
 
%% Import and plot data

xIMUdata = xIMUdataClass('ExampleData\00000');
xIMUdata.Plot();
 
%% View properties of the objects by typing their name
 
xIMUdata
xIMUdata.CalInertialAndMagneticData
 
%% Example use of data
 
disp(strcat('Data was collected on: ''', xIMUdata.DateTimeData.String{1}, ''''));
disp(sprintf('Total time of data: %f seconds', xIMUdata.CalInertialAndMagneticData.NumPackets * xIMUdata.CalInertialAndMagneticData.SamplePeriod));
disp(strcat('Final command was: ''', xIMUdata.CommandData.Message{end}, ''''));
 
%% Example calculation using data: Strength of Earth's magnetic field
 
mx = xIMUdata.CalInertialAndMagneticData.Magnetometer.X;
my = xIMUdata.CalInertialAndMagneticData.Magnetometer.Y;
mz = xIMUdata.CalInertialAndMagneticData.Magnetometer.Z;
disp(sprintf('Earth''s magnetic field strength: %f G', mean(sqrt(mx.^2 + my.^2 + mz.^2))));
 
%% Example calculation using data: Remove gravity from accelerometer data
 
indxSel = mod(1:length(xIMUdata.CalInertialAndMagneticData.Time), 2);           % other index selected; e.g. [1 0 1 0 1 0 1 0 1 ...]
accMtr = [xIMUdata.CalInertialAndMagneticData.Accelerometer.X(indxSel == 1), ...
          xIMUdata.CalInertialAndMagneticData.Accelerometer.Y(indxSel == 1), ...
          xIMUdata.CalInertialAndMagneticData.Accelerometer.Z(indxSel == 1)];	% accelerometer data reduced from 256 Hz to 128 Hz (equal to rotation matrix data)
linAcc = zeros(length(accMtr), 3);
for i = 1:length(accMtr)
    transRot = xIMUdata.RotationMatrixData.RotationMatrix(:,:,i)';	% transpose of matrix describes Earth relative to sensor frame
    linAcc(i,:) = accMtr(i,:) - transRot(:,3)';                     % 3rd column of rotation matrix describes Earth z-axis (gravity) in sensor frame
end
figure('Name', 'Linear Acceleration');
hold on;
plot(xIMUdata.RotationMatrixData.Time, linAcc(:,1), 'r');
plot(xIMUdata.RotationMatrixData.Time, linAcc(:,2), 'g');
plot(xIMUdata.RotationMatrixData.Time, linAcc(:,3), 'b');
xlabel('Time (seconds)');
ylabel('Acceleration (g)');
title('Linear acceleration');
legend('X', 'Y', 'Z');
 
%% End of script