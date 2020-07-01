function T = Xformd_exp(v)

u = [v(1); v(2); v(3)];
omega = [v(4); v(5); v(6)];
th = norm(omega);
q_exp = Quatd_exp(omega);
if th > 1e-4
    wx = skew(omega);
    B = (1.0 - cos(th))/(th * th);
    C = (th - sin(th)) / (th * th * th);
    T = Xformd_from_tq((eye(3,3)+B*wx+C*wx*wx)'*u, q_exp);
else
    T = Xformd_from_tq(u, q_exp);
end

end