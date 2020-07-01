function q = Quatd_exp(v)

norm_v = norm(v);
if (norm_v > 1e-4)
    v_scale = sin(norm_v/2.0)/norm_v;
    q = Quatd([cos(norm_v/2.0) v_scale*v(1) v_scale*v(2) v_scale*v(3)]);
else
    arr = [1.0 v(1)/2.0 v(2)/2.0 v(3)/2.0];
    arr = arr / norm(arr);
    q = Quatd(arr);
end

end