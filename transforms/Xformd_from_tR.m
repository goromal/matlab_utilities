function T = Xformd_from_tR(t, R)

q = Quatd_from_R(R);
T = Xformd_from_tq(t, q);

end