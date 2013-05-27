classdef xIMUdataClass < handle

    %% Public properties
    properties (SetAccess = private)
        FileNamePrefix = '';
        ErrorData = [];
        CommandData = [];
        RegisterData = [];
        DateTimeData = [];
        RawBattThermData = [];
        CalBattThermData = [];
        RawInertialMagneticData = [];
        CalInertialMagneticData = [];
        QuaternionData = [];
        RotationMatrixData = [];
        EulerAnglesData = [];
        DigitalIOData = [];
    end

    %% Public methods
    methods (Access = public)
        function obj = xIMUdataClass(varargin)
            % Create data objects from files
            obj.FileNamePrefix = varargin{1};
            dataImported = false;
            try obj.ErrorData = ErrorDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.CommandData = CommandDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.RegisterData = RegisterDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.DateTimeData = DateTimeDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.RawBattThermData = RawBattThermDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.CalBattThermData = CalBattThermDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.RawInertialMagneticData = RawInertialMagneticDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.CalInertialMagneticData = CalInertialMagneticDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.QuaternionData = QuaternionDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.EulerAnglesData = EulerAnglesDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.RotationMatrixData = RotationMatrixDataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            try obj.DigitalIOData = DigitalIODataClass(obj.FileNamePrefix); dataImported = true; catch e, end
            if(~dataImported)
                error('No data was imported.');
            end

            % Apply SampleRate from regsiter data
            try h = obj.RawBattThermData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(53)); catch e, end
            try h = obj.CalBattThermData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(53)); catch e, end
            try h = obj.RawInertialMagneticData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(54)); catch e, end
            try h = obj.CalInertialMagneticData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(54)); catch e, end
            try h = obj.QuaternionData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(55)); catch e, end
            try h = obj.RotationMatrixData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(55)); catch e, end
            try h = obj.EulerAnglesData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(55)); catch e, end
            try h = obj.DigitalIOData; h.SampleRate = obj.SampleRateFromRegValue(obj.RegisterData.GetValueAtAddress(63)); catch e, end

            % Appply SampleRate if sepecifed as argument
            for i = 2:2:(nargin)
                if strcmp(varargin{i}, 'BattThermSampleRate')
                    try h = obj.RawBattThermData; h.SampleRate = varargin{i+1}; catch e, end
                    try h = obj.CalBattThermData; h.SampleRate = varargin{i+1}; catch e, end
                elseif strcmp(varargin{i}, 'InertialMagneticSampleRate')
                    try h = obj.RawInertialMagneticData; h.SampleRate = varargin{i+1}; catch e, end
                    try h = obj.CalInertialMagneticData; h.SampleRate = varargin{i+1}; catch e, end
                elseif strcmp(varargin{i}, 'QuaternionSampleRate')
                    try h = obj.QuaternionData; h.SampleRate = varargin{i+1}; catch e, end
                    try h = obj.RotationMatrixData.SampleRate; h.SampleRate = varargin{i+1}; catch e, end
                    try h = obj.EulerAnglesData; h.SampleRate = varargin{i+1}; catch e, end
                elseif strcmp(varargin{i}, 'DigitalIOSampleRate')
                    try h = obj.DigitalIOData; h.SampleRate = varargin{i+1}; catch e, end
                else
                    error('Invalid argument.');
                end
            end
        end
        function obj = Plot(obj)
            try obj.RawBattThermData.Plot(); catch e, end
            try obj.CalBattThermData.Plot(); catch e, end
            try obj.RawInertialMagneticData.Plot(); catch e, end
            try obj.CalInertialMagneticData.Plot(); catch e, end
            try obj.QuaternionData.Plot(); catch e, end
            try obj.EulerAnglesData.Plot(); catch e, end
            try obj.RotationMatrixDataClass.Plot(); catch e, end
            try obj.DigitalIOData.Plot(); catch e, end
        end
    end
    
    %% Private methods
    methods (Access = private)
        function sampleRate = SampleRateFromRegValue(obj, value)
            sampleRate = floor(2^(value-1));
        end
    end
end