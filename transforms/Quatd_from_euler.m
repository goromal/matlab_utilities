function q = Quatd_from_euler(roll, pitch, yaw)

cp = cos(roll/2.0);
ct = cos(pitch/2.0);
cs = cos(yaw/2.0);
sp = sin(roll/2.0);
st = sin(pitch/2.0);
ss = sin(yaw/2.0);

q = Quatd([cp*ct*cs+sp*st*ss, sp*ct*cs-cp*st*ss, cp*st*cs+sp*ct*ss, cp*ct*ss-sp*st*cs]);

end