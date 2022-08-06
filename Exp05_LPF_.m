clc;
close all;
clear all;
fp=input('enter the pass band frequency');
fs1=input('enter the stop band frequency');
fs=input('enter the sample rate');
ap=2;
as=30;
fl=input('Enter sampling freq :');
N=fs;
t=0:1/fs:1;
x=sin(fl*2*pi*t);
k=0:N-1
subplot(2,1,1);
xf=abs(fft(x,N));
stem(k,abs(xf));
stem(k,xf);

[N,w]=buttord(fp/fs,fs1/fs,ap,as);
disp('order of filter ');
disp(N);
disp('cut-off frequency of filter ');
disp(w)
[b,a]=butter(N,w,'low');
figure
freqz(b,a);
title('Butterworth Lowpass Filter');
y=filter(b,a,x);
yf=ifft(y,N);
k=0:N-1;
figure
stem(k,abs(yf));


