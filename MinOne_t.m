%function [killVector,z,nk]=MinOne_t(fname,mutants,tcase)
function [z,nk,killVector,chMat]=MinOne_t(fname,mutants,ttcase)
    %z is the sensitivity while nk is the array of number of killed mutants
    % killVector is the vector of killed mutants
    %chMat is the choice matrix for the two operators and their choices
    tcase=ttcase;
    %len=numOfLines(fname);
    num = numel(de2bi(numOfLines(fname)));
    [a,b,c] = decode(tcase);
%     a=bin2dec(num2str(tcase(1)))+1;
%     b=bin2dec(num2str(tcase(2:5)))+1;
%     c=bin2dec(num2str(tcase(6:end)))+1;
    %realResult=quadraticSolver(a,b,c);
    %realResult=tritype(a,b,c);
    
    msize=length(mutants);
    var=zeros(1,msize);
    %T=ones(msize,1);
    T=zeros(msize,1);
    %T=zeros(1,1);
    sensitivity = zeros(msize,1);
    killCount = zeros(2,1);
    nfname='mutantfname.m';
    chMat = zeros(5,4); % arith choice Matrix to return the total number of choice and number alive (Mutants)
    arithChMat = zeros(5,2); % arith choice Matrix to return the total number of choice and number alive (Mutants)
    % 1-add, 2-sub, 3-mult, 4-div, 5-exp
    relChMat = zeros(5,2); % rel choice Matrix to return the total number of choice and number alive (Mutants)
    % 1->, 2-<, 3- >=, 4- <=, 5- ~=
    
    for j=1:msize
    %for j=1:3%msize(1)
        chr=mutants{j};
        %chr=pop(j).Position;
        op=bin2dec(num2str(chr(1)))+1;% To select operator among arithmetic and relational operator replacement (Only 2 options)
        %op=op+1;
        lnum=round(bin2dec(num2str(chr(2:(num+1)))))+1;
        choice=round(bin2dec(num2str(chr(num+2:end))))+1;
        if (op==1)
            [mutated,arithnew] = arithRep(fname,lnum,choice);
            if (arithnew=='+')
                chMat(1,1) = chMat(1,1) + 1;
            elseif (arithnew=='-')
                chMat(2,1) = chMat(2,1) + 1;
            elseif (arithnew=='*')
                chMat(3,1) = chMat(3,1) + 1;
            elseif (arithnew=='/')
                chMat(4,1) = chMat(4,1) + 1;
            else
                chMat(5,1) = chMat(5,1) + 1;
            end
        elseif (op==2)
            [mutated,relnew] = relRep(fname,lnum,choice);
            if strcmp(relnew,'>')
                chMat(1,3) = chMat(1,3) + 1;
            elseif strcmp(relnew,'<')
                chMat(2,3) = chMat(2,3) + 1;
            elseif strcmp(relnew,'>=')
                chMat(3,3) = chMat(3,3) + 1;
            elseif strcmp(relnew,'<=')
                chMat(4,3) = chMat(4,3) + 1;
            else
                chMat(5,3) = chMat(5,3) + 1;
            end
        end
%         filename=strcat('m',num2str(j));
%         ffilename=strcat(filename,'.m');
%         writeToFile(ffilename,mutated);
%         f=strcat(filename,'(',num2str(a),',',num2str(b),',',num2str(c),')');
%         mresult=eval(f);
        writeToFile(nfname,mutated);
        for k=1:5
            pppp=2*squ(3*k);            
        end
        
        %mresult=squ(b);
        mresult=mutantfname(a,b,c);
        
        realResult=sumOfRoots(a,b,c);
        %realResult=triQuad(a,b,c);
%        var(j)=mresult;
        clear mutantfname.m;
        if isequal(realResult,mresult)
        %if (realResult ~= mresult)
           y=0;
           %killCount(op) = killCount(op) + 1;
           if (op==1)
                if (arithnew=='+')
                    chMat(1,2) = chMat(1,2) + 1;
                elseif (arithnew=='-')
                    chMat(2,2) = chMat(2,2) + 1;
                elseif (arithnew=='*')
                    chMat(3,2) = chMat(3,2) + 1;
                elseif (arithnew=='/')
                    chMat(4,2) = chMat(4,2) + 1;
                else
                    chMat(5,2) = chMat(5,2) + 1;
                end
           elseif (op==2)
                if strcmp(relnew,'>')
                    chMat(1,4) = chMat(1,4) + 1;
                elseif strcmp(relnew,'<')
                    chMat(2,4) = chMat(2,4) + 1;
                elseif strcmp(relnew,'>=')
                    chMat(3,4) = chMat(3,4) + 1;
                elseif strcmp(relnew,'<=')
                    chMat(4,4) = chMat(4,4) + 1;
                else
                    chMat(5,4) = chMat(5,4) + 1;
                end               
           end
        else
            y=1;
            killCount(op)=killCount(op)+1;
        end
        T(j)=y;
        sensitivity(j) = abs((mresult - realResult));%/realResult);%/realResult;
    end
    nk = killCount;
    z = mean(sensitivity);
    killVector=T;
    %var
end