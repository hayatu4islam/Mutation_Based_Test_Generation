j = 1;  
  while (j  <= msize)
    %for j=1:10%msize(1)
        chr=mutants{j};
        op=bin2dec(num2str(chr(1)))+1;% To select operator among arithmetic and relational operator replacement (Only 2 options)
        %op=op+1;
        lnum=round(bin2dec(num2str(chr(2:(num+1)))))+1;
        choice=round(bin2dec(num2str(chr(num+2:end))))+1;
        %nfname=strcat('mutantfname',num2str(j),'.m');
        nfname='mutantfname.m';
        %copyfile(fname,nfname,'f');
        if (op==1)
            mutated = arithRep(fname,lnum,choice);
        elseif (op==2)
            mutated = relRep(fname,lnum,choice);
        end
        writeToFile(nfname,mutated);
        %writeToFile(nfname,mutated);
        %mresult=squ(b);
        % [s, mutated]=arithRep(fnme, lnum, choice);
        % mresult = mutantarith(mutated, s, lnum, a, b, c);
        mresult=mutantfname(a,b,c);
        pause(0.03); % To complete the execution (If possible)
       if (realResult ~= mresult)
        %if ~isequal(realResult,mresult)
       %if abs(mresult - realResult)>0
           T(j)=2;
           killCount(op) = killCount(op) + 1;
      
       
      end
      msvalue = abs((mresult - realResult));%/realResult);%/realResult;
      sensitivity(j)=msvalue;
        %if ~isequal(realResult,mresult)
      g=g+1; % Number of killed mutants
            %T(j)=mresult;
        %end
       j = j + 1;
  end