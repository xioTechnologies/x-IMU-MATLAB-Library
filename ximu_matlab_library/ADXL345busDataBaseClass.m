classdef ADXL345busDataBaseClass < TimeSeriesDataBaseClass

    %% Abstract public 'read-only' properties
    properties (Abstract, SetAccess = private)
        FileNameAppendage;
    end

    %% Public 'read-only' properties
    properties (SetAccess = private)
        ADXL345A = struct('X', [], 'Y', [], 'Z', []);
        ADXL345B = struct('X', [], 'Y', [], 'Z', []);
        ADXL345C = struct('X', [], 'Y', [], 'Z', []);
        ADXL345D = struct('X', [], 'Y', [], 'Z', []);
    end

    %% Abstract public methods
    methods (Abstract, Access = public)
        Plot(obj);
    end

    %% Protected methods
    methods (Access = protected)
        function obj = Import(obj, fileNamePrefix)
            data = obj.ImportCSVnumeric(fileNamePrefix);
            obj.ADXL345A.X = data(:,2);
            obj.ADXL345A.Y = data(:,3);
            obj.ADXL345A.Z = data(:,4);
            obj.ADXL345B.X = data(:,5);
            obj.ADXL345B.Y = data(:,6);
            obj.ADXL345B.Z = data(:,7);
            obj.ADXL345C.X = data(:,8);
            obj.ADXL345C.Y = data(:,9);
            obj.ADXL345C.Z = data(:,10);
            obj.ADXL345D.X = data(:,11);
            obj.ADXL345D.Y = data(:,12);
            obj.ADXL345D.Z = data(:,13);
            obj.SampleRate = obj.SampleRate;    % call set method to create time vector
        end
        function fig = PlotRawOrCal(obj, RawOrCal)
            if(obj.NumPackets == 0)
                error('No data to plot.');
            else
                % Define text dependent on Raw or Cal
                if(strcmp(RawOrCal, 'Raw'))
                    figName = 'RawADXL345bus';
                    accelerometerUnits = 'lsb';
                elseif(strcmp(RawOrCal, 'Cal'))
                    figName = 'CalADXL345bus';
                    accelerometerUnits = 'g';
                else
                    error('Invalid argument.');
                end

                % Create time vector and units if SampleRate known
                if(isempty(obj.Time))
                    time = 1:obj.NumPackets;
                    xLabel = 'Sample';
                else
                    time = obj.Time;
                    xLabel = 'Time (s)';
                end

                % Plot data
                fig = figure('Name', figName);
                ax(1) = subplot(4,1,1);
                hold on;
                plot(time, obj.ADXL345A.X, 'r');
                plot(time, obj.ADXL345A.Y, 'g');
                plot(time, obj.ADXL345A.Z, 'b');
                legend('X', 'Y', 'Z');
                xlabel(xLabel);
                ylabel(strcat('Acceleration (', accelerometerUnits, ')'));
                title('ADXL345 A');
                hold off;
                ax(2) = subplot(4,1,2);
                hold on;
                plot(time, obj.ADXL345B.X, 'r');
                plot(time, obj.ADXL345B.Y, 'g');
                plot(time, obj.ADXL345B.Z, 'b');
                legend('X', 'Y', 'Z');
                xlabel(xLabel);
                ylabel(strcat('Acceleration (', accelerometerUnits, ')'));
                title('ADXL345 B');
                hold off;
                ax(3) = subplot(4,1,3);
                hold on;
                plot(time, obj.ADXL345C.X, 'r');
                plot(time, obj.ADXL345C.Y, 'g');
                plot(time, obj.ADXL345C.Z, 'b');
                legend('X', 'Y', 'Z');
                xlabel(xLabel);
                ylabel(strcat('Acceleration (', accelerometerUnits, ')'));
                title('ADXL345 C');
                hold off;
                ax(4) = subplot(4,1,4);
                hold on;
                plot(time, obj.ADXL345D.X, 'r');
                plot(time, obj.ADXL345D.Y, 'g');
                plot(time, obj.ADXL345D.Z, 'b');
                legend('X', 'Y', 'Z');
                xlabel(xLabel);
                ylabel(strcat('Acceleration (', accelerometerUnits, ')'));
                title('ADXL345 D');
                hold off;
                linkaxes(ax,'x');
            end
        end
    end
end