function dec=Sviterbi(recv,l)
leth = length(recv)/2;
if (l==0)
    qr=recv;
else
    qr=(recv+1)/2;
end
% qr=zeros(1,length(recv));
% for i=1:length(recv);
%     qr(i)=quantization(recv(i),l);
% end
% nextstate=[0 2;0 2;1 3;1 3];
outputs=[0 3;3 0;2 1;1 2];
suropt=zeros(4,leth-2);
suroptem=suropt;
current=[0 0 0 0];
current(1)=EUdist([0 0 0 0],qr([1 2 3 4]));
current(2)=EUdist([1 1 1 0],qr([1 2 3 4]));
current(3)=EUdist([0 0 1 1],qr([1 2 3 4]));
current(4)=EUdist([1 1 0 1],qr([1 2 3 4]));
suropt(1,[1 2])=[0 0];
suropt(2,[1 2])=[1 0];
suropt(3,[1 2])=[0 1];
suropt(4,[1 2])=[1 1];
currentem=[0 0 0 0];
ls=[1 0 0;2 0 0;3 0 0;4 0 0;1 0 1;2 0 1;3 0 1;4 0 1];
 
for i=3:(leth-2);
    for x=1:4
       m1= dec2bin(outputs(ls(x*2-1,1),ls(x*2-1,3)+1),2);
        c=EUdist([str2double(m1(1)) str2double(m1(2))],qr([i*2-1 i*2]));
       m2 = dec2bin(outputs(ls(x*2,1),ls(x*2,3)+1),2);
        d=EUdist([str2double(m2(1)) str2double(m2(2))],qr([i*2-1 i*2]));
       if(current(ls(x*2-1,1))+c)<(current(ls(x*2,1))+d);
           currentem(x)=current(ls(x*2-1,1))+c;
           suroptem(x,:)=suropt(ls(x*2-1,1),:);
           suroptem(x,i)=ls(x*2-1,3);
       else 
           currentem(x)=current(ls(x*2,1))+d;
           suroptem(x,:)=suropt(ls(x*2,1),:);
           suroptem(x,i)=ls(x*2,3);  
       end
    end
    current=currentem;
    suropt=suroptem;
end
a=[1 9999];
for s=1:4;
    if current(s)<a(2);
        a(2)=current(s);
        a(1)=s;
    else
    end
    
 dec =suropt(a(1),:);
end        