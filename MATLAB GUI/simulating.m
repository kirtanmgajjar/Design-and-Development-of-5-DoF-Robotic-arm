function []=simulating(p,x,y,z)
startup_rvc
disp(size(p))
l(1)=Link([0,99.15,0,pi/2,0]);
l(2)=Link([0 0,123.75,0,0]);
l(3)=Link([0,-17.05,-5.1,pi/2,0]);
l(4)=Link([0,128.1,5.1,-pi/2,0]);
l(5)=Link([0,17.05,132.39,0,0]);
a=ones(length(x),1)*90;
disp(p)
p(:,2)=p(:,2)+a;
p(:,5)=p(:,5)-a;
robot=SerialLink(l);
hold on
for i=1:10
plot3(x,y,z)
plot(robot,p*pi/180)
pause(2)
end
hold off
    
    