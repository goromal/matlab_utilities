function indices = get_indices_from_time(data, skip_num, lower, upper)

if nargin == 2
    lower = -inf;
    upper = inf;
end

indices = [];

skip_idx = 0;
for i = 1:1:length(data)
     if data(i) > lower && data(i) < upper
         skip_idx = skip_idx + 1;
         if mod(skip_idx, skip_num) == 0
             indices = [indices i];
             skip_idx = 0;
         end
     end
end

end