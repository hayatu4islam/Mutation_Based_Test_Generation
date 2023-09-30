function y = sumRoots(a,b,c)
 x = zeros(1,2);
 d = sqrt(b^2-4*a*c);
 if(d>0)
     x(1) = ( 0-b + d )/(2*a);
     x(2) = ( 0-b - d )/(2*a);
 elseif(d==0)     
     x(1) = 0-b/(2*a);
     x(2)=x(1);
 else
     x(1)=pi;
     x(2)=pi; 
 end
 y=sum(x);
end