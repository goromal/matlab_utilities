function cont_yaw = continuous_yaw(yaw)

cont_yaw = zeros(size(yaw));
cont_yaw(1) = yaw(1);

for i = 2:1:length(yaw)
    if abs(yaw(i)-cont_yaw(i-1)) > pi
        cont_yaw(i) = yaw(i) + 2*pi*sign(cont_yaw(i-1)-yaw(i));
    else
        cont_yaw(i) = yaw(i);
    end
end

end

