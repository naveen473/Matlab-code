clc;
clear all;
close all;
f0=2000;
fc=f0;
a=input('Enter the multiplying factor:');
fs=a*f0;
Nord=input('Enter the order');
delf=f0/20;
T0=1/f0;
Ts=1/fs;
fsdas=8*fs;
Dutycycle=90/100;
T1=(1/fsdas)*Dutycycle;
N0=fsdas/fs;
N1=round(N0*Dutycycle);
t=0:1/fsdas:5000*T0;
N=length(t);
Vm=2;
x=Vm*cos(2*pi*f0*t)+2;
pulse=[ones(1,N1) zeros(1,N0-N1)];
deltrain=zeros(1,N-N0+1);
deltrain(1:N0:end)=1;
p=conv(deltrain,pulse);
v=p.*x;
[b,a]=butter(Nord,fc/(fsdas/2));
[H,w]=freqz(b,a,fsdas,fsdas);
y=filter(b,a,v);
figure;
subplot(4,1,1);
plot(t,x);
axis([min(t) max(t),min(x)-0.1 max(x)+0.1]);
xlabel('Time(s)');
ylabel('Amplitude');
title('MESSAGE SIGNAL');
subplot(4,1,2);
plot(t,p);
xlabel('Time(s)');
ylabel('Amplitude');
title('PULSE TRAIN SIGNAL');
subplot(4,1,3);
plot(t,v);
xlabel('Time(s)');
ylabel('Amplitude');
title('SAMPLED SIGNAL');
subplot(4,1,4);
plot(t,y);
xlabel('Time(s)');
ylabel('Amplitude');
title('RECONSTRUCTED SIGNAL');
[px,fx]=pspectrum(x,fsdas,'FrequencyResolution',delf);
[pv,fv]=pspectrum(v,fsdas,'FrequencyResolution',delf);
[py,fy]=pspectrum(y,fsdas,'FrequencyResolution',delf);
figure;
subplot(4,1,1);
plot(fx,10*log10(px));
axis([-1 4*fs,-50 max(10*log10(px)+1)]);
grid on;
title('SINUSOIDAL SIGNAL');
xlabel('Frequency(Hz)');
ylabel('Power(dB)');
subplot(4,1,2);
plot(w,20*log10(abs(H)));
axis([-1 4*fs,-50 max(abs(H)+1)]);
grid on;
title('BUTTERWORTH FILTER RESPONSE');
xlabel('Frequency(Hz)');
ylabel('Power(dB)');
subplot(4,1,3);
plot(fv,10*log10(pv));
axis([-1 4*fs,-50 max(10*log10(pv)+1)]);
grid on;
title('SAMPLED SIGNAL');
xlabel('Frequency(Hz)');
ylabel('Power(dB)');
subplot(4,1,4);
plot(fy,10*log10(py));
axis([-1 4*fs,-50 max(10*log10(py)+1)]);
grid on;
title('FILTERED OUTPUT');
xlabel('Frequency(Hz)');
ylabel('Power(dB)');
