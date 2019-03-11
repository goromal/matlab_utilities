function flatmean = flat_average(data, epsilon)
% Take a set of "almost flat" data (with outliers) and calculate the mean,
% removing outliers by modifying the data until the standard deviation of 
% the data is < epsilon

% calculate initial mean and standard deviation
mu = mean(data);
sigma = std(data);

% remove outliers until standard deviation is smaller than epsilon
while (sigma > epsilon)
    for i = 1:length(data)
        if (abs(data(i) - mu) > sigma)
            data(i) = mu;
        end
    end
    mu = mean(data);
    sigma = std(data);
end

% return mean of flattened data
flatmean = mu;

end
