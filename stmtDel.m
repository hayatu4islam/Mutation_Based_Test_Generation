function rep = stmtDel(fname,deleteLine,choice)
numLines=numOfLines(fname);
deleteLine=round(mod(deleteLine,numLines)+1);
fid = fopen(fname,'r');
mydata=cell(1,numLines);
for k=1:numLines
    mydata{k}=fgets(fid);
end
fclose(fid);
newdata = mydata{deleteLine};
str={'%',newdata};
mydata{1,deleteLine}=strjoin(str);
%rep=mydata{:};
rep=mydata;
%celldisp(rep);
end