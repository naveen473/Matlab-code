
M=2;            %Alphabet size
N=1e7;          % number of symbols
nb=log(M)/log(2)% number of bits/symbol

%Transmitter
%bit generation 
b=randi([0 1],N*nb,1);%Random binary bits
bs=b;
bs(bs==0)=-1;%converting logical to electrical
xs=bs;
scatterplot(xs);

SNRdB=1:1:15
for ii=1:length(SNRdB)
    SNRii=SNRdB(ii)
    rn=awgn(xs,SNRii,'measured');
    figure;
    plot(real(rn),imag(rn),'b.',bs,imag(b),'ro');
    legend('received','ideal')
    title(['BPSK constellation @ SNR=' num2str(SNRii),'dB']);
    axis([-5.5 5.5 -1.5 1.5])
    
    bcat=real(rn);
    bcat(bcat>=0)=1;
    bcat(bcat<0)=0;
    
    snr=10^(SNRii./10);
    Eb_by_No=snr/2;
    Eb_by_No_dB(ii)=10*log10(Eb_by_No);
    BER_th(ii)=1/2*erfc(sqrt(Eb_by_No));
    BER(ii)=length(find(b~=bcat))/N;
    EVM=sqrt((sum((bs-real(rn)).^2))/N)/var(b)*100;
    EVMdB(ii)=20*log10(EVM);
end
%figure;
%semilogy(Eb_by_No_dB,BER,'b-',Eb_by_No_dB,BER_th,'b*');
%axis([0 12 10^-7 1]);
%grid on;
%xlabel('E_b/N_o(dB)');
%ylabel('Bit error probability (P_e)');
%title('BER performance of BPSK')

    
    