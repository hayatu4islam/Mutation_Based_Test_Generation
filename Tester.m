function [killVector] = Tester(fname,mutants,tcase)
%% An edited version of an original function is called its mutant. 
% Test cases are generated and passed as "tcase" in this function while
% fname is the name of the function (sumOfRoots.m) to be passed, mutants is the cell
% array of the mutants. The same test cases are passed to the original
% and each of its mutants. If the result of the original version is
% different from the mutant's, then the mutant is killed else alive. The
% killVector stores the vector of killing of each mutant. If the mutant is
% killed, its killing value is ONE but if it's alive, the value is ZERO
 %tcase=[0     1     1     1     0     1     1];
 %fname='sumOfRoots.m';
 num = numel(de2bi(numOfLines(fname))); 
 msize=length(mutants); % I have attached the .mat file which contains the cell array of mutants
 a=bin2dec(num2str(tcase(1)))+1;
 b=bin2dec(num2str(tcase(2:5)))+1;
 c=bin2dec(num2str(tcase(6:end)))+1;
 
 
 %disp(realResult);
 nfname='mutantfname.m';
 T=zeros(msize,1);
 values=zeros(msize,1);
 %%
 i = 1;
 while(i <= msize)
 %while(i <= 2)%msize/3)
 %for i=1:msize
     chr=mutants{i};
     op=bin2dec(num2str(chr(1)))+1;
     lnum=round(bin2dec(num2str(chr(2:num+1)))+1);
     choice=round(bin2dec(num2str(chr(num+2:end)))+1);
     
     if (op==1)
            mutated=arithRep(fname,lnum,choice);
     elseif (op==2)
            mutated=relRep(fname,lnum,choice);
     end
     
     %writeToFile(nfname,mutated); % You can select from the list of mutated[1-10] attached and save each time so as to have different files
%     mresult=mutantfname(a,b,c);
     filenames=strcat('m',num2str(i));
     ffilenames=strcat(filenames,'.m');
     writeToFile(ffilenames,mutated);
     f=strcat(filenames,'(',num2str(a),',',num2str(b),',',num2str(c),')');
     mresult=eval(f);
%     mresult=mutantfname(a,b,c);
%      delete('mutantfname.m');
%      clear mutated;
     values(i)=mresult;
     r=randi(1);
     realResult=sumOfRoots(a,b,c);% Try to shift it inside the loop after write
     if isequal(realResult,mresult)
         y=0;
     else
         y=1;
     end
     T(i)=y;
     i = i + 1;
 end
 %%
 %killVector=T';
 killVector=values';
end