clc;
clear all;
close all;
fc=input('Enter cut-off freq:');
fs=input('Enter sampling freq:');
M=input('Enter Order:');
[b,a]=fir1(M-1,(2*fc/fs),'high',hanning(M));
freqz(b,a);

title('FIR highpass Filter using Hanning Window');