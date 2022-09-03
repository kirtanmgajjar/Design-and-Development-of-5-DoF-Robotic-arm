function []=download2(b)
f=fopen('Joint angles.txt','w');
[a,c]=size(b);
for j=1:a
    fprintf(f,'float s%dp[%d]={',j,c);
for i=1:c
    if i==c
        fprintf(f,'%0.2f',b(j,i));
        fprintf(f,'};\n');
    else
    fprintf(f,'%0.2f,',b(j,i))
    end
end
end
fprintf(f,'int a=%d;\n',c)
fclose(f)
    