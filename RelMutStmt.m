function y = RelMutStmt(fname)
% To scan the file and record the statements numbers where relational operators are
% found.
numLines=numOfLines(fname);
mut=zeros(numLines,1);
fid = fopen(fname,'r');
for k=1:numLines
    stmt=fgets(fid);
    if(~isempty(strfind(stmt,'>')))
        mut(k)=1;
    elseif(~isempty(strfind(stmt,'<')))
        mut(k)=1;
    elseif(~isempty(strfind(stmt,'>=')))
        mut(k)=1;
    elseif(~isempty(strfind(stmt,'<=')))
        mut(k)=1;
    elseif(~isempty(strfind(stmt,'==')))
        mut(k)=1;
    end    
end
fclose(fid);
y=find(mut); % To returns a vector containing the linear indices of each nonzero element in array X.
end