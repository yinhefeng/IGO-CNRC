function angle = calculateangle(x,y)
%����ͼ����ĳ�㴦���ݶȷ���[0,2*pi)
%����
%x��G_xˮƽ�����ݶ�
%y��G_y��ֱ�����ݶ�

%���
%angle���õ㴦���ݶȷ���

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
