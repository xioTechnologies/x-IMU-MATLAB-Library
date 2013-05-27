function xIMUdata = SyncroniseData(varargin)

    %% Apply arguments
    xIMUdata = varargin{1};
    xIMUdataObjs = struct2cell(xIMUdata);
    StartEvent = [];
    EndEvent = [];
    for i = 2:2:(nargin)
        if strcmp(varargin{i}, 'StartEvent'), StartEvent = varargin{i+1};
        elseif strcmp(varargin{i}, 'EndEvent'), EndEvent = varargin{i+1};
        else error('Invalid argument.');
        end
    end

    %% Modify start times to synchronise start of window
    if(numel(StartEvent) ~= numel(xIMUdataObjs))
        error('Length of StartEvent vector must equal number of xIMUdataClass objects');
    end
    for i = 1:numel(xIMUdataObjs)
        try h = xIMUdataObjs{i}.RawBattThermData; h.StartTime = -StartEvent(i); catch e, end
        try h = xIMUdataObjs{i}.CalBattThermData; h.StartTime = -StartEvent(i); catch e, end
        try h = xIMUdataObjs{i}.RawInertialMagneticData; h.StartTime = -StartEvent(i); catch e, end
        try h = xIMUdataObjs{i}.CalInertialMagneticData; h.StartTime = -StartEvent(i); catch e, end
        try h = xIMUdataObjs{i}.QuaternionData; h.StartTime = -StartEvent(i); catch e, end
        try h = xIMUdataObjs{i}.RotationMatrixData; h.StartTime = -StartEvent(i); catch e, end
        try h = xIMUdataObjs{i}.EulerAnglesData; h.StartTime = -StartEvent(i); catch e, end
        try h = xIMUdataObjs{i}.DigitalIOData; h.StartTime = -StartEvent(i); catch e, end
    end

    %% Modify sample rate to synchronise end of window
    if(numel(EndEvent) == 0)
        return;
    end
    if(numel(EndEvent) ~= numel(xIMUdataObjs))
        error('Length of EndEvent vector must equal number of xIMUdataClass objects');
    end
	scalers = (EndEvent - StartEvent) * (1/((EndEvent(1)-StartEvent(1))));
    for i = 2:numel(xIMUdataObjs)
        try h = xIMUdataObjs{i}.RawBattThermData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEvent(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.CalBattThermData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEvent(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.RawInertialMagneticData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEvent(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.CalInertialMagneticData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = -StartEvent(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.QuaternionData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEvent(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.RotationMatrixData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEvent(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.EulerAnglesData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEvent(i)/scalers(i); catch e, end
        try h = xIMUdataObjs{i}.DigitalIOData; h.SampleRate = scalers(i)*h.SampleRate; h.StartTime = StartEvent(i)/scalers(i); catch e, end
    end
end
