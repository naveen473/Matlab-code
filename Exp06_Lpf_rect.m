clc;
close all;
fc=250;
fs=1000;
M=input('enter the number');
wc=2*pi*(fc/fs);
alp=(M-1)/2;
hd=[];
for n=0:M-1
    if (n==alp)
        x=wc/pi;
        hd=[hd x];
    else
        y=sin((n-alp)*wc)/((n-alp)*pi);
        hd=[hd y];
    end
end
hn=hd;
freqz(hn,1);
title('FIR Lowpass Filter using Rectangular Window');