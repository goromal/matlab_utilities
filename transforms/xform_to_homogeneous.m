function H = xform_to_homogeneous(T)
% Convert xform T to SE(3) transform matrix H

t = T(1:3,1);
q = T(4:7,1);
R = quat_to_matrix(q);
H = [R t;0 0 0 1];

end