function [tdata, Xformdata] = poseStampedToTandXformd(poseStamped)

tdata     = poseStamped.t;
Xformdata = Xformd.empty(0, length(tdata));
for i = 1:1:length(tdata)
    x  = poseStamped.pose.position(1, i);
    y  = poseStamped.pose.position(2, i);
    z  = poseStamped.pose.position(3, i);
    qx = poseStamped.pose.orientation(1, i);
    qy = poseStamped.pose.orientation(2, i);
    qz = poseStamped.pose.orientation(3, i);
    qw = poseStamped.pose.orientation(4, i);
    Xformdata(i) = Xformd_from_tq([x y z], Quatd([qw qx qy qz]));
end

end