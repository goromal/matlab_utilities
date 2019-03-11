function [ data ] = processAllTopics( bagfile )
% take a ROSbag file and return a struct of processed topics
% (modify processTopics.m to add custom message types)

assert(exist(bagfile,'file') ~= 0,'Bag file does not exist');

clear rosbag_wrapper;
clear ros.Bag;

% addpath('matlab_rosbag-0.4.1-linux64')
% addpath('navfn')

bag = ros.Bag.load(bagfile);
data = processTopics(bag.topics,bagfile);
end

