function [] = animate_transforms(handle, T_data, To, roboticsConvention) %#ok<*INUSL,*INUSD>
% Animate the axes describing an evolving transform and its static base 
% frame (calls visualize_transform() internally)
% Arguments:
%   handle:             handle to figure for plotting
%   T_data:             [7xn] xform data describing evolving pose of interest
%   To:                 xform describing the pose of the static base frame
%                       Default: identity xform
%   roboticsConvention: boolean stating if robotics convention is used
%                       Default: true
%                       T and To must correspond to this convention

if nargin == 3
    roboticsConvention = true; %#ok<*NASGU>
elseif nargin == 2
    To = [0; 0; 0; 1; 0; 0; 0]; % identity transform
    roboticsConvention = true;
end

n = size(T_data, 2);

for i = 1:n
    visualize_transform(handle, T_data(:,i), To, roboticsConvention);
    pause(0.025);
end

end