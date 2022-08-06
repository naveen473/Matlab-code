clc;
close all;
clear all;
t=0:1/80000:10;
xn=sin(2*pi*4000*t);
fp1=20;
fs1=50;
fs2=20000;
fp2=45000;
fp=[fp1 fp2];
fs=[fs1 fs2];
fsamp=80000;
ap=2;
as=30;
[N,w]=buttord(fp/fsamp,fs/fsamp,ap,as);
disp('order of filter ');
disp(N);
disp('cut-off frequency of filter ');
disp(w)
[b,a]=butter(N,w,'stop');
[b1,a1]=bilinear(b,a,80000);
figure
freqz(b,a);
title('Butterworth Bandstop Filter');
w=0:pi/100:pi;
yn=filtfilt(b1,a1,xn);
xk=fft(xn);
yk=fft(yn);
magx=abs(xk);
magy=abs(yk);
subplot(3,1,2);
wmx=[(0:length(magx)-1)/(length(magx)-1)]*fs;
subplot(3,1,3);
stem(wmx,magx);
wmy=[(0:length(magy)-1)/(length(magy)-1)]*fs;
stem(wmy,magy);