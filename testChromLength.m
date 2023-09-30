function y = testChromLength(inputDim)
opr = zeros(size(inputDim,1),1);
for i=1:size(inputDim,1)
    opr(i) = inputDim(i,1)*inputDim(i,2);
end
totals=sum(opr);
if (size(inputDim,1)==1)
    if (totals==1)
        chrlen=7;
    else
        chrlen=3*totals;
    end
elseif (size(inputDim,1)>=2)
    if (totals==size(inputDim,1))
        chrlen = 7*totals;
    elseif(totals>size(inputDim,1))
        chrlen = 3*totals;
    end
end
y=chrlen;
end