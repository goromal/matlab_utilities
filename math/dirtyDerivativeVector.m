function y_dot = dirtyDerivativeVector( t, y )

dt = [0 diff(t)];
sigma = 0.05;
y_dot = zeros(size(y));

for i = 2:1:length(y)
    Ts = dt(i);
    y_dot_prev = y_dot(i-1);
    val = y(i);
    val_prev = y(i-1);
    y_dot(i) = (2 * sigma - Ts) / (2 * sigma + Ts) * y_dot_prev + ...
               2 / (2 * sigma + Ts) * (val - val_prev);
end

end