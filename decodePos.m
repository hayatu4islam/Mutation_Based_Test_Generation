function [x,y,z]=decodePos(testcase)
% This function converts the test cases into the decimal values (a,b,c)
    tcase=testcase;
    if nargout==1
        x = bin2dec(num2str(tcase))+1;
    elseif nargout==2
        n=length(tcase)/2;
        
    end
    
    n=length(tcase)/3;
    ai=tcase(1:n);
    bi=tcase(n+1:2*n);
    ci=tcase(2*n:end);
    x=bin2dec(num2str(ai(1:end)))+1;
    y=bin2dec(num2str(bi(1:end)))+1;
    z=bin2dec(num2str(ci(1:end)))+1;    
end