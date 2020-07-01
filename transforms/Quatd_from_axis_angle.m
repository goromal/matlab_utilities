function q = Quatd_from_axis_angle(axis, angle)

alpha_2 = angle/2.0;
sin_a2 = sin(alpha_2);
arr = [cos(alpha_2), axis(1)*sin_a2, axis(2)*sin_a2, axis(3)*sin_a2];
arr = arr / norm(arr);
q = Quatd(arr);

end