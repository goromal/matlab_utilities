function [lat, lon, alt] = ned2lla(lat0, lon0, alt0, N, E, D)

[ecef_x0, ecef_y0, ecef_z0] = lla2ecef(lat0, lon0, alt0);
x_e2n = Xformd_from_tq([ecef_x0; ecef_y0; ecef_z0], q_e2n(lat0, lon0));
[ecef_x, ecef_y, ecef_z] = ned2ecef(x_e2n, N, E, D);
[lat, lon, alt] = ecef2lla(ecef_x, ecef_y, ecef_z);

end