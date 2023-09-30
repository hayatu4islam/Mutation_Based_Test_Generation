function ttMat = TestFit(fname,pop,pop_t)
% For every tester
fname='sumOfRoots.m';
msize=length(pop);
tsize=length(pop_t);
num = numel(de2bi(numOfLines(fname)));
nfname='mutantfname.m';
%T=zeros(msize,tsize);
T=zeros(msize,1);
for i=1:1%tsize
    tcase=pop_t(i).Position;
    [a,b,c]=decode(tcase);
    realResult=sumOfRoots(a,b,c);
    for j=1:msize
        chr=pop(j).Position;
        op=bin2dec(num2str(chr(1)))+1;
        lnum=round(bin2dec(num2str(chr(2:(num+1)))))+1;
        choice=round(bin2dec(num2str(chr(num+2:end))))+1;
        if (op==1)
            mutated=arithRep(fname,lnum,choice);
        else
            mutated=relRep(fname,lnum,choice);
        end
        writeToFile(nfname,mutated);
        mResult=mutantfname(a,b,c);
        if (realResult==mResult)
            T(j,i)=0;
        else
            T(j,i)=1;
        end
        
    end
end
ttMat=T;
end