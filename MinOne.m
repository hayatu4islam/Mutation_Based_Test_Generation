function fitval=MinOne(fname,mutant,testcases)
    %z=sum(x);
    %len=numOfLines(fname);
    num = numel(de2bi(numOfLines(fname)));
%     tsize=size(testcases);
%     tsize=tsize(1);
    tsize=length(testcases);
    
    chr=mutant;
    op=bin2dec(num2str(chr(1)))+1;% To select operator among arithmetic and relational operator replacement (Only 2 options)
    %op=op+1;
    lnum=round(bin2dec(num2str(chr(2:num+1)))+1);
    %lnum=bin2dec(chr([2:5]),'left-msb');
    %lnum=round(lnum);
    %lnum=mod(lnum,len);
    choice=round(bin2dec(num2str(chr(num+2:end)))+1);
    %choice=choice+1;
        
    nfname='mutantfname.m';
    copyfile(fname,nfname);
    if (op==1)
            mutated=arithRep(fname,lnum,choice);
    elseif (op==2)
            mutated=relRep(fname,lnum,choice);
%     elseif (op==3)
%             mutated=opDel(fname,lnum,choice);
%     elseif (op==4)
%             mutated=stmtDel(fname,lnum,choice);
    end
        
%    mutated=arithRep(nfname,lnum,choice);
    writeToFile(nfname,mutated);
    T=ones(1,tsize);
    %mresult=zeros(1,2);
    for tcn=1:tsize % TestCase Number (Tcn) from 1 to tsize
        t=testcases{tcn};
        [a,b,c] = decode(t);
%         a=bin2dec(num2str(t(1)))+1;
%         b=bin2dec(num2str(t(2:5)))+1;
%         c=bin2dec(num2str(t(6:end)))+1;
        %realResult=quadraticSolver(a,b,c);
%         realResult=tritype(a,b,c);
        realResult=sumOfRoots(a,b,c);        
        %realResult=triQuad(a,b,c);
        mresult=mutantfname(a,b,c);
        if isequal(realResult,mresult)
            y=0;
        else
            y=1;
        end
        
        T(tcn)=y;
        
    end
    total=sum(T);
    nkilled=0;
    for k=1:tsize
        nkilled=nkilled + (total*T(k));
    end
    fitval=(tsize^2) - nkilled;
    %fitval=nkilled;
    %fitval=T';
end