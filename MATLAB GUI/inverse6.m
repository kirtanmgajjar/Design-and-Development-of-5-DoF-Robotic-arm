function [f]=inverse6(tr)
l=0.5;
b=tr(1:3,1:3);
d4=b*[132.39;0;0];
o = tr(1:3,4)-d4;
xc=o(1,1);yc=o(2,1);zc=o(3,1);
for i=1:5
t1=atan2d(yc,xc);
t31=(xc^2 + yc^2 + (zc-99.15)^2 -113.75^2 -128.1^2)/(2*113.75*128.1);
if t31>1
    t31=1;
end
if t31<-1
    t31=-1;
end
t32=sqrt(1-t31^2);
t33=-sqrt(1-t31^2);
t3=atan2d(t33,t31);
t2=atan2d(zc-99.15,sqrt(xc^2 + yc^2)) - atan2d(128.1*sind(t3),(113.75+128.1*cosd(t3)));
t2=t2-90;
t3=t3+90;
T1=[cosd(t1), 0,  sind(t1),  0;sind(t1), 0, -cosd(t1),  0;0, 1,        0, 99.15;0, 0,        0,  1];
T2=[-sind(t2), -cosd(t2), 0, -113.75*sind(t2);cosd(t2),  -sind(t2), 0, 113.75*cos(t2);0,               0, 1,                 0;0,               0, 0,                 1];
T3=[cosd(t3), 0,  sind(t3), -5.1*cosd(t3);sind(t3), 0, -cosd(t3), -5.1*sind(t3);0, 1,        0,        -17.05;0, 0,        0,          1];
T=T1*T2*T3;
r=T(1:3,1:3);
u=inv(r)*b;
t5=atan2d(-u(3,2),u(3,1));
t4=atan2d(-u(1,3),u(2,3));
t=[t1 t2 t3 t4 t5];
for i=1:1000
    a=checkerror1(t,tr);
    if a==6 
        break 
    end
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