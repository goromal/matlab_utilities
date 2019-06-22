function [orig, trans] = get_transform_axes(T, To, roboticsConvention) %#ok<*INUSL,*INUSD>
% Arguments:
%   T:                  xform describing pose of interest
%   To:                 xform describing the pose of the base frame
%                       Default: true
%   roboticsConvention: boolean stating if robotics convention is used
%                       Default: identity xform
%                       T and To must correspond to this convention
% Return values:
%   orig:               axes matrix object [o x y z] (3x4) describing the 
%                       base frame
%   trans:              axes matrix object describing the pose of interest

if nargin == 2
    roboticsConvention = true; %#ok<*NASGU>
elseif nargin == 1
    To = [0; 0; 0; 1; 0; 0; 0]; % identity transform
    roboticsConvention = true;
end

H0 = xform_to_homogeneous(To);
H1 = xform_to_homogeneous(T);
                
if ~roboticsConvention % need to invert transforms
    H0 = inv(H0);
    H1 = inv(H1);
end

H10 = H0 * H1;  % if robotics convention used, then will function like an
                % active transform, which is what we want.

% get transformed axes
orig = transformed_axes(H0);
trans = transformed_axes(H10);

end