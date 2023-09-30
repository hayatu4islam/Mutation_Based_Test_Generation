function fitval=MutFit0(fname,pop,pop_t)
    %z=sum(x);
    len=numOfLines(fname);
%     tsize=size(testcases);
%     tsize=tsize(1);
    tsize=length(pop_t);
    msize=length(pop);
    for i=1:1%tsize
        
        t=pop_t(i).Position;
        
        a=bin2dec(num2str(t(1:4)));
        b=bin2dec(num2str(t(5:8)));
        c=bin2dec(num2str(t(9:end)));
        realResult=quadraticSolver(a,b,c);
        %realResult=tritype(a,b,c);        
        for j=1:1%msize
           chr=pop(j).Position;
           %chr=mutants{j};
           op=bin2dec(num2str(chr(1)));% To select operator among arithmetic and relational operator replacement (Only 2 options)
           %op=op+1;
            lnum=bin2dec(num2str(chr(2:5)))+1;
            lnum=round(lnum);
            choice=bin2dec(num2str(chr(6:7)));
            choice=choice+1;
            nfname='mutantfname.m';
            copyfile(fname,nfname);
            if (op==1)
                    mutated=arithRep(fname,lnum,choice);
            elseif (op==0)
                    mutated=relRep(fname,lnum,choice);
            end
            %mutated=arithRep(nfname,lnum,choice);
            writeToFile(nfname,mutated);
            T=ones(1,tsize);
            %mresult=zeros(1,2);
            mresult=mutantfname(a,b,c);
            if ~isequal(realResult,mresult)
                pop(j).Cost=1;
            end
            %T(i)=y;
        end % End of if i=1:msize
        
    end
%     total=sum(T);
%     nkilled=0;
%     for k=1:tsize
%         nkilled=nkilled + (total*T(k));
%     end
%     fitval=(tsize^2) - nkilled;
%     %fitval=nkilled;
%     
fitval=pop;
end