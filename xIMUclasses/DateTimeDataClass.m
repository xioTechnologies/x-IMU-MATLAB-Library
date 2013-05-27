classdef DateTimeDataClass < handle

    %% Public 'read-only' properties

    properties (SetAccess = private)
        String = [];
        Vector = [];
        Serial = [];
    end

    %% Public 'read-only' properties

    properties (SetAccess = private)
        FileNameAppendage = '_DateTime.txt';
    end

    %% Public methods

    methods (Access = public)
        function obj = Import(obj, fileNamePrefix)

            % Read text file and construct date vector
            tokens = textread(strcat(fileNamePrefix, obj.FileNameAppendage), '%s');
            if(~isempty(tokens))
                obj.Vector(1) = str2double(char(tokens(3)));
                switch(char(tokens(2)))
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
                obj.Vector(3) = str2double(char(tokens(1)));
                [token remain] = strtok(tokens(4), ':');
                obj.Vector(4) = str2double(char(token));
                [token remain] = strtok(remain, ':');
                obj.Vector(5) = str2double(char(token));
                token = strtok(remain, ':');
                obj.Vector(6) = str2double(char(token));

                % Create date string from date vector
                obj.String = datestr(obj.Vector);

                % Create date serial from date vector
                obj.Serial = datenum(obj.Vector);
            end
        end
    end

end

%% End of class