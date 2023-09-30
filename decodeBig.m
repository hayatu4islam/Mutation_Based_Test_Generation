function input = decodeBig(testcase)
% This function converts the test cases into the decimal values (a,b,c,...)
    tcase=testcase;
    len=length(tcase);
    n=3;
    input=zeros(len/n,1);
%     if(len==15)
        input(1)=bin2dec(num2str(tcase(1:n)));
        input(2)=bin2dec(num2str(tcase(n+1:2*n)));
        input(3)=bin2dec(num2str(tcase(2*n+1:3*n)));
        input(4)=bin2dec(num2str(tcase(3*n+1:4*n)));
        input(5)=bin2dec(num2str(tcase(4*n+1:5*n)));
    if(len==24)
        input(6)=bin2dec(num2str(tcase(5*n+1:6*n)));
        input(7)=bin2dec(num2str(tcase(6*n+1:7*n)));
        input(8)=bin2dec(num2str(tcase(7*n+1:8*n)));
    end
    
end