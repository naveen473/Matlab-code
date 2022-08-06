Rb=1e3;
Nb=100;
Tb=1/Rb;
Bo=Rb/2;
Ntow=3;
Ts=Tb/100;
fs=1/Ts;
figure(1);

n=0:Nb-1;
b=randi([0 1],1,Nb);
getval=input("Enter a number 1. unipolar NRZ, 2. Polar NRZ, 3.Manchester NRZ,4.Nyquist pulse 5.Raised cosine pulse");
switch getval
    case 1  
        [v,a] = nrz(Nb,Ts,b,Tb);
    case 2
        [v, a] = pnrz(Nb,Ts,b,Tb);
    case 3
        [v, a]=manchester(Nb,Ts,b,Tb);
    case 4
        [v, a]=nyquist(Ntow,Ts,b,Tb,Bo);
    case 5
        alp=input("Enter alpha value");
        [v, a]=rai_cos_pil(alp,Ntow,Ts,b,Tb,Bo);
    otherwise
        disp("other value");
end 

subplot(3,1,2);
stem(n*Tb,b);
axis([-Tb,(Nb+1)*Tb,-1.3,1.3])
imp_train=zeros(1,(Nb-1)*Nb+1);
imp_train((1:Nb:end))=a;
xlabel('time(s)');
ylabel('del_T(t)');

x=conv(imp_train,v);
t=0:Ts:(length(x)-1)*Ts;
subplot(3,1,3);
plot(t,x);
axis([min(t)-Tb,max(t)+Tb,min(x)-0.3,max(x)+0.3]);
xlabel('time(s)');
ylabel('x(t)');

[ps,f]=pspectrum(x,fs,'FrequencyResolution',100);
figure;
plot(f,10*log10(ps))
xlabel('Frequency(Hz)');
axis([0 10*Rb -70 10])

% Unipolar NRZ
function [v,a] = nrz(Nb,Ts,b,Tb)
A=2;
t=(0:Nb-1)*Ts;
v=ones(1,Nb);
a=A*b;
subplot(3,1,1);
plot(t,v);
axis([-Tb,(Nb+1)*Tb,-0.3,1.3])
ylabel('p(t)');
xlabel('time(s)');
end

%Polar NRZ
function [v, a] = pnrz(Nb,Ts,b,Tb)
A=2;
t=(0:Nb-1)*Ts;
v=ones(1,Nb);
a=A*b;
a(b==0)=-A;
subplot(3,1,1);
plot(t,v);
axis([-Tb,(Nb+1)*Tb,-0.3,1.3])
ylabel('p(t)');
xlabel('time(s)');
end

% Manchester NRZ
 function [v, a]=manchester(Nb,Ts,b,Tb)
t=(0:Nb-1)*Ts;
v=[ones(1,Nb/2) -ones(1,Nb/2)];
a=b;
a(b==0)=-1;
subplot(3,1,1);
plot(t,v);
axis([min(t)-Tb,max(t)+Tb,min(v)-0.3,max(v)+0.3])
ylabel('p(t)');
xlabel('time(s)');
 end
 
 %Nyquist Pulse
function [v, a]=nyquist(Ntow,Ts,b,Tb,Bo)
a=b;
a(a==0)=-1;
t=-Ntow*Tb:Ts:Ntow*Tb;
v=sinc(2*Bo*t);
subplot(3,1,1);
plot(t,v);
ylabel('p(t)');
xlabel('time(s)');
end

%Raised Cosine Pulse
function [v, a]=rai_cos_pil(alp,Ntow,Ts,b,Tb,Bo)
a=b;
a(a==0)=-1;
k=16*Bo^2*alp^2;
delta=Tb*1e-10;
t=-Ntow*Tb+delta:Ts:Ntow*Tb;
v=sinc(2*Bo*t).*cos(2*pi*alp*Bo*t)./(1-16*Bo^2*alp^2*t.^2);
subplot(3,1,1);
plot(t,v);
axis([min(t)-Tb,max(t)+Tb,min(v)-0.3,max(v)+0.3]);
xlabel('time(s)');
ylabel('p(t)');
end
