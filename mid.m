function m = mid(x,y,z)
    m = z;
    if (y<z)
        if (x<y)
            m=y;
        else
            if(x<z)
                m=x;
            end
        end
    else
        if(x>y)
            m=y;
        else
            if(x>z)
                m=x;
            end
        end
    end
end