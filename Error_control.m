%Block codes
clc; clear all; close all;
N=1e6;
n=7;k=4;
Nb=N*k;
P=[1 1 0;0 1 1;1 1 1;1 0 1]; % parity matrix
G=[P eye(k)]; %Generator matrix
H=[eye(n-k) P']; %Parity check matrix
E=[0 0 0 0 0 0 0; %Error pattern
   1 0 0 0 0 0 0;
   0 1 0 0 0 0 0;
   0 0 1 0 0 0 0;
   0 0 0 1 0 0 0;
   0 0 0 0 1 0 0;
   0 0 0 0 0 1 0;
   0 0 0 0 0 0 1];
syn_array=E*H'; %Syndrome error pattern
ms=[0 0 0 0;0 0 0 1;0 0 1 0;0 0 1 1;0 1 0 0;0 1 0 1;0 1 1 0;0 1 1 1;
    1 0 0 0;1 0 0 1;1 0 1 0;1 0 1 1;1 1 0 0;1 1 0 1;1 1 1 0;1 1 1 1];
cs=mod(ms*G,2);

csig=cs; csig(csig==0)=-1;
syn_val=dec2bin(syn_array');syn_val=reshape(syn_val,n-k,2^(n-k));
syn_dec=bin2dec(syn_val');

b=randi([0 1],Nb,1); % bit generation
m=reshape(b,k,N)'; % message word formation
x=mod(m*G,2)'; %block code = codeword generation
s=reshape(x,N*n,1);
s(s==0)=-1; %converting to BPSK format

EbNodB=0:1:15;
for ii=1:length(EbNodB)
    EbNodB(ii);
    SNRdB=EbNodB(ii)+3.01;
    rn=awgn(s,SNRdB,'measured'); %adding white noise
    xcat=rn;
    xcat(xcat>=0)=1;xcat(xcat<0)=0; %detecion as '0'/'1'
    xcat=reshape(xcat,n,N);
    
    %BER computation without block codes-Hard decision
    BER0(ii)=sum(sum(xcat~=x))/(N*n); %BER without channel coder
    clear xcat;
    
    %BER computation with block codes-Hard decision
    SNRdB=EbNodB(ii)+3.01+10*log10(4/7);
    rn=awgn(s,SNRdB,'measured'); %adding white noise
    r=reshape(rn,n,N);
    y=r;y(y>=0)=1;y(y<0)=0;
    mH=[];mE=[];
    
    syn=mod(y'*transpose(H),2); %syndrome computation
    syn_val=dec2bin(syn');syn_val=reshape(syn_val,n-k,N);
    syn_val=bin2dec(syn_val');
    
    for jj=1:N
      e_index(jj)=find(syn_val(jj)==syn_dec); %syndrome error pattern
    end
    
    e=E(e_index,:);
    scat=mod(y+e',2);  %correction of errors in the received seq
    bcat=scat(n-k+1:end,:); %message bit collection
    bcat=reshape(bcat,Nb,1);
    BER_Synd(ii)=sum(bcat~=b)/Nb; %BER syndrome decoding
end

%theoretical BER
EbNo=10.^(EbNodB/10);
BER=1/2*erfc(sqrt(EbNo));

semilogy(EbNodB,BER,'r*'); hold on; grid on;
semilogy(EbNodB,BER0,'b-');
semilogy(EbNodB,BER_Synd,'m-');
xlabel('E_b/N_o(dB)');
ylabel('Bit error probability (P_e)');
title('BER Performance')
axis([0 15 10e-8 1])
legend('BPSK W/o Ch.Coder(Th.)','BPSK without Ch.Coder(Sim)','(7,4)Hamming Code-Syndrome decoding');