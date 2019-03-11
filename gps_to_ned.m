function [n, e, d] = gps_to_ned(lat1, lon1, h1, lat2, lon2, h2)
% Calculates the Geodesic inverse on the WGS84 Ellipsoid to get the delta
% north, east, down (meters) from gps1 -> gps2 using a python function wrapper

% Call python wrapper
ned = py.gps_to_ned.convert(lat1, lon1, h1, lat2, lon2, h2);

% Convert py.list data type to doubles
cned = cell(ned);
n = cned{1};
e = cned{2};
d = cned{3};

end


