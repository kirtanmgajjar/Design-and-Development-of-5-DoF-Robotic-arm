function [k]=download(a,b,c,d,e,f,g,h,i)
k=zeros(9,length(a));
k(1,:)=a;
k(2,:)=b;
k(3,:)=c;
k(4,:)=d;
k(5,:)=e;
k(6,:)=f;
k(7,:)=g;
k(8,:)=h;
k(9,:)=i;
l='Report1.xls';
writecell({'Position XMat'},l,'Sheet',1,'Range','C1')
writecell({'Position yMat'},l,'Sheet',1,'Range','F1')
writecell({'Position ZMat'},l,'Sheet',1,'Range','I1')
writecell({'Velocity XMat'},l,'Sheet',1,'Range','L1')
writecell({'Velocity YMat'},l,'Sheet',1,'Range','O1')
writecell({'Velocity ZMat'},l,'Sheet',1,'Range','R1')
writecell({'Acceleration XMat'},l,'Sheet',1,'Range','U1')
writecell({'Acceleration YMat'},l,'Sheet',1,'Range','X1')
writecell({'Acceleration ZMat'},l,'Sheet',1,'Range','AA1')
writematrix(k(1,:)',l,'Sheet',1,'Range','C2')
writematrix(k(2,:)',l,'Sheet',1,'Range','F2')
writematrix(k(3,:)',l,'Sheet',1,'Range','I2')
writematrix(k(4,:)',l,'Sheet',1,'Range','L2')
writematrix(k(5,:)',l,'Sheet',1,'Range','O2')
writematrix(k(6,:)',l,'Sheet',1,'Range','R2')
writematrix(k(7,:)',l,'Sheet',1,'Range','U2')
writematrix(k(8,:)',l,'Sheet',1,'Range','X2')
writematrix(k(9,:)',l,'Sheet',1,'Range','AA2')

end