
M=2;
N=1e7;          % number of symbols
nb=log(M)/log(2);% number of bits/symbol

%Transmitter
%bit generation 
b=randi([0 1],N*nb,1);%Random binary bits
dpskmod=comm.DPSKModulator(2,pi/2,'BitInput',true);
dpskdemod=comm.DPSKDemodulator(2,pi/2,'BitOutput',true);

yx=dpskmod(b);
scatterplot(yx);

SNRdB=1:1:15;
for ii=1:length(SNRdB)
    SNRii=SNRdB(ii);
    rn=awgn(yx,SNRii,'measured');
%     figure;
%     plot(real(rn),imag(rn),'b.',real(yx),imag(yx),'ro');
%     legend('received','ideal')
%     title(['DPSK constellation @ SNR=' num2str(SNRii),'dB']);
%     axis([-3.5 3.5 -3.5 3.5])
    
    bcat=dpskdemod(rn);
    
    snr=10^(SNRii./10);
    Eb_by_No=snr;
    Eb_by_No_dB(ii)=10*log10(Eb_by_No);
    BER_th(ii)=1/2*exp(-Eb_by_No);
    BER(ii)=length(find(b~=bcat))/N;
end
figure;
semilogy(Eb_by_No_dB,BER,'b--',Eb_by_No_dB,BER_th,'r*');
axis([0 12 10^-7 1]);
grid on;
xlabel('E_b/N_o(dB)');
ylabel('Bit error probability (P_e)');
title('BER performance of DPSK')

[real(b(2:10)) angle(yx(1:9))/pi-angle(yx(2:10))/pi real(bcat(2:10))];
yx(2:10)
scatterplot(yx);

    