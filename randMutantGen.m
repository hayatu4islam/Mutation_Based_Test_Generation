function y = randMutantGen(fname)
    num = numel(de2bi(numOfLines(fname)));
    opr=randi([0 1]);
    if opr==0
        lineVec = ArithMutStmt(fname)-1; % This (-1) is in order to cater for zero binary value which should be excluded
    else
        lineVec = RelMutStmt(fname)-1;
    end
    rnd = randsample(lineVec,1);
    sel = de2bi(rnd,num,'left-msb'); % Selected line number for mutation in binary
%    sel = de2bi(randsample(lineVec,1),4,'left-msb'); % selected line number for mutation in binary
    choice = randi([0 1],1,2);
    y =[opr sel choice];
end