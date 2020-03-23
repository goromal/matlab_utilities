function [ data ] = processAllROSBagTopics( bagfile, use_header_time )
% take a ROSbag file and return a struct of processed topics
% (modify processROSBagTopics.m to add custom message types)

assert(exist(bagfile,'file') ~= 0,'Bag file does not exist');

if nargin < 2
    use_header_time = true;
end

clear rosbag_wrapper;
clear ros.Bag;

% addpath('matlab_rosbag-0.4.1-linux64')
% addpath('navfn')

bag = ros.Bag.load(bagfile);
data = processROSBagTopics(bag.topics,bagfile,use_header_time);
end

