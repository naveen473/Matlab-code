clear;
clc;
close all;
x=input('Sequence 1: ')
h=input('Sequence 2: ')
lx=length(x);
lh=length(h);
N=lx+lh-1;
x=[x, zeros(1,N-lx)];
h=[h, zeros(1,N-lh)];
y=zeros(1,N);
for i=1:N
    for j=1:i
        y(i)=y(i)+x(j)*h(i-j+1);
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
title('Linear Convolution y[n]');
xlabel('n');
ylabel('y[n]');
