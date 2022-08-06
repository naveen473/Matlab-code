
M=4;
N=1e7;          % number of symbols
nb=log(M)/log(2)% number of bits/symbol

%Transmitter
%bit generation 
b=randi([0 1],N*nb,1);%Random binary bits
bs=b;
bs(bs==0)=-1;%converting logical to electrical
bo=bs(1:2:end);
be=bs(2:2:end);
xs=bo+1j*be;
scatterplot(xs);

SNRdB=1:1:15
for ii=1:length(SNRdB)
    SNRii=SNRdB(ii)
    rn=awgn(xs,SNRii,'measured');
%     figure;
%     plot(real(rn),imag(rn),'b.',bs,imag(b),'ro');
%     legend('received','ideal')
%     title(['QPSK constellation @ SNR=' num2str(SNRii),'dB']);
%     axis([-2 2 -2 2])
%     
    bcato=real(rn);
    bcato(bcato>=0)=1;
    bcato(bcato<0)=0;
    
    bcate=imag(rn);
    bcate(bcate>=0)=1;
    bcate(bcate<0)= 0;
    bcat=zeros(size(b));
    bcat(1:2:end)=bcato;
    bcat(2:2:end)=bcate;
    
    snr=10^(SNRii./10);
    Eb_by_No=snr/2;
    Eb_by_No_dB(ii)=10*log10(Eb_by_No);
%     SER_th(ii)=erfc(sqrt(Eb_by_No));
%     SER(ii)=length(find(b~=bcat))/N;
    BER_th(ii)=erfc(sqrt(Eb_by_No));
    BER(ii)=length(find(b~=bcat))/N;
    EVM=sqrt((sum((bo-real(rn)).^2+(be-imag(rn)).^2)/N)/var(bo+1j*be))*100;
    EVMdB(ii)=20*log10(EVM);
end
figure;
semilogy(Eb_by_No_dB,BER,'b--',Eb_by_No_dB,BER_th,'r*');
axis([0 12 10^-7 1]);
grid on;
xlabel('E_b/N_o(dB)');
ylabel('Bit error probability (P_e)');
title('BER performance of QPSK')

    