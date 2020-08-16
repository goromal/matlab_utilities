function data = processROSBagTopics(topics,bagfile,use_header_time)
%clear rosbag_wrapper;
%clear ros.Bag;

%   if nargin < 3
%     t0 = -1;
%   end

% addpath('./matlab_rosbag-0.4.1-linux64')
% addpath('./functions')

start_times = [];
topic_names = [];

bag = ros.Bag.load(bagfile);
for topic = topics
    ind = find(ismember(bag.topics,topic),1);
    if isempty(ind)
        fprintf('Could not find topic: %s\n',topic{:});
        continue;
    end
    fprintf('   Processing topic: %s\n',topic{:});
    type = bag.topicType(topic{:});    
    [msgs, meta] = bag.readAll(topic);
    
    a = [msgs{:,:}];
    c = [meta{:,:}];
    d = [c.time];
    
    % use header time if it exists
    t = [];
    if isfield(a, 'header') && use_header_time
        e = [a.header];
        f = [e.stamp];
        t = [f.time];
    else
        t = double([d.sec]) + double(1.0e-9)*double([d.nsec]);
    end
   
    
    start_times = [start_times t(1)];
    
    clear struct
    struct.t = t;
    switch type{:}
        case 'std_msgs/Float32'
            struct.a = a;
        case 'std_msgs/Float64MultiArray'
            struct.data = [a.data];
        case 'sensor_msgs/Temperature'
            struct.temp = [a.temperature];
            struct.cov = [a.variance];
        case 'sensor_msgs/MagneticField'
            struct.mag = [a.magnetic_field];
            struct.cov = [a.magnetic_field_covariance];
        case 'rosflight_msgs/OutputRaw'
            struct.values = [a.values];
        case 'rosflight_msgs/Status'
            struct.failsafe = [a.failsafe];
            struct.armed = [a.armed];
            struct.rc_override = [a.rc_override];
            struct.num_errors = [a.num_errors];
            struct.loop_time_us = [a.loop_time_us];
        case 'rosgraph_msgs/Log'
            struct.level = [a.level];
            struct.msg = {a.msg};
        case 'std_msgs/String'
            struct.msg = {a.data};
        case 'rosflight_msgs/Attitude'
            struct.q = [a.attitude];
            [r,p,y] = quat_to_euler(struct.q(4,:),struct.q(1,:),struct.q(2,:), ...
                                    struct.q(3,:));
            struct.q_euler = [r;p;y];
            struct.omega = [a.angular_velocity];
        case 'geometry_msgs/Vector3Stamped'
            struct.vec = [a.vector];
        case 'geometry_msgs/Wrench'
            struct.force = [a.force];
            struct.torque = [a.torque];
        case 'ublox_msgs/NavRELPOSNED'
            % TODO: support time later
            struct.N = double([a.relPosN])/1e2 + double([a.relPosHPN])/1e4;
            struct.E = double([a.relPosE])/1e2 + double([a.relPosHPE])/1e4;
            struct.D = double([a.relPosD])/1e2 + double([a.relPosHPD])/1e4;
%             struct.Ncov = (double([a.accN])/1e4).^2;
%             struct.Ecov = (double([a.accE])/1e4).^2;
%             struct.Dcov = (double([a.accD])/1e4).^2;
            struct.Nstdev = double([a.accN])/1e4;
            struct.Estdev = double([a.accE])/1e4;
            struct.Dstdev = double([a.accD])/1e4;
        case 'ublox_msgs/NavVELNED'
            struct.velN = double([a.velN])/1e2;
            struct.velE = double([a.velE])/1e2;
            struct.velD = double([a.velD])/1e2;
