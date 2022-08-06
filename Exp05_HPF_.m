clc;
close all;
clear all;
fp=input('enter the pass band frequency');
fs=input('enter the stop band frequency');
fsamp=input('enter the sample rate');
ap=2;
as=30;
[N,w]=buttord(fp/fsamp,fs/fsamp,ap,as);
disp('order of filter ');
disp(N);
disp('cut-off frequency of filter ');
disp(w)
[b,a]=butter(N,w,'high');
freqz(b,a);
title('Butterworth Highpass Filter');



