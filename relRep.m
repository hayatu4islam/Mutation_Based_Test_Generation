function [rep,relnew] = relRep(file,replaceLine,choice)
replaceLine = round(replaceLine);
numLines=numOfLines(file);
mutlin=RelMutStmt(file);
%replaceLine=randsample(mutlin,1);
replaceLine=round(mod(replaceLine,numLines)); %1 is added in case the mod results into zero value
if replaceLine==0
    replaceLine=replaceLine+1;
end
fid = fopen(file,'r');
mydata=cell(1,numLines);
for k=1:numLines
    mydata{k}=fgets(fid);
end
fclose(fid);
newdata = mydata{replaceLine};
operators={'>','<','>=','<=','=='}; % Revise the value of choice to take the whole operators
%choice=randi([1 5]); % Index of operator to be replaced
opnumb = choice;
repnumb = randi([1 4]);
rel = operators(opnumb);
if (~isempty(searchRelOp(newdata,'>')))
    rel='>';
    operator={'<','>=','<=','=='};
elseif (~isempty(searchRelOp(newdata,'<')))
    rel='<';
    operator={'>','>=','<=','=='};
elseif (~isempty(searchRelOp(newdata,'>=')))
    rel='>=';
    operator={'>','<','<=','=='};
elseif (~isempty(searchRelOp(newdata,'<=')))
    rel='<=';
    operator={'>','<','>=','=='};
elseif (~isempty(searchRelOp(newdata,'==')))
    rel='==';
    operator={'>','<','>=','<='};
else
    operator={'>','<','>=','<=','=='};
end
relnew=operator(repnumb);
s=regexprep(newdata,rel,relnew,'once');
mydata{1,replaceLine}=s;
rep=mydata;
%rep=s;
end