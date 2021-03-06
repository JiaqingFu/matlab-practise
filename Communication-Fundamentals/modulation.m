function modulation_output=modulation(modulation_input,type);
tic
f=200;%载波频率
f1=2;

switch type
case 'bpsk'
g=modulation_input;
 
% t=0:2*pi*f1/(f-1):2*pi*f1*(f*length(g)-1)/(f-1);
t=linspace(0,2*pi*f1*length(g),f*length(g));
cp=[];%[]代表赋零
bit=[];
mod=[];
c=[];
die=[];

die=ones(1,f);
[die,g1]=ndgrid(die,g);
die1=ones(1,f);
[die1,gx]=ndgrid(die1,modulation_input);
die1(find(gx==0))=0;
cp1=reshape(die1,1,f*length(g));
die((g1==0))=-1;
cp=reshape(die,1,f*length(g));
mod=sin(t);
% for n=1:length(g);
%     if (g(n)==0)
%         die=-ones(1,f);
%     else    die=ones(1,f);
%     end
%     c=sin(f*t);
%     cp=[cp die];
%     mod=[mod c];
%     bit=[bit die];
% end
bpsk=cp.*mod;
% subplot(2,2,1);
 figure('NumberTitle','off','Name','卷积码');
plot(cp1,'LineWidth',1.5);
grid on;
title('convolution code');
axis([0 f*length(g) -2.5 2.5]);
    
% subplot(2,2,2);
figure('NumberTitle','off','Name','数字调制');
plot(bpsk,'LineWidth',1.5);
grid on;%'LineWidth',1.5线的粗细参数
title('BPSK modulation');
axis([0 f*length(g) -2.5 2.5]);

case 'ook'
g=modulation_input;
t=linspace(0,2*pi*f1*length(g),f*length(g));
cp=[];%[]代表赋零
bit=[];
mod=[];
c=[];
die=[];

die=ones(1,f);
[die,g1]=ndgrid(die,g);
die(find(g1==0))=0;
cp=reshape(die,1,f*length(g));
mod=sin(t);
% for n=1:length(g);
%     if (g(n)==0)
%         die=zeros(1,f);
%     else    die=ones(1,f);
%     end
%     c=sin(f*t);
%     cp=[cp die];
%     mod=[mod c];
%     bit=[bit die];
% end
bpsk=cp.*mod;
% subplot(2,2,1);
figure('NumberTitle','off','Name','卷积码');
plot(cp,'LineWidth',1.5);
grid on;
title('convolution code');
axis([0 f*length(g) -2.5 2.5]);
    
% subplot(2,2,2);
figure('NumberTitle','off','Name','数字调制');
plot(bpsk,'LineWidth',1.5);
grid on;%'LineWidth',1.5线的粗细参数
title('OOK modulation');
axis([0 f*length(g) -2.5 2.5]);
end
modulation_output=bpsk;
toc
        

        