function sol = triQuad(a,b,c)
    type = 3;
    if (~(a>0) || ~(b>0) || ~(c>0) || ~(a<=b+c) || ~(b<a+c) || ~(c<a+b))
        type = 3;
    else
        if ((a==b) && (b==c))
            type = mod(type,3)+3;% 3 for Equilateral triangle
        elseif ((a==b) && (b~=c)) || ((a==c) && (c~=b)) || ((b==c) && (c~=a))
            type = mod(type,3)+2;% 2 for Isosceles
        elseif (a~=b) && (b~=c)
            type = mod(type,3)+1;% 1 for Scalene
        end
     end
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
     sol = type + y;
end