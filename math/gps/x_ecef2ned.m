function x = x_ecef2ned(ecef_x, ecef_y, ecef_z)

[lat, lon, ~] = ecef2lla(ecef_x, ecef_y, ecef_z);
q = q_e2n(lat, lon);

x = Xformd_from_tq([ecef_x; ecef_y; ecef_z], q);

end