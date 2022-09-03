from numpy import *
def linklength():
    return array([0,123.75,-5.1,5.1,132.39])
def linktwist():
    return array([pi/2,0,pi/2,-pi/2,0])
def jointdistance():
    return array([99.15,0,-17.05,128.1,17.05])
def jointangle():
    return array([0,90,0,0,-90])
def forward(t):
    a = linktwist()
    l = linklength()
    d = jointdistance()
    t = array(t) + jointangle()
    t=t*pi/180
    b=[[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]
    for i in range(0,len(t)):
        c=[[cos(t[i]),-sin(t[i])*cos(a[i]),sin(t[i])*sin(a[i]),l[i]*cos(t[i])],
           [sin(t[i]),cos(t[i])*cos(a[i]),-cos(t[i])*sin(a[i]),l[i]*sin(t[i])],
           [0,sin(a[i]),cos(a[i]),d[i]],
           [0,0,0,1]]
        b=matmul(b,c)
    return b
def error(t,tr):
    ta = forward(t)
    tr=array(tr)
    dx = tr[0, 3] - ta[0, 3]
    dy = tr[1, 3] - ta[1, 3]
    dz = tr[2, 3] - ta[2, 3]
    nd = array(tr[0:3, 0])
    sd = array(tr[0:3, 1])
    ad = array(tr[0:3, 2])
    ne = array(ta[0:3, 0])
    se = array(ta[0:3, 1])
    ae = array(ta[0:3, 2])
    e = (cross(ne, nd) + cross(se, sd) + cross(ae, ad))*0.5
    return array([[dx],[dy],[dz],[e[0]],[e[1]],[e[2]]])
def checkerror(t,tr):
    a = 0;
    e = error(t,tr);
    for i in range(0,len(e)):
        if abs(e[i]) < 1e-6:
            a = a + 1
    return a
def jacobian(t):
    a = linktwist()
    t = (array(t) + jointangle()) * pi / 180
    l = linklength()
    d = jointdistance()
    for i in range(0,len(t)):
        b = [[cos(t[i]),-sin(t[i])*cos(a[i]),sin(t[i])*sin(a[i]),l[i]*cos(t[i])],
           [sin(t[i]),cos(t[i])*cos(a[i]),-cos(t[i])*sin(a[i]),l[i]*sin(t[i])],
           [0,sin(a[i]),cos(a[i]),d[i]],
           [0,0,0,1]]
        if i == 0:
            m = array(b)
        elif i == 1:
            n = b
        elif i == 2:
            o = b
        elif i == 3:
            p = b
        else:
            q = b
    u = array(matmul(m,n))
    v = array(matmul(u,o))
    w = array(matmul(v,p))
    s = array(matmul(w,q))
    r0 = identity(3)
    d0 = array([[0],[0],[0]])
    r1 = array(m[0:3,0:3])
    d1 = array([[m[0,3]],[m[1,3]],[m[2,3]]])
    r2 = array(u[0:3,0:3])
    d2 = array([[u[0,3]],[u[1,3]],[u[2,3]]])
    r3 = array(v[0:3,0:3])
    d3 = array([[v[0,3]],[v[1,3]],[v[2,3]]])
    r4 = array(w[0:3,0:3])
    d4 = array([[w[0,3]],[w[1,3]],[w[2,3]]])
    d5 = array([[s[0,3]],[s[1,3]],[s[2,3]]])
    r11=transpose(cross(transpose(matmul(r0,array([[0],[0],[1]]))),transpose(d5-d0)))
    j01=matmul(r0,array([[0],[0],[1]]))
    r22 = transpose(cross(transpose(matmul(r1, array([[0], [0], [1]]))), transpose(d5 - d1)))
    j02 = matmul(r1, array([[0], [0], [1]]))
    r33 = transpose(cross(transpose(matmul(r2, array([[0], [0], [1]]))), transpose(d5 - d2)))
    j03 = matmul(r2, array([[0], [0], [1]]))
    r44 = transpose(cross(transpose(matmul(r3, array([[0], [0], [1]]))), transpose(d5 - d3)))
    j04 = matmul(r3, array([[0], [0], [1]]))
    r55 = transpose(cross(transpose(matmul(r4, array([[0], [0], [1]]))), transpose(d5 - d4)))
    j05 = matmul(r4, array([[0], [0], [1]]))
    j=[]
    for i in range(0,3):
        c=[float(r11[i]),float(r22[i]),float(r33[i]),float(r44[i]),float(r55[i])]
        j.append(c)
    for i in range(0,3):
        c=[float(j01[i]),float(j02[i]),float(j03[i]),float(j04[i]),float(j05[i])]
        j.append(c)
    return array(j)

def inverse(td):
    td=array(td)
    td[3]=td[3]*pi/180
    k = 0
    l = 0.5
    ad = arctan(td[1]/ td[0])
    bd = [[cos(-td[3]),0,sin(-td[3])],[0,1,0],[-sin(-td[3]),0,cos(-td[3])]]
    tr = zeros([4,4])
    tr[3,3] = 1
    cd = [[cos(ad),-sin(ad),0],[sin(ad),cos(ad),0],[0,0,1]]
    dd = [[1,0,0],[0,0,- 1],[0,1,0]]
    tf=matmul(matmul(cd,bd),dd)
    tr[0:3,0:3]=tf[0:3,0:3]
    tr[0,3] = td[0]
    tr[1,3] = td[1]
    tr[2,3] = td[2]
    t = array([ad*180/pi,0,0,0,0])
    for i in range(0,1500):
        a = checkerror(t,tr)
        if a == 6:
            break
        k = i;
        ta = forward(t)
        j = jacobian(t)
        e = error(t,tr)
        dt = matmul(matmul(transpose(j),linalg.inv(matmul(j,transpose(j)) + identity(6)*l*l)),e)

        t = t * pi / 180
        t = t + transpose(dt)
        t=array(t)
        for i in range(0,5):
            if t[0,i] > pi:
                t[0,i] = t[0,i] - (2 * pi)
            elif t[0,i] < -pi:
                t[0,i] = t[0,i] + (2 * pi)
        t = t * 180 / pi
        t=array([t[0,0],t[0,1],t[0,2],t[0,3],t[0,4]])
    return t
