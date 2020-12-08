function [] = write_log(data, logname, doublePrecision)
% takes a matrix of doubles and strings the columns together, writing one long 
% string of doubles to a binary file
sz = size(data);
Log = fopen(logname,'w');
if doublePrecision
    fwrite(Log, reshape(data, [1, sz(1)*sz(2)]), 'double');
else
    fwrite(Log, reshape(data, [1, sz(1)*sz(2)]), 'single');
end
fclose(Log);

end