fprintf('\r***************** START OF RUN *****************\r');
clear;
close all;

%--------------------------------------------------------------------------  
% Import data

xIMUdata = ImportxIMUdata('Example Data//exampleData', ...
                          'BattThermDataRate', 4, ...
                          'InertialMagDataRate', 256, ...
                          'QuaternionDataRate', 128, ...
                          'DigitalIOdataRate', 0);

%--------------------------------------------------------------------------  
% Plot *_RawBattTherm.csv

if(any(strcmp(fieldnames(xIMUdata), 'RawBattTherm')))
    figure('Position', [10 40 900 400], 'Number', 'off', 'Name', 'RawBattTherm');
    ax(1) = subplot(2,1,1);
        hold on;
        plot(xIMUdata.RawBattTherm.Time, xIMUdata.RawBattTherm.BattVoltage);
        title('Battery Voltage');
        xlabel('Time (s)');
        ylabel('Voltage (lsb)');
        hold off;
    ax(2) = subplot(2,1,2);
        hold on;
        plot(xIMUdata.RawBattTherm.Time, xIMUdata.RawBattTherm.Thermometer);
        title('Thermometer');
        xlabel('Time (s)');
        ylabel('Temperature (lsb)');
        hold off;
    linkaxes(ax,'x'); 
end    

%--------------------------------------------------------------------------  
% Plot *_CalBattTherm.csv

if(any(strcmp(fieldnames(xIMUdata), 'CalBattTherm')))
    figure('Position', [10 40 900 400], 'Number', 'off', 'Name', 'CalBattTherm');
    ax(1) = subplot(2,1,1);
        hold on;
        plot(xIMUdata.CalBattTherm.Time, xIMUdata.CalBattTherm.BattVoltage);
        title('Battery Voltage');
        xlabel('Time (s)');
        ylabel('Voltage (V)');
        hold off;
    ax(2) = subplot(2,1,2);
        hold on;
        plot(xIMUdata.CalBattTherm.Time, xIMUdata.CalBattTherm.Thermometer);
        title('Thermometer');
        xlabel('Time (s)');
        ylabel('Temperature (^\circC)');
        hold off;
    linkaxes(ax,'x'); 
end

%--------------------------------------------------------------------------  
% Plot *_RawInertialMagnetic.csv

if(any(strcmp(fieldnames(xIMUdata), 'RawInertialMagnetic')))
    figure('Position', [10 40 900 600], 'Number', 'off', 'Name', 'RawInertialMagnetic');
    ax(1) = subplot(3,1,1);
        hold on;
        plot(xIMUdata.RawInertialMagnetic.Time, xIMUdata.RawInertialMagnetic.GyrX, 'r');
        plot(xIMUdata.RawInertialMagnetic.Time, xIMUdata.RawInertialMagnetic.GyrY, 'g');
        plot(xIMUdata.RawInertialMagnetic.Time, xIMUdata.RawInertialMagnetic.GyrZ, 'b');
        title('Gyroscope');
        xlabel('Time (s)');
        ylabel('Velocity (lsb)');
        legend('X', 'Y', 'Z');
        hold off;
    ax(2) = subplot(3,1,2);
        hold on;
        plot(xIMUdata.RawInertialMagnetic.Time, xIMUdata.RawInertialMagnetic.AccX, 'r');
        plot(xIMUdata.RawInertialMagnetic.Time, xIMUdata.RawInertialMagnetic.AccY, 'g');
        plot(xIMUdata.RawInertialMagnetic.Time, xIMUdata.RawInertialMagnetic.AccZ, 'b');
        title('Accelerometer');
        xlabel('Time (s)');
        ylabel('Acceleration (lsb)');
        legend('X', 'Y', 'Z');        
        hold off;
    ax(3) = subplot(3,1,3);
        hold on;
        plot(xIMUdata.RawInertialMagnetic.Time, xIMUdata.RawInertialMagnetic.MagX, 'r');
        plot(xIMUdata.RawInertialMagnetic.Time, xIMUdata.RawInertialMagnetic.MagY, 'g');
        plot(xIMUdata.RawInertialMagnetic.Time, xIMUdata.RawInertialMagnetic.MagZ, 'b');
        title('Magnetometer');
        xlabel('Time (s)');
        ylabel('Flux (lsb)');
        legend('X', 'Y', 'Z');        
        hold off;        
    linkaxes(ax,'x'); 
