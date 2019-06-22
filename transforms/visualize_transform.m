function [] = visualize_transform(handle, T, To, roboticsConvention) %#ok<*INUSL,*INUSD>
% Plot the axes describing a transform and its base frame (calls
% get_transform_axes() and plot_axes() internally)
% Arguments:
%   handle:             handle to figure for plotting
%   T:                  xform describing pose of interest
%   To:                 xform describing the pose of the base frame
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

figure(handle);
cla;

[orig, trans] = get_transform_axes(T, To, roboticsConvention);

plot_axes(orig, '--')
hold on; grid on
plot_axes(trans, '-')

X = [0 orig(1,:) trans(1,:)];
Y = [0 orig(2,:) trans(2,:)];
Z = [0 orig(3,:) trans(3,:)];

xlabel('x')
ylabel('y')
zlabel('z')
xlim([min(X) max(X)])
ylim([min(Y) max(Y)])
zlim([min(Z) max(Z)])
pbaspect([range(X) range(Y) range(Z)])
hold off

end