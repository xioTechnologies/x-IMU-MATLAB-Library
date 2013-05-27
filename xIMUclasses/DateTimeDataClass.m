classdef DateTimeDataClass < DataBaseClass

    %% Public 'read-only' properties
    properties (SetAccess = private)
        FileNameAppendage = '_DateTime.csv';
        String = [];
        Vector = [];
        Serial = [];
    end

    %% Public methods
    methods (Access = public)
        function obj = DateTimeDataClass(fileNamePrefix)
            data = obj.ImportCSVmixed(fileNamePrefix, '%d %s');
            obj.Vector = zeros(obj.NumPackets, 6);
            for i = 1:obj.NumPackets
                obj.Vector(i,:) = obj.ExtarctVector(char(data{2}(i)));
            end
            obj.String = cellstr(datestr(obj.Vector));
            obj.Serial = datenum(obj.Vector);
        end
    end

    %% Private methods
    methods (Access = protected)
        function vector = ExtarctVector(obj, dateTime)
            dateTimeSplit = regexpi(dateTime, ' ', 'split');
            timeSplit = regexpi(dateTimeSplit{4}, ':', 'split');
            vector(1) = str2double(dateTimeSplit{3});
            switch(dateTimeSplit{2})
                case('January'), vector(2) = 1;
                case('February'), vector(2) = 2;
                case('March'), vector(2) = 3;
                case('April'), vector(2) = 4;
                case('May'), vector(2) = 5;
                case('June'), vector(2) = 6;
                case('July'), vector(2) = 7;
                case('August'), vector(2) = 8;
                case('September'), vector(2) = 9;
                case('October'), vector(2) = 10;
                case('November'), vector(2) = 11;
                case('December'), vector(2) = 12;
            end
            vector(3) = str2double(dateTimeSplit{1});
            vector(4) = str2double(timeSplit{1});
            vector(5) = str2double(timeSplit{2});
            vector(6) = str2double(timeSplit{3});
        end
    end
end