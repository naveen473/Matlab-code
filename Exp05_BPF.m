clc;
close all;
clear all;
fs1=50;
fp1=100;
fp2=200;
fs2=250;
fp=[fp1 fp2];
fs=[fs1 fs2];
fsamp=500;
ap=3;
as=40;
[N,w]=buttord(fp/fsamp,fs/fsamp,ap,as);
disp('order of filter ');
disp(N);
disp('cut-off frequency of filter ');
disp(w)
[b,a]=butter(N,w,'bandpass');
subplot(2,1,1);
freqz(b,a);
title('Butterworth Bandpass Filter');


