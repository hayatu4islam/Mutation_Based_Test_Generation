function [y1, y2]=SinglePointCrossover1(x1,x2)
    fname='sumOfRoots.m';
    nVar=numel(x1);
    arith=ArithMutStmt(fname);
    rel=RelMutStmt(fname);
    loc1 = bin2dec(num2str(x1(2:5)))+1;
    loc2 = bin2dec(num2str(x2(2:5)))+1;
    cond1=true;
    cond2=true;
    c=randi([1 nVar-1]);
    random1 = randi([1 3]);
    opr = bin2dec(num2str(random1))+1;
    while(cond1)
        if((ismember(loc1,arith) && opr<=4) || ((ismember(loc1,rel) && opr>=5)));
            cond1=false;
        else
            cond1=true;
        end
    end
    x1(1) = opr(1);
    x1(6:7) = opr(2:3);
    
    opr = bin2dec(num2str(random1))+1;
     while(cond2)
        if((ismember(loc2,arith) && opr<=4) || ((ismember(loc2,rel) && opr>=5)));
            cond2=false;
        else
            cond2=true;
        end
     end
    x2(1) = opr(1);
    x2(6:7) = opr(2:3);
    y1 = x1;
    y2 = x2;
%     y1=[x1(1:c) x2(c+1:end)];
%     y2=[x2(1:c) x1(c+1:end)];

end