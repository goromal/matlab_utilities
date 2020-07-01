function [ecef_x, ecef_y, ecef_z] = ned2ecef(x_e2n, N, E, D)

ecef_x = zeros(size(N));
ecef_y = zeros(size(E));
ecef_z = zeros(size(D));

for i = 1:1:length(N)
    ecef = x_e2n.transforma([N(i); E(i); D(i)]);
    ecef_x(i) = ecef(1);
    ecef_y(i) = ecef(2);
    ecef_z(i) = ecef(3);
end

end