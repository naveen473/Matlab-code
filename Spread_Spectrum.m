
Rb=1e3;
Nb=1000;
b=2*randi([0 1],Nb,1)-1;%random binary bits
PNSeq=[0 0 1 1 1 0 1];
LPN=length(PNSeq);
Rc=LPN*Rb; %chip rate
OSRc=10; 
OSRb=LPN*OSRc;

fs=OSRb*Rb;
pulsec=ones(1,OSRc);
pulseb=ones(1,OSRb);
PNSeq(PNSeq==0)=-1;
chipseq=zeros(1,(LPN-1)*OSRc+1);
chipseq(1:OSRc:end)=PNSeq; 
chipseq=conv(chipseq,pulsec);
tc=(0:LPN*OSRc-1)/(Rc*OSRc);
% plot(tc,chipseq);
% axis([0 max(tc) -1.1 1.1])

bitseq1=zeros(1,(Nb-1)*OSRb+1);
bitseq1(1:OSRb:end)=b;
bitseq_raw=conv(bitseq1,pulseb);
tb=(0:Nb*OSRb-1)/(Rb*OSRb);
% figure;
% plot(tb,bitseq_raw);
% axis([0 max(tb) -1.1 1.1])
c=[];
for ii=1:Nb
    c=[c chipseq];
end

xseq=bitseq_raw.*c;
figure;
subplot(3,1,1);
plot(tb,bitseq_raw);
axis([0 max(tb) -1.1 1.1])
xlabel('Time(s)');
ylabel('Amplitude');
title('Input bit sequence');
subplot(3,1,2);
plot(tb,c);
axis([0 max(tb) -1.1 1.1])
xlabel('Time(s)');
ylabel('Amplitude');
title('Pseudorandom Noise(PN) signal');
subplot(3,1,3);
plot(tb,xseq);
axis([0 max(tb) -1.1 1.1])
xlabel('Time(s)');
ylabel('Amplitude');
title('DSSS BPSK Signal');

[pb,~]=pwelch(bitseq_raw,[],[],[],fs);
[px,f]=pwelch(xseq,[],[],[],fs);
figure;
subplot(2,1,1);
plot(f,10*log10(pb))
xlabel('Frequency(Hz)');
ylabel('Power(dB)');
title('FREQUENCY SPECTRUM OF INPUT BIT SEQUENCE')
subplot(2,1,2);
plot(f,10*log10(px))
xlabel('Frequency(Hz)');
ylabel('Power(dB)');
title('FREQUENCY SPECTRUM OF SPREADED SIGNAL');

y=xseq.*c;
