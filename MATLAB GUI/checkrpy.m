function [a]=checkrpy(r1)
p=atan2(-r1(3,1),sqrt(r1(3,2)^2+r1(3,3)^2));
r=atan2(r1(3,2)/cos(p),r1(3,3)/cos(p));
y=atan2(r1(2,1)/cos(p),r1(1,1)/cos(p));
a=[r p y]*180/pi;
end