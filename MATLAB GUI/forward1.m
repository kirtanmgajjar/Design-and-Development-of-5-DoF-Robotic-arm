function [f]=forward1(t)
    a=linktwist();
l=linklength();
d=jointdistance();
t=(t+jointangle())*pi/180;
b=eye(4,4);
for i=1:5

c=[cos(t(i)), -sin(t(i))*cosd(a(i)),  sin(t(i))*sind(a(i)), l(i)*cos(t(i));
       sin(t(i)), cos(t(i))*cosd(a(i)),   -cos(t(i))*sind(a(i)), l(i)*sin(t(i));
       0, sind(a(i)), cosd(a(i)), d(i);
       0, 0, 0, 1];
   b=b*c;
end

f=b;
end