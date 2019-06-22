function T = homogeneous_to_xform(H)
% Convert SE(3) transform matrix H to xform T

R = H(1:3,1:3);
t = H(1:3,4);

T = [t; matrix_to_quat(R)];

end