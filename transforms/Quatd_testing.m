quat1 = Quatd();
quat1.w = 1.0;
quat1.x = 0.0;
quat1.y = 0.0;
quat1.z = 1.0;
quat1.elements()

q = Quatd(quat1.elements())
q = q.normalized()
q = q.inverse()
q.R()

quat2 = Quatd_from_axis_angle([1 0 1], pi/2)
quat2.R()

qI = Quatd_Identity()
qr = Quatd_Random()
det(qr.R())

quat3 = Quatd_from_euler(pi/4, pi/2, -1)

q3mq2 = quat3 - quat2;
quat2 + q3mq2

Quatd_from_R(quat3.R())

q1 = Quatd_from_euler(0,0,pi/2);
v1 = [1;0;0];
q1.rota(v1)
q1.rotp(v1)