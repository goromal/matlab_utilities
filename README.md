# Matlab Utilities

A collection of Matlab functions that I find useful on a semi-regular basis.

Clone this repository and use with

```matlab
addpath(genpath('matlab_utilities/'));
```

Provide the full relative path to matlab\_utilities if your script resides somewhere else.

# The Functions

## Logging Functions

```matlab
function [] = write_log(data, logname)
% takes a matrix of doubles and strings the columns together, writing one long 
% string of doubles to a binary file
```

```matlab
function data = read_log(logname, rowSize)
% takes a binary log of doubles and fits it to a matrix of size [rowSize x ...]
```

## Angles and SO(3) Rotation Conversions

```matlab
function rad = deg_to_rad(deg)
% Convert an angle (or vector of angles) in degrees to radians
```

```matlab
function deg = rad_to_deg(rad)
% Convert an angle (or vector of angles) in radians to degrees
```

```matlab
function [qw, qx, qy, qz] = euler_to_quat(phi, theta, psi)
% Element-wise conversion of euler angles to quaternions.
% Uses the flight dynamics convention: roll about x -> pitch about y -> yaw
% about z (http://graphics.wikia.com/wiki/Conversion_between_quaternions_and_Euler_angles)
```

```matlab
function [roll, pitch, yaw] = quat_to_euler(qw, qx, qy, qz)
% Element-wise conversion of quaternions to euler angles.
% Uses the flight dynamics convention: roll about x -> pitch about y -> yaw
% about z (http://graphics.wikia.com/wiki/Conversion_between_quaternions_and_Euler_angles)
```

```matlab
function R = quat_to_matrix(q)
% Convert quaternion q = [qw qx qy qz] to SO(3) rotation matrix R
```

```matlab
function q = matrix_to_quat(R)
% Convert SO(3) rotation matrix R to quaternion q = [qw qx qy qz]
```

## SE(3) Transform Conversions

```matlab
function H = xform_to_homogeneous(T)
% Convert xform T to SE(3) transform matrix H
```

```matlab
function T = homogeneous_to_xform(H)
% Convert SE(3) transform matrix H to xform T
```

## SE(3) Transform Visualization

```matlab
function [orig, trans] = get_transform_axes(T, To, roboticsConvention)
% Arguments:
%   T:                  xform describing pose of interest
%   To:                 xform describing the pose of the base frame
%                       Default: identity xform
%   roboticsConvention: boolean stating if robotics convention is used
%                       Default: true
%                       T and To must correspond to this convention
% Return values:
%   orig:               axes matrix object [o x y z] (3x4) describing the 
%                       base frame
%   trans:              axes matrix object describing the pose of interest
```

```matlab
function [] = plot_axes(axesdef, linetype)
% Takes axes matrix object [o x y z] (3x4) axesdef and plots an rgb set
% of axes with line style linetype (default: '-')
```

```matlab
function [] = visualize_transform(handle, T, To, roboticsConvention)
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
```

```matlab
function [] = animate_transforms(handle, T_data, To, roboticsConvention)
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
```

## General Plotting Utilities

```matlab
function [] = formatted_plot(x_data, y_data, style, x_label, y_label, plot_title)
% Create a tightly-formatted plot with the correct aspect ratio
```

## ROS

```matlab
function [ data ] = processAllROSBagTopics( bagfile )
% take a ROSbag file and return a struct of processed topics
% (modify processROSBagTopics.m to add custom message types)
```

## Miscellaneous

```matlab
function [n, e, d] = gps_to_ned(lat1, lon1, h1, lat2, lon2, h2)
% Calculates the Geodesic inverse on the WGS84 Ellipsoid to get the delta
% north, east, down (meters) from gps1 -> gps2 using a python function wrapper
```

```matlab
function flatmean = flat_average(data, epsilon)
% Take a set of "almost flat" data (with outliers) and calculate the mean,
% removing outliers by modifying the data until the standard deviation of 
% the data is < epsilon
```

## (PENDING)

```matlab
function [] = quad_plot(handle, time, xform, xlimits, ylimits, zlimits)
% Create a plot depicting a quadrotor whose pose is described by the transform
% xform (robotics convention)
```

```matlab
function [] = cam_plot(handle, x_pixels, y_pixels, img_w, img_h)
% Creates a plot of dimenstions [img_w x img_h] and plots the provided pixel
% locations, styling each [x_pixels(i), y_pixels(i)] pair with styles{i}
```

