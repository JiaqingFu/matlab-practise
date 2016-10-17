function out=demodulation(input,type,hors,msg)
f=200;%�ز�Ƶ��
f1=2;
t=linspace(0,2*pi*f1*length(input)/f,length(input));
mod=sin(t);
klg=30;
c=zeros(1,klg);
e=zeros(1,klg);
de=zeros(1,klg);

k=25;
tic
switch type
    case 'bpsk'
        for w=1:30     
        sigma=sqrt(5)*10^(-w/20);
        noise=randn(1,length(input));
%         noise1=zeros(1,f);
        recv=input+k*sigma*noise;
        recv=recv.*mod;
        recv1=reshape(recv,f,length(input)/f);
        recv2=sum(recv1);
        if(strcmp(hors,'hard'))
            recv2((recv2>=0))=1;
            recv2((recv2<0))=0;
           de =Hviterbi(recv2);
           ax=1;
        else
         de =Sviterbi(recv2,1);%ֱ�ӽ���ƽ����������
         ax=2;
        end
        q=HMdist(msg,de);
         e(w)=q/length(msg);
         c(w)=10*log10(q/length(msg));%����dB
        end
%             subplot(2,2,3);
              figure('NumberTitle','off','Name','������');
            plot(c,'LineWidth',1.5);
                xlabel('�����');ylabel('������');
%                figure('NumberTitle','off','Name','��˹����');
%             plot(recv,'LineWidth',1.5);
           fjq(ax,:)=c;
         grid on;
 
    case 'ook'
        for w=1:30     
        sigma=sqrt(5)*10^(-w/20);
        noise=randn(1,length(input));
        recv=input+k*sigma*noise;
        recv=recv.*mod;
        recv1=reshape(recv,f,length(input)/f);
        recv2=sum(recv1);
        if(strcmp(hors,'hard'))
             recv2((recv2<50))=0;
            recv2((recv2>=50))=1;
           
            de =Hviterbi(recv2);
            ax=3;
        else
        de =Sviterbi(recv2/100,0);%ֱ�ӽ���ƽ����������
        ax=4;
        end
         q=HMdist(msg,de);
        e(w)=q/length(msg);
          c(w)=10*log10(q/length(msg));%����dB
        end
%         subplot(2,2,4);
%             figure('NumberTitle','off','Name','��˹����');
%             plot(recv,'LineWidth',1.5);
            figure('NumberTitle','off','Name','������');
        plot(c,'LineWidth',1.5);
        xlabel('�����');ylabel('������');
       grid on;
     fjq(ax,:)=c;
end
toc
save dat fjq;
out={e,de};

 