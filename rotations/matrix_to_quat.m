function q = matrix_to_quat(R)
% Convert SO(3) rotation matrix R to quaternion q = [qw qx qy qz]

R11 = R(1,1); R12 = R(1,2); R13 = R(1,3);
R21 = R(2,1); R22 = R(2,2); R23 = R(2,3);
R31 = R(3,1); R32 = R(3,2); R33 = R(3,3);

tr = R11 + R22 + R33;

if tr > 0
    S = sqrt(tr + 1.0) * 2;
    qw = 0.25 * S; %#ok<*NASGU>
    qx = (R32 - R23) / S;
    qy = (R13 - R31) / S;
    qz = (R21 - R12) / S;
    
elseif (R11 > R22) && (R11 > R33)
    S = sqrt(1.0 + R11 - R22 - R33) * 2;
    qw = (R32 - R23) / S;
    qx = 0.25 * S;
    qy = (R12 + R21) / S;
    qz = (R13 + R31) / S;
    
elseif R22 > R33
    S = sqrt(1.0 + R22 - R11 - R33) * 2;
    qw = (R13 - R31) / S;
    qx = (R12 + R21) / S;
    qy = 0.25 * S;
    qz = (R23 + R32) / S;
    
else
    S = sqrt(1.0 + R33 - R11 - R22) * 2;
    qw = (R21 - R12) / S;
    qx = (R13 + R31) / S;
    qy = (R23 + R32) / S;
    qz = 0.25 * S;
    
end

q = [qw qx qy qz]';

end