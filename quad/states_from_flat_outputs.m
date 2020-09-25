function [x, y, z, u, v, w, qw, qx, qy, qz, p, q, r] ...
  = states_from_flat_outputs(s1, s1d, s1dd, s1ddd, s2, s2d, s2dd, s2ddd, ...
                             s3, s3d, s3dd, s3ddd, s4, s4d, conv, g)

if nargin == 14
    conv = 'NWU';
    g = 9.81;
elseif nargin == 15
    g = 9.81;
end

N = length(s1);
x = zeros(size(s1));
y = zeros(size(s1));
z = zeros(size(s1));
u = zeros(size(s1));
v = zeros(size(s1));
w = zeros(size(s1));
qx = zeros(size(s1));
qy = zeros(size(s1));
qz = zeros(size(s1));
qw = zeros(size(s1));
p = zeros(size(s1));
q = zeros(size(s1));
r = zeros(size(s1));

if strcmp(conv, 'NWU')
    for i = 1:1:N
        % Position
        x(i) = s1(i);
        y(i) = s2(i);
        z(i) = s3(i);
        
        % Attitude (Rotation Matrix)
        va_ = [s1dd(i); s2dd(i); s3dd(i) + g];
        z_B_W_ = va_ / norm(va_);
        x_c_W_ = [cos(s4(i)); sin(s4(i)); 0];
        y_B_W_ = cross(z_B_W_, x_c_W_) / norm(cross(z_B_W_, x_c_W_));
        x_B_W_ = cross(y_B_W_, z_B_W_);
        R_B_W_ = [x_B_W_ y_B_W_ z_B_W_];
        
        % Body-Frame Velocity
        uvw_ = R_B_W_' * [s1d(i); s2d(i); s3d(i)];
        u(i) = uvw_(1);
        v(i) = uvw_(2);
        w(i) = uvw_(3);
        
        % Attitude (Quaternion)
        quat_ = Quatd_from_R(R_B_W_');
        qw(i) = quat_.w;
        qx(i) = quat_.x;
        qy(i) = quat_.y;
        qz(i) = quat_.z;
        
        % Body-Frame Angular Velocities
        % ASSUMES HOVER THROTTLE <<<<
        adot_ = [s1ddd(i); s2ddd(i); s3ddd(i)];
        hw_ = (adot_ - (z_B_W_' * adot_) * z_B_W_) / g;
        p(i) = -hw_' * y_B_W_;
        q(i) = hw_' * x_B_W_;
        r(i) = [0; 0; s4d(i)]' * z_B_W_;
    end
elseif strcmp(conv, 'NED')
    % TODO    
end

end

