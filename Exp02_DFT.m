clc; 
close;
clearvars; 
N=input('enter the sampling rate') ;
n=0:N-1;
Xn=4+2*cos(2*pi*n/N)
subplot(3,1,1);
stem(n,Xn);
title('signal');
xlabel('n');
ylabel('Xn')
for k=0:N-1 
    for n=0:N-1
        Wn=exp(-1i*2*pi*k*n/N);
        TFM(k+1,n+1)=Wn;  
    end
end
Xk=TFM*Xn' 
k=0:N-1; 
subplot(3,1,2);
stem(k,abs(Xk));
title('Magnitude of X(k)');
xlabel('k');
ylabel('|Xk|');
subplot(3,1,3);
stem(k,angle(Xk));
title('Angle of X(k)');
xlabel('k');
ylabel('Angle(Xk)');
title('DFT')
y=fft([ 6.0000    5.8478    5.4142    4.7654    4.0000    3.2346    2.5858    2.1522    2.0000    2.1522    2.5858    3.2346 4.0000    4.7654    5.4142    5.8478])
figure
subplot(3,1,2);
stem(k,abs(y));
title('Magnitude of X(k)');
xlabel('k');
ylabel('|Xk|');
subplot(3,1,3);
stem(k,angle(y));
title('Angle of X(k)');
xlabel('k');
ylabel('Angle(Xk)');
title('DFT')


