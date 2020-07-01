function [N, E, D] = ecef2ned(x_e2n, ecef_x, ecef_y, ecef_z)

N = zeros(size(ecef_x));
E = zeros(size(ecef_y));
D = zeros(size(ecef_z));

for i = 1:1:length(ecef_x)
    NED = x_e2n.transformp([ecef_x(i); ecef_y(i); ecef_z(i)]);
    N(i) = NED(1);
    E(i) = NED(2);
    D(i) = NED(3);
end

end