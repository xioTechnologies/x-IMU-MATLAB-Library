classdef BattThermDataBaseClass < TimeSeriesDataBaseClass

    %% Abstract public 'read-only' properties
    properties (Abstract, SetAccess = private)
        FileNameAppendage;
    end

    %% Public 'read-only' properties
    properties (SetAccess = private)
        Battery = [];
        Thermometer = [];
    end

    %% Abstract public methods
    methods (Abstract, Access = public)
        Plot(obj);
    end

    %% Protected methods
    methods (Access = protected)
        function obj = Import(obj, fileNamePrefix)
            data = obj.ImportCSVnumeric(fileNamePrefix);
            obj.Battery = data(:,2);
            obj.Thermometer = data(:,3);
            obj.SampleRate = obj.SampleRate;    % call set method to create time vector
        end
        function fig = PlotRawOrCal(obj, RawOrCal)
            if(obj.NumPackets == 0)
                error('No data to plot.');
            else
                % Define text dependent on Raw or Cal
                if(strcmp(RawOrCal, 'Raw'))
                    figName = 'RawBattTherm';
                    batteryUnits = 'lsb';
                    thermometerUnits = 'lsb';
                elseif(strcmp(RawOrCal, 'Cal'))
                    figName = 'CalBattTherm';
                    batteryUnits = 'V';
                    thermometerUnits = '^\circC';
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
                ax(1) = subplot(2,1,1);
                hold on;
                plot(time, obj.Battery);
                xlabel(xLabel);
                ylabel(strcat('Voltage (', batteryUnits, ')'));
                title('Battery Voltmeter');
                hold off;
                ax(2) = subplot(2,1,2);
                hold on;
                plot(time, obj.Thermometer);
                xlabel(xLabel);
                ylabel(strcat('Temperature (', thermometerUnits, ')'));
                title('Thermometer');
                hold off;
                linkaxes(ax,'x');
            end
        end
    end
end