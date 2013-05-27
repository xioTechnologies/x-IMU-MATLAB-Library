classdef DateTimeDataClass < handle

    %% Public 'read-only' properties

    properties (SetAccess = private)
        String = [];
        Vector = [];
        Serial = [];
    end

    %% Public 'read-only' properties

    properties (SetAccess = private)
        FileNameAppendage = '_DateTime.csv';
    end

    %% Public methods

    methods (Access = public)
        function obj = Import(obj, fileNamePrefix)

            % Get date/time as first CSV line of file
            file = fopen(strcat(fileNamePrefix, obj.FileNameAppendage));
            CSVline = fgets(file);                              % disregard column headings
            CSVline = fgets(file);
            fclose(file);
            [packetNumber dateTime] = strtok(CSVline, ',');
            dateTime = dateTime(2:end);                         % ignore ',' first character
                        
            % Construct date vector
            dateTimeSplit = regexpi(dateTime, ' ', 'split');
            timeSplit = regexpi(dateTimeSplit{4}, ':', 'split');
            obj.Vector(1) = str2double(dateTimeSplit{3});
            switch(dateTimeSplit{2})
                case('January')
                    obj.Vector(2) = 1;
                case('February')
                    obj.Vector(2) = 2;
                case('March')
                    obj.Vector(2) = 3;
                case('April')
                    obj.Vector(2) = 4;
                case('May')
                    obj.Vector(2) = 5;
                case('June')
                    obj.Vector(2) = 6;
                case('July')
                    obj.Vector(2) = 7;
                case('August')
                    obj.Vector(2) = 8;
                case('September')
                    obj.Vector(2) = 9;
                case('October')
                    obj.Vector(2) = 10;
                case('November')
                    obj.Vector(2) = 11;
                case('December')
                    obj.Vector(2) = 12;
            end
            obj.Vector(3) = str2double(dateTimeSplit{1});
            obj.Vector(4) = str2double(timeSplit{1});
            obj.Vector(5) = str2double(timeSplit{2});
            obj.Vector(6) = str2double(timeSplit{3});

            % Create date string from date vector
            obj.String = datestr(obj.Vector);

            % Create date serial from date vector
            obj.Serial = datenum(obj.Vector);
        end
    end

end

%% End of class