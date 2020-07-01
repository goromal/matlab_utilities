function q = Quatd_from_two_unit_vectors(u, v)

d = dot(u, v);
if (d < 0.99999999 && d > -0.99999999)
    invs = 1.0/sqrt((2.0*(1.0+d)));
    xyz = cross(u, v*invs);
    arr = [0.5/invs, xyz(1), xyz(2), xyz(3)];
    arr = arr / norm(arr);
    q = Quatd(arr);
elseif d < -0.99999999
    q = Quatd([0 1 0 0]);
else
    q = Quatd([1 0 0 0]);
end

end