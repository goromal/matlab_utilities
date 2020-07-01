function [ecef_x, ecef_y, ecef_z] = lla2ecef(lat, lon, alt)

P = WGS84_PARAMS();

sinp = sin(lat);
cosp = cos(lat);
sinl = sin(lon);
cosl = cos(lon);

v = P.A ./ sqrt(1.0 - P.E2 .* sinp .* sinp);

ecef_x = (v + alt) .* cosp .* cosl;
ecef_y = (v + alt) .* cosp .* sinl;
ecef_z = (v.*(1.0-P.E2) + alt) .* sinp;

end