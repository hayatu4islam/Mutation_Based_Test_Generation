function rep = arithDel(fname,deleteLine,choice)
%replaceLine=round(replaceLine);
numLines=numOfLines(fname);
mutline=([ArithMutStmt(fname);4;7]);
%replaceLine=randsample(mutline,1);
deleteLine=round(mod(deleteLine,numLines));
if deleteLine==0
    deleteLine=deleteLine+1;
end
fid = fopen(fname,'r');
mydata=cell(1,numLines);
for k=1:numLines
    mydata{k}=fgets(fid);
end
fclose(fid);
newdata = mydata{deleteLine};
operators=['+','-','*','/','^'];
%choice=randi([1 5]); % Index of operator to be replaced
opnumb=choice;
%% opnumb = choice+1;
repnumb = randi([1 4]);% Index of the operator to replace the existing one
arith = operators(opnumb);

if (~isempty(searchArithOp(newdata,'+')))
    arith='+';
    operator=['-','*','/','^'];
elseif (~isempty(searchArithOp(newdata,'-')))
    arith='-';
     operator=['+','*','/','^'];
elseif (~isempty(searchArithOp(newdata,'*')))
    arith='*';
     operator=['+','-','/','^'];
elseif (~isempty(searchArithOp(newdata,'/')))
    arith='/';
    operator=['+','-','*','^'];
elseif (~isempty(searchArithOp(newdata,'^')))
    arith='^';
    operator=['+','-','*','/'];
else
    operator=['+','-','*','/','^'];
end
index = strfind(newdata,arith);
newdata = strrep(newdata,newdata(index:end),';');
% arithnew=operator(repnumb);
% s=regexprep(newdata,arith,arithnew,'once');
% mydata{1,deleteLine}=s;
mydata{1,deleteLine}=newdata;
rep=mydata;
%rep=s;
end