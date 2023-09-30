function op = searchArithOp(stmt,opr)
op=[];
if(~isempty(strfind(stmt,opr)))
    op=opr;
% elseif(~isempty(strfind(stmt,'-')))
%     mut(k)=1;
% elseif(~isempty(strfind(stmt,'*')))
%     mut(k)=1;
% elseif(~isempty(strfind(stmt,'/')))
%     mut(k)=1;
% elseif(~isempty(strfind(stmt,'^')))
%     mut(k)=1;
end 
end