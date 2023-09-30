function [op,lnum,ch]=analyzeMutant(mutInd)% mutant individual is the parameter
    fname='sumOfRoots.m';
    %fname='sumRoots.m';
    num = numel(de2bi(numOfLines(fname)));
    chr=mutInd;
    op=bin2dec(num2str(chr(1)))+1;
    lnum=round(bin2dec(num2str(chr(2:(num+1)))))+1;
    ch=round(bin2dec(num2str(chr(num+2:end))))+1;
end