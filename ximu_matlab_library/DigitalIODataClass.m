classdef DigitalIODataClass < TimeSeriesDataBaseClass

    %% Public 'read-only' properties
    properties (SetAccess = private)
        FileNameAppendage = '_DigitalIO.csv';
        AX0 = struct('Direction', [], 'State', []);
        AX1 = struct('Direction', [], 'State', []);
        AX2 = struct('Direction', [], 'State', []);
        AX3 = struct('Direction', [], 'State', []);
        AX4 = struct('Direction', [], 'State', []);
        AX5 = struct('Direction', [], 'State', []);
        AX6 = struct('Direction', [], 'State', []);
        AX7 = struct('Direction', [], 'State', []);
    end

    %% Public methods
    methods (Access = public)
        function obj = DigitalIODataClass(varargin)
            fileNamePrefix = varargin{1};
            for i = 2:2:nargin
                if  strcmp(varargin{i}, 'SampleRate'), obj.SampleRate = varargin{i+1};
                else error('Invalid argument.');
                end
            end
            data = obj.ImportCSVnumeric(fileNamePrefix);
            obj.AX0.Direction = data(:,2);
            obj.AX1.Direction  = data(:,3);
            obj.AX2.Direction  = data(:,4);
            obj.AX3.Direction  = data(:,5);
            obj.AX4.Direction  = data(:,6);
            obj.AX5.Direction  = data(:,7);
            obj.AX6.Direction  = data(:,8);
            obj.AX7.Direction  = data(:,9);
            obj.AX0.State = data(:,10);
            obj.AX1.State  = data(:,11);
            obj.AX2.State  = data(:,12);
            obj.AX3.State  = data(:,13);
            obj.AX4.State  = data(:,14);
            obj.AX5.State  = data(:,15);
            obj.AX6.State  = data(:,16);
            obj.AX7.State  = data(:,17);
            obj.SampleRate = obj.SampleRate;    % call set method to create time vector
        end
        function fig = Plot(obj)
            if(obj.NumPackets == 0)
                error('No data to plot.');
            else
                % Create time vector and units if SampleRate known
                if(isempty(obj.Time))
                    time = 1:obj.NumPackets;
                    xLabel = 'Sample';
                else
                    time = obj.Time;
                    xLabel = 'Time (s)';
                end

                % Plot data
                fig =  figure('Name', 'DigitalIO');
                hold on;
                plot(time, obj.AX0.State, 'r');
                plot(time, obj.AX1.State, 'g');
                plot(time, obj.AX2.State, 'b');
                plot(time, obj.AX3.State, 'k');
                plot(time, obj.AX4.State, ':r');
                plot(time, obj.AX5.State, ':g');
                plot(time, obj.AX6.State, ':b');
                plot(time, obj.AX7.State, ':k');
                title('Digital I/O');
                xlabel(xLabel);
                ylabel('State (Binary)');
                legend('AX0', 'AX1', 'AX2', 'AX3', 'AX4', 'AX5', 'AX6', 'AX7');
                hold off;
            end
        end
    end
end