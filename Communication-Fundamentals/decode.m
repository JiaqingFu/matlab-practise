function decode
c=zeros(1,20);
for w=1:20
    q=0;
 
        msg=(randn(1,1000)>0);
        sigma=sqrt(5)*10^(-w/20);
        cod=codec(msg);
        bpsk=cod*2-1;
        noise=randn(1,length(bpsk));
        recv=bpsk+3*sigma*noise;
        de=Sviterbi(recv,3);%直接将电平送入译码器
        q=HMdist(msg,de);
        q=q+0;
c(w)=10*log10(q/1000);%换成dB
end
tic
e=zeros(1,20);
for w=1:20
    a=0;
        sigma=sqrt(5)*10^(-w/20);
        msg=(randn(1,1000)>0);
        cod=codec(msg);
        bpsk=cod*2-1;
        noise=randn(1,length(bpsk));
        recv=bpsk+3*sigma*noise;
%         for j=1:length(recv);
%             if recv(j)>0
%                 recv(j)=1;
%             else
%                 recv(j)=0;
%             end
%         end
        recv=(recv>0);
        de=Hviterbi(recv);
        a=HMdist(msg,de);
    a=a+0;
    e(w)=10*log10(a/1000);
end
plot(c,'g');
grid on;
hold on;
plot(e);
toc


    
    