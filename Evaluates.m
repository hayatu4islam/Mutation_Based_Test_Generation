function fitval=Evaluates(mutant)
    %z=sum(x);
    testcase=[0 0 1 0 0 1 1 1 0 1 1 0]; % Dummy test case
    %fname='quadraticSolver.m';
    fname='sumOfRoots.m';
    len=numOfLines(fname);
    chr=mutant;
    op=bin2dec(num2str(chr(1)));% To select operator among arithmetic and relational operator replacement (Only 2 options)
    %op=op+1;
    lnum=bin2dec(num2str(chr(2:5)))+1;
    %lnum=bin2dec(chr([2:5]),'left-msb');
    %lnum=lnum+1;
    lnum=mod(lnum,len);
    choice=bin2dec(num2str(chr(6:7)))+1;
    %choice=choice+1;    
    nfname='mutantfname.m';
    copyfile(fname,nfname);
    if (op==1)
            mutated=arithRep(fname,lnum,choice);
    elseif (op==0)
            mutated=relRep(fname,lnum,choice);
    end
        
%    mutated=arithRep(nfname,lnum,choice);
    writeToFile(nfname,mutated);
%    T=ones(1,tsize);
    %for tcn=1:tsize % TestCase Number (Tcn) from 1 to tsize
        a=bin2dec(num2str(testcase(1:4)));
        b=bin2dec(num2str(testcase(5:8)));
        c=bin2dec(num2str(testcase(9:end)));
        realResult=quadraticSolver(a,b,c);
        %realResult=tritype(a,b,c);
        mresult=mutantfname(a,b,c);
        if isequal(realResult,mresult)
            y=0;
        else
            y=1;
        end
        %T(tcn)=y;
    %end
    %fitval=(tsize^2) - nkilled;
    %fitval=nkilled;
    fitval=1-y;
end