%             struct.velcov = (double([a.sAcc])/1e2).^2;
            struct.velstdev = double([a.sAcc])/1e2;
        case 'ublox_msgs/NavPVT'
            struct.lat = double([a.lat])/1e7;
            struct.lon = double([a.lon])/1e7;
            struct.alt = double([a.height])/1e3;
            struct.velN = double([a.velN])/1e3;
            struct.velE = double([a.velE])/1e3;
            struct.velD = double([a.velD])/1e3;
            struct.horstdev = double([a.hAcc])/1e3;
            struct.verstdev = double([a.vAcc])/1e3;
            struct.spdstdev = double([a.sAcc])/1e3;
        case 'rosflight_sil/ROSflightSimState'
            struct.imu.accel = [a.imu_accel];
            struct.imu.gyro  = [a.imu_gyro];
        case 'geometry_msgs/WrenchStamped'
            w = [a.wrench];
            struct.force = [w.force];
            struct.torque = [w.torque];
        case 'rosflight_msgs/Barometer'
            struct.altitude = [a.altitude];
            struct.pressure = [a.pressure];
            struct.temperature = [a.temperature];
        case 'rosflight_msgs/GPS'
            struct.fix = [a.fix];
            struct.num_sat = [a.NumSat];
            struct.latitude = [a.latitude];
            struct.longitude = [a.longitude];
            struct.altitude = [a.altitude];
            struct.speed = [a.speed];
            struct.ground_course = [a.ground_course];
            struct.covariance = [a.covariance];
        case 'rosflight_msgs/Command'
            struct.mode = [a.mode];
            struct.ignore = [a.ignore];
            struct.x = [a.x];
            struct.y = [a.y];
            struct.z = [a.z];
            struct.F = [a.F];
        case 'std_msgs/Bool'
            struct.data = a;
        case 'rosflight_msgs/RCRaw'
            struct.vals = [a.values];
        case 'relative_nav/FilterState'
            b = [a.transform];
            struct.transform.translation = [b.translation];
            struct.transform.rotation = [b.rotation];
            [r,p,y] = quat_to_euler(struct.transform.rotation(4,:),...
                                    struct.transform.rotation(1,:),...
                                    struct.transform.rotation(2,:),...
                                    struct.transform.rotation(3,:));
            struct.transform.euler = [r,p,y]*180/pi;
            struct.velocity = [a.velocity];     
            struct.node_id = [a.node_id];
         case 'sensor_msgs/NavSatFix'
            struct.latitude = [a.latitude];
            struct.longitude = [a.longitude];
            cov = [a.position_covariance];
            struct.hAcc = cov(1,:);
        case 'geometry_msgs/Transform'
            struct.transform.translation = [a.translation];
            struct.transform.rotation = [a.rotation];
            [r,p,y] = quat_to_euler(struct.transform.rotation(4,:),...
                                    struct.transform.rotation(1,:),...
                                    struct.transform.rotation(2,:),...
                                    struct.transform.rotation(3,:));
            struct.transform.euler = [r,p,y]*180/pi;
        case 'geometry_msgs/TransformStamped'
            b = [a.transform];
            struct.transform.translation = [b.translation];
            struct.transform.rotation = [b.rotation];
            [r,p,y] = quat_to_euler(struct.transform.rotation(4,:),...
                                    struct.transform.rotation(1,:),...
                                    struct.transform.rotation(2,:),...
                                    struct.transform.rotation(3,:));
            struct.transform.euler = [r,p,y]*180/pi;
        case 'relative_nav/DesiredState'
            struct.pose = [a.pose];
            struct.velocity = [a.velocity];
            struct.acceleration = [a.acceleration];
            struct.node_id = [a.node_id];
        case 'relative_nav/Snapshot'
            struct.state = [a.state];
            struct.covariance = [a.covariance_diagonal];
            struct.node_id = [a.node_id];
        case 'geometry_msgs/PoseStamped'
            b = [a.pose];
            struct.pose.position = [b.position];
            struct.pose.orientation = [b.orientation];
            [r,p,y] = quat_to_euler(struct.pose.orientation(4,:),...
                                    struct.pose.orientation(1,:),...
                                    struct.pose.orientation(2,:),...
                                    struct.pose.orientation(3,:));
            struct.pose.euler = [r;p;y];
        case 'geometry_msgs/PoseWithCovarianceStamped'
            b = [a.pose];
            c = [b.pose];
            struct.pose.position = [c.position];
            struct.pose.orientation = [c.orientation];
        case 'sensor_msgs/Range'
            struct.range = [a.range];
        case 'relative_nav/VOUpdate'
            b = [a.transform];
            struct.current_keyframe_id = [a.current_keyframe_id];
            struct.new_keyframe = [a.new_keyframe];
            struct.valid_transformation = [a.valid_transformation];
            struct.transform.translation = [b.translation];
            struct.transform.rotation = [b.rotation];
            [r,p,y] = quat_to_euler(struct.transform.rotation(4,:),...
                                    struct.transform.rotation(1,:),...
                                    struct.transform.rotation(2,:),...
                                    struct.transform.rotation(3,:));
            struct.transform.euler = [r,p,y];
        case 'relative_nav/Command'
            struct.commands = [a];
        case 'evart_bridge/transform_plus'
            disp('evart_bridge/transform_plus not supported')
