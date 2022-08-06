clc;
clear all;
close all;
fc=250;
fs=1000;
M=input('enter the number');
wc=2*pi*fc/fs;
alp=(M-1)/2;
hd=[];
for n=0:M-1
    if (n==2)
        x=wc/pi;
        hd=[hd x];
    else
        y=(sin((n-alp)*wc))/((n-alp)*pi);
        hd=[hd y];
    end
end
wn=[];
for n=0:M-1
    x=0.42-0.5*cos((2*pi*n)/(M-1))-0.08*cos((4*pi*n)/(M-1));
    wn=[wn x];
end
hn=hd.*wn;
freqz(hn,1);
title('FIR Lowpass Filter using Blackman Window')


        