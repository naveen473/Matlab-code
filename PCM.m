fm=1e3;
fs=1024*fm;
Am=2;
%n=1:15;
getinput=input("Enter choice 1.Sine signal 2. Random signal");
switch getinput
    case 1
        getval =input("Enter n value");
        n=getval;
        t=0:1/fs:2/fm;
        N=length(t);
        x=Am*cos(2*pi*fm*t);
        x_power=x*x'/N;

        for ii=1:length(n)
        delta=2*Am/(2^n(ii)-1);
        partition=-Am+delta/2:delta:Am-delta/2;
        codebook=-Am:delta:Am;

        [index,xq]=quantiz(x,partition,codebook);
        qe=x-xq;
        qe_avg=mean(qe);
        qe_power=qe*qe'/N;
        SQNR=x_power/qe_power;
        SQNRdB(ii)=10*log10(SQNR);
        SQNRdB_th(ii)=6*n(ii)+1.72;
        end
      case 2
          getval =input("Enter n value");
          n=getval;
          t=0:1/fs:2/fm;
          x=zeros(1,length(t));
          sigx2=4;
          LF=4;
          sigx=sqrt(sigx2);
          Am=LF*sigx;
          x=awgn(x,sigx2);
          x_power=x*x';

        for ii=1:length(n)
        delta=2*Am/(2^n(ii)-1);
        partition=-Am+delta/2:delta:Am-delta/2;
        codebook=-Am:delta:Am;

        [index,xq]=quantiz(x,partition,codebook);
        qe=x-xq;
        qe_avg=mean(qe);
        qe_power=qe*qe';
        SQNR=x_power/qe_power;
        SQNRdB(ii)=10*log10(SQNR);
        SQNRdB_th(ii)=6*n(ii)-7.2;
        end
    otherwise
        disp("wrong input");
end

plot(t,x,'b_',t,xq,'r--');
xlabel('Time');
ylabel('Amplitude');
legend('input signal x(t)','quantised signal')
title('PCM QUANTISED SIGNAL(TIME DOMAIN)');
figure;
plot(n,SQNRdB,'b-',n,SQNRdB_th,'r-*');
xlabel('Number of bits');
ylabel('SQNR(dB)');
title('Number of bits vs SQNR');