%% xIMUdataClass_ExampleUsage.m
% MATLAB x-IMU Library Version 2.0

addpath('xIMUclasses');     % include class library
close all;                  % close all figures
clear;                      % clear all variables
clc;                        % clear the command terminal

%% Basic usage

xIMUdata = xIMUdataClass('exampleData\exampleData')
xIMUdata.Plot();

%% End of script

