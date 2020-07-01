T1 = Xformd()
T1.t(2) = 1.5;
T1.q.z = 0.5;
T1.q = T1.q.normalized();
T1.elements()

T2 = Xformd(T1.elements())
T2.H()
T2 = T2.inverse();
T2.H()

TI = Xformd_Identity()
TI.elements()

T3 = Xformd_from_tq([1.0 0.0 -0.5], Quatd_from_euler(1.0, 1.0, 0.0));
T4 = Xformd_from_tq([-2.0 1.0 0.0], Quatd_from_axis_angle([1 1 1], pi/4));

T4m3 = T4 - T3 
Xformd_log(T4) % works
T4.inverse().elements() % works
T3tT4 = T3 * T4; 
T3tT4.elements()
T4cand = T3 + T4m3;
T4.elements()
T4cand.elements()