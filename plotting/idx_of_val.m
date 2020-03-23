function idx = idx_of_val(data, val)

[~, idx] = min(abs(data - val));

end