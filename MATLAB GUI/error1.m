function f=error1(t,tr)
    ta=forward1(t);
    dx=tr(1,4)-ta(1,4);
    dy=tr(2,4)-ta(2,4);
    dz=tr(3,4)-ta(3,4);
    nd=tr(1:3,1);
    sd=tr(1:3,2);
    ad=tr(1:3,3);
    ne=ta(1:3,1);
    se=ta(1:3,2);
    ae=ta(1:3,3);
    
    e=0.5*(cross(ne,nd)+cross(se,sd)+cross(ae,ad));
    f=[dx;dy;dz;e];
end