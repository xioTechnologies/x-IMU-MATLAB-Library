function xIMUdata = ImportxIMUdata(varargin)
    % Version 1.0
    %
    % EXAMPLE: xIMUdata = ImportxIMUdata(loggedData, '<property name>', <property value>, ...);
    % 'PrintProgress' , true = prints progress, false = nothing is printed to command terminal
    % 'BattThermDataRate' , BattThermDataRate (in Hz) used to create time vector. 0 = do not create vector.
    % 'InertialMagDataRate' , InertialMagDataRate (in Hz) used to create time vector. 0 = do not create vector.
    % 'QuaternionDataRate' , QuaternionDataRate (in Hz) used to create time vector. 0 = do not create vector.
    % 'DigitalIOdataRate' , DigitalIOdataRate (in Hz) used to create time vector. 0 = do not create vector.   

    %----------------------------------------------------------------------  
    % Create loval variables
    
    PrintProgress = true;
    BattThermDataRate = 0;
    InertialMagDataRate = 0;
    QuaternionDataRate = 0;
    DigitalIOdataRate = 0;
    
    fileNamePrefix = varargin{1};
    for i = 2:2:nargin
        if  strcmp(varargin{i}, 'PrintProgress'), PrintProgress = varargin{i+1};
        elseif  strcmp(varargin{i}, 'BattThermDataRate'), BattThermDataRate = varargin{i+1};
        elseif  strcmp(varargin{i}, 'InertialMagDataRate'), InertialMagDataRate = varargin{i+1};
        elseif  strcmp(varargin{i}, 'QuaternionDataRate'), QuaternionDataRate = varargin{i+1};
    	elseif  strcmp(varargin{i}, 'DigitalIOdataRate'), DigitalIOdataRate = varargin{i+1};
        else error('Invalid argument');
        end
    end;  

    %----------------------------------------------------------------------   
    % Start message
    
    if(PrintProgress); fprintf('\rImporting x-IMU data files:'); end;
    
	%----------------------------------------------------------------------   
    % Import *_RawBattTherm.csv
    
    fileName = strcat(fileNamePrefix, '_RawBattTherm.csv');
    if(exist(fileName, 'file'))
        if(PrintProgress);  fprintf(strcat('\r', fileName, '...')); end;
        M = dlmread(fileName, ',', 1, 0);                                   % import data
        if(BattThermDataRate ~= 0)
            [numRow numCol] = size(M);                                      % fetch number of samples (rows)
            RawBattTherm.Time = [0:numRow-1]' * (1/BattThermDataRate);      % create time vector
        end
        RawBattTherm.BattVoltage = M(:,1);                                  % import data columns
        RawBattTherm.Thermometer = M(:,2);
        xIMUdata.RawBattTherm = RawBattTherm;                               % add sub structure to xIMUdata structure
        clear('M', 'RawBattTherm');                                         % free RAM
        if(PrintProgress); fprintf(' Done!'); end;
    end    
    
    %----------------------------------------------------------------------   
    % Import *_CalBattTherm.csv
    
    fileName = strcat(fileNamePrefix, '_CalBattTherm.csv');
    if(exist(fileName, 'file'))
        if(PrintProgress);  fprintf(strcat('\r', fileName, '...')); end;
        M = dlmread(fileName, ',', 1, 0);                                   % import data
        if(BattThermDataRate ~= 0)
            [numRow numCol] = size(M);                                      % fetch number of samples (rows)
            CalBattTherm.Time = [0:numRow-1]' * (1/BattThermDataRate);      % create time vector
        end
        CalBattTherm.BattVoltage = M(:,1);                                  % import data columns
        CalBattTherm.Thermometer = M(:,2);
        xIMUdata.CalBattTherm = CalBattTherm;                               % add sub structure to xIMUdata structure
        clear('M', 'CalBattTherm');                                         % free RAM
        if(PrintProgress); fprintf(' Done!'); end;
    end
    
	%----------------------------------------------------------------------   
    % Import *_RawInertialMagnetic.csv
    
    fileName = strcat(fileNamePrefix, '_RawInertialMagnetic.csv');
    if(exist(fileName, 'file'))
        if(PrintProgress);  fprintf(strcat('\r', fileName, '...')); end;
        M = dlmread(fileName, ',', 1, 0);                                       % import file
        if(InertialMagDataRate ~= 0)
            [numRow numCol] = size(M);                                          % fetch number of samples (rows)
            RawInertialMagnetic.Time = [0:numRow-1]' * (1/InertialMagDataRate);	% create time vector
        end
        RawInertialMagnetic.GyrX = M(:,1);                                      % import data columns
        RawInertialMagnetic.GyrY = M(:,2);
        RawInertialMagnetic.GyrZ = M(:,3);
        RawInertialMagnetic.AccX = M(:,4);
        RawInertialMagnetic.AccY = M(:,5);
        RawInertialMagnetic.AccZ = M(:,6);       
        RawInertialMagnetic.MagX = M(:,7);
        RawInertialMagnetic.MagY = M(:,8);
        RawInertialMagnetic.MagZ = M(:,9);          
        xIMUdata.RawInertialMagnetic = RawInertialMagnetic;                 	% add sub structure to xIMUdata structure
        clear('M', 'RawInertialMagnetic');                                      % free RAM
        if(PrintProgress); fprintf(' Done!'); end;
    end     
    
    %----------------------------------------------------------------------   
    % Import *_CalInertialMagnetic.csv
    
    fileName = strcat(fileNamePrefix, '_CalInertialMagnetic.csv');
    if(exist(fileName, 'file'))
        if(PrintProgress);  fprintf(strcat('\r', fileName, '...')); end;
        M = dlmread(fileName, ',', 1, 0);                                       % import file
        if(InertialMagDataRate ~= 0)
            [numRow numCol] = size(M);                                          % fetch number of samples (rows)
            CalInertialMagnetic.Time = [0:numRow-1]' * (1/InertialMagDataRate);	% create time vector
        end
        CalInertialMagnetic.GyrX = M(:,1);                                      % import data columns
        CalInertialMagnetic.GyrY = M(:,2);
        CalInertialMagnetic.GyrZ = M(:,3);
        CalInertialMagnetic.AccX = M(:,4);
        CalInertialMagnetic.AccY = M(:,5);
        CalInertialMagnetic.AccZ = M(:,6);       
        CalInertialMagnetic.MagX = M(:,7);
        CalInertialMagnetic.MagY = M(:,8);
        CalInertialMagnetic.MagZ = M(:,9);          
        xIMUdata.CalInertialMagnetic = CalInertialMagnetic;                 	% add sub structure to xIMUdata structure
        clear('M', 'CalInertialMagnetic');                                      % free RAM
        if(PrintProgress); fprintf(' Done!'); end;
    end    
    
	%----------------------------------------------------------------------   
    % Import *_Quaternion.csv
    
    fileName = strcat(fileNamePrefix, '_Quaternion.csv');
    if(exist(fileName, 'file'))
        if(PrintProgress);  fprintf(strcat('\r', fileName, '...')); end;
        M = dlmread(fileName, ',', 1, 0);                               	% import file
        if(QuaternionDataRate ~= 0)
            [numRow numCol] = size(M);                                  	% fetch number of samples (rows)
            Quaternion.Time = [0:numRow-1]' * (1/QuaternionDataRate);       % create time vector
        end
        Quaternion.Quaternion = M(:,1:4);                                   % import data columns      
        xIMUdata.Quaternion = Quaternion;                                   % add sub structure to xIMUdata structure
        clear('M', 'Quaternion');                                           % free RAM
        if(PrintProgress); fprintf(' Done!'); end;
    end      
    
	%----------------------------------------------------------------------   
    % Import *_RotationMatrix.csv
    
    fileName = strcat(fileNamePrefix, '_RotationMatrix.csv');
    if(exist(fileName, 'file'))
        if(PrintProgress);  fprintf(strcat('\r', fileName, '...')); end;
        M = dlmread(fileName, ',', 1, 0);                               	% import file
        if(QuaternionDataRate ~= 0)
            [numRow numCol] = size(M);                                  	% fetch number of samples (rows)
            RotationMatrix.Time = [0:numRow-1]' * (1/QuaternionDataRate);	% create time vector
        end
        RotationMatrix.RotationMatrix = zeros(3, 3, numRow);
        RotationMatrix.RotationMatrix(1,1,:) = M(:,1);                      % import data columns 
        RotationMatrix.RotationMatrix(1,2,:) = M(:,2);
        RotationMatrix.RotationMatrix(1,3,:) = M(:,3);
        RotationMatrix.RotationMatrix(2,1,:) = M(:,4);
        RotationMatrix.RotationMatrix(2,2,:) = M(:,5);
        RotationMatrix.RotationMatrix(2,3,:) = M(:,6);
        RotationMatrix.RotationMatrix(3,1,:) = M(:,7);
        RotationMatrix.RotationMatrix(3,2,:) = M(:,8);
        RotationMatrix.RotationMatrix(3,3,:) = M(:,9);       
        xIMUdata.RotationMatrix = RotationMatrix;                       	% add sub structure to xIMUdata structure
        clear('M', 'RotationMatrix');                                       % free RAM
        if(PrintProgress); fprintf(' Done!'); end;
    end
    
	%----------------------------------------------------------------------   
    % Import *_EulerAngles.csv
    
    fileName = strcat(fileNamePrefix, '_EulerAngles.csv');
    if(exist(fileName, 'file'))
        if(PrintProgress);  fprintf(strcat('\r', fileName, '...')); end;
        M = dlmread(fileName, ',', 1, 0);                               	% import file
        if(QuaternionDataRate ~= 0)
            [numRow numCol] = size(M);                                  	% fetch number of samples (rows)
            EulerAngles.Time = [0:numRow-1]' * (1/QuaternionDataRate);      % create time vector
        end
        EulerAngles.Pitch = M(:,1);                                         % import data columns
        EulerAngles.Roll = M(:,2);
        EulerAngles.Yaw = M(:,3);       
        xIMUdata.EulerAngles = EulerAngles;                                 % add sub structure to xIMUdata structure
        clear('M', 'EulerAngles');                                      	% free RAM
        if(PrintProgress); fprintf(' Done!'); end;
    end
    
	%----------------------------------------------------------------------   
    % Import *_DigitalIO.csv    
    
    fileName = strcat(fileNamePrefix, '_DigitalIO.csv');
    if(exist(fileName, 'file'))
        if(PrintProgress);  fprintf(strcat('\r', fileName, '...')); end;
        M = dlmread(fileName, ',', 1, 8);                               	% import file
        if(DigitalIOdataRate ~= 0)
            [numRow numCol] = size(M);                                  	% fetch number of samples (rows)
            DigitalIO.Time = [0:numRow-1]' * (1/DigitalIOdataRate);         % create time vector
        end
        DigitalIO.AX0 = M(:,1);                                             % import data columns
        DigitalIO.AX1 = M(:,2);
        DigitalIO.AX2 = M(:,3);
        DigitalIO.AX3 = M(:,4);
        DigitalIO.AX4 = M(:,5);
        DigitalIO.AX5 = M(:,6);
        DigitalIO.AX6 = M(:,7);
        DigitalIO.AX7 = M(:,8);
        xIMUdata.DigitalIO = DigitalIO;                                     % add sub structure to xIMUdata structure
        clear('M', 'DigitalIO');                                            % free RAM
        if(PrintProgress); fprintf(' Done!'); end;
    end
    
	%----------------------------------------------------------------------   
    % Handle no files found error
    
    if(~exist('xIMUdata', 'var'))
        xIMUdata = 0;
        if(PrintProgress); fprintf('\rNo files found.'); end;
    end
    
	%----------------------------------------------------------------------   
    % Print end message
    
	if(PrintProgress); fprintf('\rComplete!\r'); end;
    
end
