%% Example_BasicUsage.m
 
addpath('ximu_matlab_library');     % include library
close all;                          % close all figures
clear;                              % clear all variables
clc;                                % clear the command terminal
 
%% Import and plot data
 
xIMUdata = xIMUdataClass('ExampleData_BasicUsage\00000');
xIMUdata.Plot();
 
%% View properties of the objects by typing their name
 
xIMUdata
xIMUdata.CalInertialMagneticData
 
%% Example use of data
 
disp(strcat('Data was collected on: ''', xIMUdata.DateTimeData.String{1}, ''''));
disp(sprintf('Total time of data: %f seconds', xIMUdata.CalInertialMagneticData.NumPackets * xIMUdata.CalInertialMagneticData.SamplePeriod));
disp(strcat('Final command was: ''', xIMUdata.CommandData.Message{end}, ''''));
 
%% Example calculation using data: Strength of Earth's magnetic field
 
mx = xIMUdata.CalInertialMagneticData.Magnetometer.X;
my = xIMUdata.CalInertialMagneticData.Magnetometer.Y;
mz = xIMUdata.CalInertialMagneticData.Magnetometer.Z;
disp(sprintf('Earth''s magnetic field strength: %f G', mean(sqrt(mx.^2 + my.^2 + mz.^2))));
 
%% Example calculation using data: Remove gravity from accelerometer data
 
indxSel = mod(1:length(xIMUdata.CalInertialMagneticData.Time), 2);              % other index selected; e.g. [1 0 1 0 1 0 1 0 1 ...]
accMtr = [xIMUdata.CalInertialMagneticData.Accelerometer.X(indxSel == 1), ...
          xIMUdata.CalInertialMagneticData.Accelerometer.Y(indxSel == 1), ...
          xIMUdata.CalInertialMagneticData.Accelerometer.Z(indxSel == 1)];      % accelerometer data reduced from 256 Hz to 128 Hz (equal to rotation matrix data)
linAcc = zeros(length(accMtr), 3);
for i = 1:length(accMtr)
    transRot = xIMUdata.RotationMatrixData.RotationMatrix(:,:,i)';              % transpose of matrix describes Earth relative to sensor frame
    linAcc(i,:) = accMtr(i,:) - transRot(:,3)';                                 % 3rd column of rotation matrix describes Earth z-axis (gravity) in sensor frame
end
figure('Name', 'Linear acceleration');
hold on;
plot(xIMUdata.RotationMatrixData.Time, linAcc(:,1), 'r');
plot(xIMUdata.RotationMatrixData.Time, linAcc(:,2), 'g');
plot(xIMUdata.RotationMatrixData.Time, linAcc(:,3), 'b');
xlabel('Time (seconds)');
ylabel('Acceleration (g)');
title('Linear acceleration');
legend('X', 'Y', 'Z');
 
%% End of script