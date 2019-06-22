function [qw, qx, qy, qz] = euler_to_quat(roll, pitch, yaw)
% Element-wise conversion of euler angles to quaternions.
% Uses the flight dynamics convention: roll about x -> pitch about y -> yaw
% about z (http://graphics.wikia.com/wiki/Conversion_between_quaternions_and_Euler_angles)

c_1 = cos(roll*0.5);
s_1 = sin(roll*0.5);
c_2 = cos(pitch*0.5);
s_2 = sin(pitch*0.5);
c_3 = cos(yaw*0.5);
s_3 = sin(yaw*0.5);

qw = c_1.*c_2.*c_3 + s_1.*s_2.*s_3;
qx = s_1.*c_2.*c_3 - c_1.*s_2.*s_3;
qy = c_1.*s_2.*c_3 + s_1.*c_2.*s_3;
qz = c_1.*c_2.*s_3 - s_1.*s_2.*c_3;

end
