function q = q_e2n(lat, lon)
% ASSUMES LAT AND LON ARE IN RADIANS!

q1 = Quatd_from_axis_angle([0,0,1], lon);
q2 = Quatd_from_axis_angle([0,1,0], -pi/2 - lat);

q = q1 * q2;

end