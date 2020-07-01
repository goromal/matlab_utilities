function v = Xformd_log(T)

v = zeros(6, 1);
omega = Quatd_log(T.q);
v(4:6,1) = omega;
th = norm(omega);
if th > 1e-8
    wx = skew(omega);
    A = sin(th)/th;
    B = (1.0 - cos(th))/(th*th);
    V = eye(3,3) - 0.5*wx + (1/(th*th)) * (1.0-(A/(2.0*B)))*(wx*wx);
    v(1:3,1) = V' * T.t;
else
    v(1:3,1) = T.t;
end

end