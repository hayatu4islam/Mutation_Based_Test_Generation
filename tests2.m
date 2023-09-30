clc;
fname='sumOfRoots.m';
T=zeros(nPop,4);
for i=1:nPop
    tcase=pop_t(i).Position;
    a=bin2dec(num2str(tcase(1)))+1;
    b=bin2dec(num2str(tcase(2:5)))+1;
    c=bin2dec(num2str(tcase(6:end)))+1;
    T(i,1)=a;
    T(i,2)=b;
    T(i,3)=c;
    T(i,4)=b^2-4*a*c;
    %T(i,4)=sumOfRoots(a,b,c);
end
disp(T);

for j=1:mnPop
    chr=pop(i).Position;
    op=bin2dec(num2str(chr(1)))+1;
    lnum=round(bin2dec(num2str(chr(2:(num+1)))))+1;
    choice=round(bin2dec(num2str(chr(num+2:end))))+1;
    
%     if op==1
%         mutated=arithRep(fname,lnum,choice);
%     else
%         mutated=relRep(fname,lnum,choice);
%     end
    
end