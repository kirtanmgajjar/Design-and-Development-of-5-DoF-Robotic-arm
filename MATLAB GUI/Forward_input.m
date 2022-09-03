d1=99.15;    a2=123.75;   a3=-5.1;   a4=5.1;  a5=132.39;    d3=-17.05;   d4=128.1;   d5=17.05;
t1 = input ('Enter value of theta 1:');
t2 = input ('Enter value of theta 2:');
t3 = input ('Enter value of theta 3:');
t4 = input ('Enter value of theta 4:');
t5 = input ('Enter value of theta 5:');
T10 = [cosd(t1) 0 sind(t1) 0;sind(t1) 0 -cosd(t1) 0;0 1 0 d1;0 0 0 1];
T21 = [-sind(t2) -cosd(t2) 0 -a2*sind(t2);cosd(t2) -sind(t2) 0 a2*cosd(t2);0 0 1 0;0 0 0 1];
T32 = [cosd(t3) 0 sind(t3) a3*cosd(t3);sind(t3) 0 -cosd(t3) a3*sind(t3);0 1 0 d3;0 0 0 1];
T43 = [cosd(t4) 0 -sind(t4) a4*cosd(t4);sind(t4) 0 cosd(t4) a4*sind(t4);0 -1 0 d4;0 0 0 1]; 
T54 = [sind(t5) cosd(t5) 0 a5*sind(t5);-cosd(t5) sind(t5) 0 -a5*cosd(t5);0 0 1 d5;0 0 0 1];
T60 = T10*T21*T32*T43*T54;
fprintf ('\nCoordinates of end effector with respect to base at origin:')
fprintf ('\nX : %0.3f',T60(1,4))
fprintf ('\nY : %0.3f',T60(2,4))
fprintf ('\nZ : %0.3f\n',T60(3,4))
