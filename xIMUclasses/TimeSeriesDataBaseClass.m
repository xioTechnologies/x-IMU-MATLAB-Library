classdef TimeSeriesDataBaseClass < DataBaseClass

    %% Abstract public 'read-only' properties
    properties (Abstract, SetAccess = private)
        FileNameAppendage;
    end

    %% Public 'read-only' properties
    properties (SetAccess = private)
        Time = [];
        SamplePeriod = 0;
    end

    %% Public properties
    properties (Access = public)
        SampleRate = 0;
    end

    %% Abstract public methods
    methods (Abstract, Access = public)
        Plot(obj);
    end

    %% Get/set methods
    methods
        function obj = set.SampleRate(obj, sampleRate)
            obj.SampleRate = sampleRate;
            if(obj.SampleRate == 0)
                obj.Time = [];
            elseif(obj.NumPackets ~= 0)
                obj.Time = (0:obj.NumPackets-1)' * (1/obj.SampleRate);
            end
        end
        function samplePeriod = get.SamplePeriod(obj)
            if(obj.SampleRate == 0)
                samplePeriod = 0;
            else
                samplePeriod = 1 / obj.SampleRate;
            end
        end
    end
end