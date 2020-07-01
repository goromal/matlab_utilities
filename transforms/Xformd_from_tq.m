function T = Xformd_from_tq(t, q)

T = Xformd([t(1); t(2); t(3); q.elements()]);

end