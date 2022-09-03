function [f]=inverse5(td)
k=0;
l=0.5;
ad=atan2d(td(1,2),td(1,1));
bd=[cosd(-td(1,4)) 0 sind(-td(1,4));0 1 0;-sind(-td(1,4)) 0 cosd(-td(1,4))];
tr=zeros(4,4);
tr(4,4)=1;
cd=[cosd(ad) -sind(ad) 0;sind(ad) cosd(ad) 0;0 0 1];
dd=[1 0 0;0 0 -1;0 1 0];
tr(1:3,1:3)=cd*bd*dd;
tr(1,4)=td(1,1);
tr(2,4)=td(1,2);
tr(3,4)=td(1,3);
t=[ad -90 90 0 0];
for i=1:10000
    a=checkerror1(t,tr);
    if a==6 break; end
    k=i;
    ta=forward1(t);
    j=jacobian1(t);
    e=error1(t,tr);
    dt=j'*inv(j*j' + l*l*eye(6,6))*e;
    t=t*pi/180;
    t=t+dt';
    for i=1:5
    if t(i)>pi
        t(i)=t(i)-(2*pi);
    elseif t(i)<-pi
        t(i)=t(i) + (2*pi);
    end
    end
    t=t*180/pi;
end
f=t;
end