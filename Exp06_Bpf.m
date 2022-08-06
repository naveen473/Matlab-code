
clc;
clear all;
close all;
t=0:1000;
x=sin(2*pi*200*t)+sin(2*pi*300*t);
fc1=input('Enter cut-off freq 1:');
fc2=input('Enter cut-off freq 2:');
fc=[fc1 fc2];
fs=input('Enter sampling freq :');
N=fs;
t=0:1/fs:1;
k=0:N-1;
M=input('Enter Order:');
[b,a]=fir1(M-1,(2*fc/fs),'bandpass',rectwin(M));
figure
freqz(b,a);
title('FIR bandpass Filter using Rectangular Window');
y=filter(b,a,x);
X=fft(x);
Y=fft(y);
m1=abs(X);
m2=abs(Y);
figure
subplot(2,1,1);
stem(m1);
subplot(2,1,2);
stem(m2);
title('Butterworth Lowpass Filter');