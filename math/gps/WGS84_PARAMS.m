function P = WGS84_PARAMS()

P.A = 6378137.0;      % WGS-84 Earth semimajor axis (m)
P.B = 6356752.314245; % Derived Earth semiminor axis (m)
P.F = (P.A - P.B) / P.A;    % Ellipsoid flatness
P.F_INV = 1.0 / P.F;    % Inverse flattening
P.A2 = P.A * P.A;
P.B2 = P.B * P.B;
P.E2 = P.F * (2 - P.F);   % Square of eccentricity

end