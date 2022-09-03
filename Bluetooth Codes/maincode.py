from numpy import *
from Functions import *
import serial
import time
a=serial.Serial('com3',9600)
a.write(b'Start')
while True:
    d=a.readline().decode('ascii').split()
    print(d)
    if len(d)>3:
        print(d)
        e = [float(d[i]) for i in range(1, len(d))]
        print(e)
        if d[0]=='F':
            a1=''.join(['a',str(round(e[0],2)),'\n'])
            b1=''.join(['b',str(round(e[1],2)),'\n'])
            c1=''.join(['c',str(round(e[2],2)),'\n'])
            d1=''.join(['d',str(round(e[3],2)),'\n'])
            e1=''.join(['e',str(round(e[4],2)),'\n'])
            f1=forward(e)
            g1=''.join(['\n','I',' ',str(round(f1[0,3],2)),' ',str(round(f1[1,3],2)),' ',str(round(f1[2,3],2)),' ',str(round(e[1]+e[2]+e[4],2)),'\n'])
            a.write(a1.encode('ascii'))
            a.write(b1.encode('ascii'))
            a.write(c1.encode('ascii'))
            a.write(d1.encode('ascii'))
            a.write(e1.encode('ascii'))
            a.write(g1.encode('ascii'))

        if d[0]=='I':
            f=inverse(e)
            a1 = ''.join(['a', str(round(f[0],2)), '\n'])
            b1 = ''.join(['b', str(round(f[1],2)), '\n'])
            c1 = ''.join(['c', str(round(f[2],2)), '\n'])
            d1 = ''.join(['d', str(round(f[3],2)), '\n'])
            e1 = ''.join(['e', str(round(f[4],2)), '\n'])
            f1=''.join(['\n','F',' ',str(round(f[0],2)),' ',str(round(f[1],2)),' ',str(round(f[2],2)),' ',str(round(f[3],2)),' ',str(round(f[4],2)),'\n'])
            a.write(a1.encode('ascii'))
            a.write(b1.encode('ascii'))
            a.write(c1.encode('ascii'))
            a.write(d1.encode('ascii'))
            a.write(e1.encode('ascii'))
            a.write(f1.encode('ascii'))

