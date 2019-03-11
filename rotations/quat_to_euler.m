function [roll, pitch, yaw] = quat_to_euler(qw, qx, qy, qz)
% Element-wise conversion of quaternions to euler angles.
% Uses the flight dynamics convention: roll about x -> pitch about y -> yaw
% about z (http://graphics.wikia.com/wiki/Conversion_between_quaternions_and_Euler_angles)

yr = 2.*(qw.*qx + qy.*qz);
xr = 1 - 2.*(qx.^2 + qy.^2);
roll = atan2(yr, xr);

sp = 2.*(qw.*qy - qz.*qx);
pitch = asin(sp);

yy = 2.*(qw.*qz + qx.*qy);
xy = 1 - 2.*(qy.^2 + qz.^2);
yaw = atan2(yy, xy);

end
