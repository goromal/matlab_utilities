# Matlab Utilities

A collection of Matlab functions that I find useful on a semi-regular basis.

# The Functions

## Logging Functions

```python
function [] = write_log(data, logname)
# takes a matrix of doubles and strings the columns together, writing one long 
# string of doubles to a binary file
```

## ROS Matlab Functions

```python
function [ data ] = processAllTopics( bagfile )
# take a ROSbag file and return a struct of processed topics
# (modify processTopics.m to add custom message types)
```

## Rotations

```python
function rad = deg_to_rad(deg)
# Convert an angle (or vector of angles) in degrees to radians
```

```python
function deg = rad_to_deg(rad)
# Convert an angle (or vector of angles) in radians to degrees
```

```python
function [qw, qx, qy, qz] = euler_to_quat(phi, theta, psi)
# Element-wise conversion of euler angles to quaternions.
# Uses the flight dynamics convention: roll about x -> pitch about y -> yaw
# about z (http://graphics.wikia.com/wiki/Conversion_between_quaternions_and_Euler_angles)
```

```python
function [roll, pitch, yaw] = quat_to_euler(qw, qx, qy, qz)
# Element-wise conversion of quaternions to euler angles.
# Uses the flight dynamics convention: roll about x -> pitch about y -> yaw
# about z (http://graphics.wikia.com/wiki/Conversion_between_quaternions_and_Euler_angles)
```

## Miscellaneous

```python
function [n, e, d] = gps_to_ned(lat1, lon1, h1, lat2, lon2, h2)
# Calculates the Geodesic inverse on the WGS84 Ellipsoid to get the delta
# north, east, down (meters) from gps1 -> gps2 using a python function wrapper
```

```python
function flatmean = flat_average(data, epsilon)
# Take a set of "almost flat" data (with outliers) and calculate the mean,
# removing outliers by modifying the data until the standard deviation of 
# the data is < epsilon
```

