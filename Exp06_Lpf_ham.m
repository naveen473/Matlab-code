clc;
clear varse;
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
for i=0:M-1
    y=0.54-0.46*cos((2*pi*i)/(M-1));
    wn=[wn y];
end
hn=hd.*wn;
freqz(hn,1);
title('FIR Lowpass Filter using Hamming Window')


        