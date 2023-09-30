function [x,y,z]=decode(testcase)
% This function converts the test cases into the decimal values (a,b,c)
    tcase=testcase;
    if nargout==1
        a = bin2dec(num2str(tcase))+1;
    elseif nargout==2
        n=round(length(tcase)/2);
        ai=tcase(1:n);
        bi=tcase(n+1:end);
        a=bin2dec(num2str(ai(2:end)))+1;
        b=bin2dec(num2str(bi(2:end)))+1;
    elseif nargout==3
        n=round(length(tcase)/3);
        ai=tcase(1:n);
        bi=tcase(n+1:2*n);
        ci=tcase(2*n+1:end);
        a=bin2dec(num2str(ai(2:end)))+1;
        b=bin2dec(num2str(bi(2:end)))+1;
        c=bin2dec(num2str(ci(2:end)))+1;
    end
    if (ai(1)==1)
        x = a;
    else
        x = -a;
    end
    
    if (bi(1)==1)
        y = b;
    else
        y = -b;
    end
    
    if (ci(1)==1)
        z = c;
    else
        z = -c;
    end
    
end