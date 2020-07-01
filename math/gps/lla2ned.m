function [N, E, D] = lla2ned(lat0, lon0, alt0, lat, lon, alt)

[ecef_x0, ecef_y0, ecef_z0] = lla2ecef(lat0, lon0, alt0);
x_e2n = Xformd_from_tq([ecef_x0; ecef_y0; ecef_z0], q_e2n(lat0, lon0));

[ecef_x, ecef_y, ecef_z] = lla2ecef(lat, lon, alt);
[N, E, D] = ecef2ned(x_e2n, ecef_x, ecef_y, ecef_z);

end