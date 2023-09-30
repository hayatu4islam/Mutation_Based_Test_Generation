function fitness= testEval(tMat)
div=sum(tMat,2);
%ttMatf = cell(size(tMat,1),size(tMat,2));
ttMatf=[];
for j=1:size(tMat,1)
    if(div(j)==0)
  %      ttMatf(
        ttMatf=[ttMatf;tMat(j,:)];
    else
        ttMatf=[ttMatf;tMat(j,:)/div(j)];
    end
    
end
%disp(ttMatf);
fitness=sum(ttMatf);
fitness=fitness';
end