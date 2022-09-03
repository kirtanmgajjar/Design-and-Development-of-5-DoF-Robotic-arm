function [f]=jacobian3(t)
    a=linktwist();
t=(t+jointangle())*pi/180;
l=linklength();
d=jointdistance();
for i=1:3
b=[cos(t(i)), -sin(t(i))*cosd(a(i)),  sin(t(i))*sind(a(i)), l(i)*cos(t(i));
       sin(t(i)), cos(t(i))*cosd(a(i)),   -cos(t(i))*sind(a(i)), l(i)*sin(t(i));
       0, sind(a(i)), cosd(a(i)), d(i);
       0, 0, 0, 1];   
       if i==1
           m=b;
       elseif i==2
           n=b;
       elseif i==3
           o=b;
       elseif i==4
           p=b;
       else
           q=b;
       end
end
u=m*n;
v=m*n*o;
r0=eye(3,3);
d0=[0;0;0];
r1=m(1:3,1:3);
d1=[m(1,4);m(2,4);m(3,4)];
r2=u(1:3,1:3);
d2=[u(1,4);u(2,4);u(3,4)];
r3=v(1:3,1:3);
d3=[v(1,4);v(2,4);v(3,4)];

j1=[cross(r0*[0;0;1],d3-d0);r0*[0;0;1]];
j2=[cross(r1*[0;0;1],d3-d1);r1*[0;0;1]];
j3=[cross(r2*[0;0;1],d3-d2);r2*[0;0;1]];

f=[j1 j2 j3];
end