function [a]=checkerror1(t,tr)
    a=0;
    e=error1(t,tr);
    for i=1:length(e)
        if abs(e(i))<1e-7
            a=a+1;
        end
    end
end