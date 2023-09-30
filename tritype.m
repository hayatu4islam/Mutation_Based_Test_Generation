function type = tritype(a,b,c)
    type ='';
    if ((a<=0) || (b<=0) || (c<=0) || (a>=b+c) || (b>=a+c) || (c>=a+b))
        type = 'invalid';
    else
        if ((a==b) && (b==c))
            type = 'equilateral';
        elseif ((a==b) && (b~=c)) || ((a==c) && (c~=b)) || ((b==c) && (c~=a))
            type = 'isosceles';
        elseif (a~=b) && (b~=c)
            type = 'scalene';
        end
    end
end