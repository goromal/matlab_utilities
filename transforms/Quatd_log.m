function v = Quatd_log(q)

arr = q.elements();
vec = arr(2:4,1);
w = q.w();
norm_v = norm(vec);
if norm_v < 1e-8
    v = zeros(3, 1);
else
    v = 2.0 * atan2(norm_v, w) * vec / norm_v;
end

end