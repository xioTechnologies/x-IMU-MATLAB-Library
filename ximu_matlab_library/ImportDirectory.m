function xIMUdataStruct = ImportDirectory(DataDirectory)

    %% Import CSV files
    listing = dir(strcat(DataDirectory, '\*_*.csv'));           % list all *_*.csv files in directory
    fileNamePrefixes = unique(strtok({listing.name}, '_'));     % list unique file name prefixes (e.g. name_*.csv)
    xIMUdataObjs = cell(length(fileNamePrefixes), 1);
    for i = 1:length(fileNamePrefixes)
        try xIMUdataObjs{i} = xIMUdataClass(strcat(DataDirectory, '\', fileNamePrefixes{i})); catch e, end
    end
    fileNamePrefixes(cellfun(@isempty,xIMUdataObjs)) = [];      % remove failures from lists
    xIMUdataObjs(cellfun(@isempty,xIMUdataObjs)) = [];
    if(numel(xIMUdataObjs) == 0)
        error('No data was imported.');
    end

    %% Organise data in structure
    fieldNames = cell(numel(xIMUdataObjs), 1);
    try                                                         % try using device IDs as structure field names
        for i = 1:numel(xIMUdataObjs)
            fieldNames{i} = strcat('ID_', dec2hex(xIMUdataObjs{i}.RegisterData.GetValueAtAddress(2)));
        end
        xIMUdataStruct = orderfields(cell2struct(xIMUdataObjs, fieldNames, 1));
    catch e                                                     % otherwise use file name prefix (alpha-numeric characters only)
        for i = 1:numel(xIMUdataObjs)
            fieldNames{i} = strcat('FILE_', fileNamePrefixes{i}(isstrprop(fileNamePrefixes{i}, 'alphanum')));
        end        
        xIMUdataStruct = orderfields(cell2struct(xIMUdataObjs, fieldNames, 1));
    end
end
