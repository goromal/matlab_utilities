function data = read_log(logname, rowSize, doublePrecision)
% takes a binary log of doubles and fits it to a matrix of size [rowSize x ...]

if nargin == 2
    doublePrecision = true;
end

data_log = fopen(logname,'r');
if doublePrecision
    data = fread(data_log, 'double');
else
    data = fread(data_log, 'single');
end
data = reshape(data, rowSize, []);
fclose(data_log);

end