end  

%--------------------------------------------------------------------------  
% Plot *_CalInertialMagnetic.csv

if(any(strcmp(fieldnames(xIMUdata), 'CalInertialMagnetic')))
    figure('Position', [10 40 900 600], 'Number', 'off', 'Name', 'CalInertialMagnetic');
    ax(1) = subplot(3,1,1);
        hold on;
        plot(xIMUdata.CalInertialMagnetic.Time, xIMUdata.CalInertialMagnetic.GyrX, 'r');
        plot(xIMUdata.CalInertialMagnetic.Time, xIMUdata.CalInertialMagnetic.GyrY, 'g');
        plot(xIMUdata.CalInertialMagnetic.Time, xIMUdata.CalInertialMagnetic.GyrZ, 'b');
        title('Gyroscope');
        xlabel('Time (s)');
        ylabel('Velocity (^\circ/s)');
        legend('X', 'Y', 'Z');
        hold off;
    ax(2) = subplot(3,1,2);
        hold on;
        plot(xIMUdata.CalInertialMagnetic.Time, xIMUdata.CalInertialMagnetic.AccX, 'r');
        plot(xIMUdata.CalInertialMagnetic.Time, xIMUdata.CalInertialMagnetic.AccY, 'g');
        plot(xIMUdata.CalInertialMagnetic.Time, xIMUdata.CalInertialMagnetic.AccZ, 'b');
        title('Accelerometer');
        xlabel('Time (s)');
        ylabel('Acceleration (g)');
        legend('X', 'Y', 'Z');        
        hold off;
    ax(3) = subplot(3,1,3);
        hold on;
        plot(xIMUdata.CalInertialMagnetic.Time, xIMUdata.CalInertialMagnetic.MagX, 'r');
        plot(xIMUdata.CalInertialMagnetic.Time, xIMUdata.CalInertialMagnetic.MagY, 'g');
        plot(xIMUdata.CalInertialMagnetic.Time, xIMUdata.CalInertialMagnetic.MagZ, 'b');
        title('Magnetometer');
        xlabel('Time (s)');
        ylabel('Flux (G)');
        legend('X', 'Y', 'Z');        
        hold off;        
    linkaxes(ax,'x'); 
end  

%--------------------------------------------------------------------------  
% Plot *_EulerAngles.csv

if(any(strcmp(fieldnames(xIMUdata), 'EulerAngles')))
    figure('Position', [10 40 900 300], 'Number', 'off', 'Name', 'EulerAngles');
    hold on;
    plot(xIMUdata.EulerAngles.Time, xIMUdata.EulerAngles.Pitch, 'r');
    plot(xIMUdata.EulerAngles.Time, xIMUdata.EulerAngles.Roll, 'g');
    plot(xIMUdata.EulerAngles.Time, xIMUdata.EulerAngles.Yaw, 'b');
    title('Euler angles');
    xlabel('Time (s)');
    ylabel('Angle (^\circ)');
    legend('Pitch (X)', 'Roll (Y)', 'Yaw (Z)');
    hold off;
end 

%--------------------------------------------------------------------------  
% Plot *_DigitalIO.csv

if(any(strcmp(fieldnames(xIMUdata), 'DigitalIO')))
    figure('Position', [10 40 900 300], 'Number', 'off', 'Name', 'DigitalIO');
    hold on;
    plot(xIMUdata.DigitalIO.AX0, 'r');
    plot(xIMUdata.DigitalIO.AX1, 'g');
    plot(xIMUdata.DigitalIO.AX2, 'b');
    plot(xIMUdata.DigitalIO.AX3, 'k');
    plot(xIMUdata.DigitalIO.AX4, ':r');
    plot(xIMUdata.DigitalIO.AX5, ':g');
    plot(xIMUdata.DigitalIO.AX6, ':b');
    plot(xIMUdata.DigitalIO.AX7, ':k');
    title('Digital I/O');
    xlabel('Sample');
    ylabel('State (Binary)');
    legend('AX0', 'AX1', 'AX2', 'AX3', 'AX4', 'AX5', 'AX6', 'AX7');
    hold off;
end 

%--------------------------------------------------------------------------  
% End of file
 
fprintf('\r****************** END OF RUN ******************\r');