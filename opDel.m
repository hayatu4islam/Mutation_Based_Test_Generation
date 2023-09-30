function rep = opDel(fname,deleteLine,choice)
numLines=numOfLines(fname);
deleteLine=round(mod(deleteLine,numLines)+1);
fid = fopen(fname,'r');
mydata=cell(1,numLines);
for k=1:numLines
    mydata{k}=fgets(fid);
end
fclose(fid);
newdata = mydata{deleteLine};
str=newdata;
op='';
opr=['+','-','*','/','^'];
if(~isempty(strfind(str,opr(1))))
    op='+';
elseif(~isempty(strfind(str,opr(2))))
    op='-';
elseif(~isempty(strfind(str,opr(3))))
    op='*';
elseif(~isempty(strfind(str,opr(4))))
    op='/';
end
mydata{1,deleteLine}=regexprep(str,op,');%','once');
%rep=mydata{:};
rep=mydata;
%celldisp(rep);
end