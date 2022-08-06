clear;
clc;
close all;
x=input('Sequence 1: ');
h=input('Sequence 2: ');


lx=length(x);
lh=length(h);
N=max(lx,lh);
if (lx>lh)
    h=[h zeros(1,lx-lh)];
else
    x=[x zeros(1,lh-lx)];
end
y=zeros(1,N);
for i=1:N
    for j=1:N
        m=mod(i-j,N);
        m=m+1;
        y(i)=y(i)+x(j)*h(m);
    end
end
n=0:N-1;
subplot(3,1,1);
stem(n,x);
xlabel('n');
ylabel('x[n]');

subplot(3,1,2);
stem(n,h);
xlabel('n');
ylabel('h[n]');
subplot(3,1,3);
stem(n,y);
title('Circular Convolution y[n]');
xlabel('n');
ylabel('y[n]');
