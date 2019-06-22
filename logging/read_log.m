function data = read_log(logname, rowSize)
% takes a binary log of doubles and fits it to a matrix of size [rowSize x ...]

data_log = fopen(logname,'r');
data = fread(data_log, 'double');
data = reshape(data, rowSize, []);

end