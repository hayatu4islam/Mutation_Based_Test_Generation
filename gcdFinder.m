function z = gcdFinder(x,y)
while (x~=y)
    if(x>=y-1)
        x=x-y;
    elseif(x<y-1)
        y=y-x;
    end
end
z=x;
end