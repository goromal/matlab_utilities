function op = transformed_axes(H)

% basis points for axes
o = [0 1 0 0;...
     0 0 1 0;...
     0 0 0 1];

% decompose homogeneous transform
R = H(1:3,1:3);
t = H(1:3,4);

% apply rotation
op = R * o;

% apply translation
op = op + repmat(t, 1, 4);

end