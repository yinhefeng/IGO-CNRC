function angle = calculateangle(x,y)
%计算图像中某点处的梯度方向，[0,2*pi)
%输入
%x：G_x水平方向梯度
%y：G_y垂直方向梯度

%输出
%angle：该点处的梯度方向

if x* y > 0
    if x > 0
        angle = atan( y/x);
    else
        angle = pi + atan( y/x);
    end
elseif x* y < 0
    if x > 0
        angle = 2*pi+ atan(y/x);
    else
        angle = pi + atan( y/x);
    end
else
    if x == 0
        if y >= 0
            angle = pi/2;
        else
            angle = 3*pi/2;
        end
    else
        if x > 0
            angle = 0;
        else
            angle = pi;
        end
    end
end
end
