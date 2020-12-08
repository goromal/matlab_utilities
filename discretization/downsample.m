function ds_data = downsample(data, ds_size, dimension)

assert(dimension == 1 || dimension == 2)

us_size = size(data, dimension);

assert(ds_size <= us_size)

s = floor(us_size / ds_size);
r =   rem(us_size,  ds_size);

if dimension == 1
    ds_data = data(1:s:end, :);
    q = size(ds_data, 1);
    ss_idx  = spread_remainder_over_indices(q - ds_size, q);
    ds_data(ss_idx, :) = [];
else
    ds_data = data(:, 1:s:end);
    q = size(ds_data, 2);
    ss_idx  = spread_remainder_over_indices(q - ds_size, q);
    ds_data(:, ss_idx) = [];
end

end

function subsample_indices = spread_remainder_over_indices(r, q)

pill_vertices = linspace(0, q, r+1);
subsample_indices = zeros(1, r);
for i = 1:1:r
    subsample_indices(i) = floor(pill_vertices(i+1));
end

end