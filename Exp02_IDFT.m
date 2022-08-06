clc; 
close; 
clearvars; 
xk=input('enter the sequence');
N=input('enter the sample rate');
L=length(xk);
l=0:L-1;
Xk=exp(i*l*pi).*xk;
subplot(3,1,1);
stem(l,Xk);
title('signal');
xlabel('n');
ylabel('Xk')
if N>L
    Xk=[Xk zeros(1,N-L)];
end
for n=0:N-1 
    for k=0:N-1
        Wk=exp(i*2*pi*n*(k/N));
        TFM(n+1,k+1)=Wk;
    end
end
Xn=1/N*(Xk*TFM);
n=0:N-1;
subplot(3,1,2);
stem(n,abs(Xn)) ;
title('Magnitude of X(n)');
xlabel('n');
ylabel('|Xn|');
subplot(3,1,3)  ;
stem(n,angle(Xn));
title('Angle of X(n)'); 
xlabel('n'); 
ylabel('Angle(Xn)');
title('IDFT')
