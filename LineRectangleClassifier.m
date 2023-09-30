function pos = LineRectangleClassifier(xr1,xr2,yr1,yr2,xl1,xl2,yl1,yl2)
    if ((xr1<xr2)&&(yr1<yr2)&&(xl1<=xl2))
        if ((xl1>=xr1)&&(xl1<=xr2)&&(xl2>=xr1)&&(xl2<=xr2)&&(yl1>=yr1)&&(yl1<=yr2)&&(yl2>=yr1)&(yl2<=yr2))
            pos = 'Completely Inside';
        elseif(())
        end
    else

    end
end
