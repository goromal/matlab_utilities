function [lat, lon, alt] = ecef2lla(ecef_x, ecef_y, ecef_z)

P = WGS84_PARAMS();

r2 = ecef_x .* ecef_x + ecef_y .* ecef_y;
lat = zeros(size(ecef_x));
lon = zeros(size(ecef_y));
alt = zeros(size(ecef_z));
z = ecef_z;
zk = 1e9 * ones(size(ecef_x));

for i = 1:1:length(ecef_z)
    
    while (abs(z(i) - zk(i)) >= 1e-4)
        zk(i) = z(i);
        sinp = z(i) / sqrt(r2(i) + z(i) * z(i));
        v = P.A / sqrt(1.0 - P.E2 * sinp * sinp);
        z(i) = ecef_z(i) + v * P.E2 * sinp;
    end
    
    if r2(i) > 1e-12
        lat(i) = atan(z(i) / sqrt(r2(i)));
        lon(i) = atan2(ecef_y(i), ecef_x(i));
    else
        lon(i) = 0.0;
        if ecef_z > 0
            lat(i) = pi/2;
        else
            lat(i) = -pi/2;
        end
    end
    alt(i) = sqrt(r2(i)+z(i)*z(i)) - v;
        
end

end