%             b = [a.transform];
%             struct.transform.translation = [b.translation];
%             struct.transform.rotation = [b.rotation];
%             struct.transform.euler = rollPitchYawFromQuaternion(struct.transform.rotation.')*180/pi;
%             struct.euler = [a.euler];
%             struct.velocity = [a.velocity];
        case 'relative_nav/Edge'
            disp('relative_nav/Edge not supported')
%             b = [a.transform];
%             struct.transform.translation = [b.translation];
%             struct.transform.rotation = [b.rotation];
%             struct.transform.euler = rollPitchYawFromQuaternion(struct.transform.rotation.')*180/pi;
%             struct.from_node_id = [a.from_node_id];
%             struct.to_node_id = [a.to_node_id];
%             struct.covariance = [a.covariance];   
        case 'nav_msgs/Odometry'
            b = [a.pose];
            c = [b.pose];
            struct.pose.position = [c.position];
            struct.pose.orientation = [c.orientation];  
            [r,p,y] = quat_to_euler(struct.pose.orientation(4,:),...
                                    struct.pose.orientation(1,:),...
                                    struct.pose.orientation(2,:),...
                                    struct.pose.orientation(3,:));
            struct.pose.euler = [r;p;y];
            struct.pose.covariance = [b.covariance];
            b = [a.twist];
            c = [b.twist];
            struct.twist.linear = [c.linear];
            struct.twist.angular = [c.angular];
            struct.twist.covariance = [b.covariance];
        case 'geometry_msgs/Point'
            struct.point = a;
        case 'ublox_msgs/NavPOSLLH'
            struct.lon = double([a.lon])/1e7;
            struct.lat = double([a.lat])/1e7;
            struct.hAcc = [a.hAcc];
            [struct.x,struct.y,struct.zone] = deg2utm(struct.lat,struct.lon);
%         case 'sensor_msgs/NavSatFix'
%             struct.lon = [a.longitude];
%             struct.lat = [a.latitude];
%             cov = [a.position_covariance];
%             struct.cov = cov(1,:);
%             [struct.x,struct.y,struct.zone] = deg2utm(struct.lat,struct.lon);  
        case 'sensor_msgs/Imu'
            struct.acc = [a.linear_acceleration];
            struct.gyro = [a.angular_velocity];
        case 'rosplane_msgs/State'
            struct.position = [a.position];
            struct.Va = [a.Va];
            struct.alpha = [a.alpha];
            struct.beta = [a.beta];
            struct.phi = [a.phi];
            struct.theta = [a.theta];
            struct.psi = [a.psi];
            struct.chi = [a.chi];
            struct.p = [a.p];
            struct.q = [a.q];
            struct.r = [a.r];
            struct.Vg = [a.Vg];
            struct.wn = [a.wn];
            struct.we = [a.we];
        case 'rosplane_msgs/Controller_Internals'
            struct.theta_c = [a.theta_c];
            struct.phi_c = [a.phi_c];
            struct.alt_zone = [a.alt_zone];
            struct.aux = [a.aux];
            struct.aux_valid = [a.aux_valid];
        case 'rosplane_msgs/Controller_Commands'
            struct.Va_c = [a.Va_c];
            struct.h_c = [a.h_c];
            struct.chi_c = [a.chi_c];
            struct.phi_ff = [a.phi_ff];
            struct.aux = [a.aux];
            struct.aux_valid = [a.aux_valid];
            struct.landing = [a.landing];
        case 'sensor_msgs/LaserScan'
            struct.angle_min = [a.angle_min];
            struct.angle_max = [a.angle_max];
            struct.angle_increment = [a.angle_increment];
            struct.time_increment = [a.time_increment];
            struct.range_min = [a.range_min];
            struct.range_max = [a.range_max];
            struct.ranges = [a.ranges];
            struct.intensities = [a.intensities];
        case 'rosflight_msgs/Airspeed'
            struct.velocity = [a.velocity];
            struct.diff_press = [a.differential_pressure];
            struct.temperature = [a.temperature];
        case 'inertial_sense/GPS'
            struct.lat = [a.latitude];
            struct.lon = [a.longitude];
            struct.alt = [a.altitude];
        case 'geometry_msgs/PointStamped'
            struct.point = [a.point];
        case 'geometry_msgs/Twist'
            struct.linear = [a.linear];
            struct.angular = [a.angular];
        case 'data_processor/MarkerBearingArray'
            struct.bearings = [a.bearings];
        case 'calibration_sim/InertialPoints'
            struct.points = [a.points];
            struct.pose = [a.pose];
        case 'feature_recognition_msgs/Points'
            struct.points = [a.points];
        case 'aerowake_vision/VisionPose'
            struct.sol_status = [a.sol_status];
            struct.contour_count = [a.contour_count];
            struct.centroid_count = [a.centroid_count];
            struct.outlier = [a.outlier];
            struct.dynamically_valid = [a.dynamically_valid];
            b = [a.transform];
            struct.transform.translation = [b.translation];
            struct.transform.rotation = [b.rotation];
            [r,p,y] = quat_to_euler(struct.transform.rotation(4,:),...
                                    struct.transform.rotation(1,:),...
                                    struct.transform.rotation(2,:),...
                                    struct.transform.rotation(3,:));
            struct.transform.euler = [r;p;y];
            % for the older way of representing solution error
            defunct_indices = struct.transform.translation(1,:) < -900.0;
            struct.transform.translation(:,defunct_indices) = struct.transform.translation(:,defunct_indices) + [999.0;999.0;999.0];
        case 'geometry_msgs/QuaternionStamped'
            struct.quaternion = [a.quaternion];
            [r,p,y] = quat_to_euler(struct.quaternion(4,:),...
                                    struct.quaternion(1,:),...
                                    struct.quaternion(2,:),...
                                    struct.quaternion(3,:));
            struct.euler = [r;p;y];
        case 'visualization_msgs/Marker'
            number = 1;
            for i = a(end:-1:1)
               if(size(i.points,2) > 2)
                   if(number == 1)
                       struct.opt.points = i.points;
                       number = 2;
                   elseif(number == 2)
                       struct.unopt.points = i.points;
                       break
                   else
                    break
                   end
               end
            end            
        otherwise
            fprintf('     Type: %s not yet supported!\n',type{:});
            continue
    end
    
    % Split topic name into sections
    topic_names = [topic_names '+' topic{1}];
    topic_parts = strsplit(topic{1},'/');
    topic_parts(cellfun('isempty', topic_parts)) = [];
    switch size(topic_parts,2)
        case 1
            data.(topic_parts{1}) = struct;
        case 2
            data.(topic_parts{1}).(topic_parts{2}) = struct;
        case 3
            data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}) = struct;
        case 4
            data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}).(topic_parts{4}) = struct;
        case 5
            data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}).(topic_parts{4}).(topic_parts{5}) = struct;
        otherwise
            fprintf('Too long');
    end     
end

t0 = min(start_times);
each_topic_name = strsplit(topic_names,'+');
each_topic_name(cellfun('isempty', each_topic_name)) = [];

for i = 1:1:size(each_topic_name,2)
    topic_parts = strsplit(each_topic_name{i},'/');
    topic_parts(cellfun('isempty', topic_parts)) = [];
    switch size(topic_parts,2)
        case 1
            data.(topic_parts{1}).t = data.(topic_parts{1}).t - t0;
        case 2
            data.(topic_parts{1}).(topic_parts{2}).t = data.(topic_parts{1}).(topic_parts{2}).t - t0;
        case 3
            data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}).t = data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}).t - t0;
        case 4
            data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}).(topic_parts{4}).t = data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}).(topic_parts{4}).t - t0;
        case 5
            data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}).(topic_parts{4}).(topic_parts{5}).t = data.(topic_parts{1}).(topic_parts{2}).(topic_parts{3}).(topic_parts{4}).(topic_parts{5}).t - t0;
        otherwise
            fprintf('Too long for time regularization');
    end    
end

end
