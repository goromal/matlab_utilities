function skew_mat = skew(v)

skew_mat = [  0.0  -v(3)  v(2);...
             v(3)   0.0  -v(1);...
            -v(2)  v(1)   0.0];

end