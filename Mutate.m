% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA101
% Project Title: Implementation of Binary Genetic Algorithm in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
% %
% function y=Mutate(x,mu)
%     nVar=numel(x);    
%     nmu=ceil(mu*nVar);    
%     j=randsample(nVar,nmu);    
%     y=x;
%     y(j)=1-x(j);
% end
function y=Mutate(x,mu)
    fname='sumOfRoots.m';
    nVar=numel(x);    
    nmu=ceil(mu*nVar);    
    if (x(1)==0)
        lines=ArithMutStmt(fname);
        k=randsample(lines,1);
        binVal=de2bi(k);
    else
        lines=RelMutStmt(fname);
        k=randsample(lines,1);
        binVal=de2bi(k);
    end
    y = [x(1) binVal x(6:7)];
end