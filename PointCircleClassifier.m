function position = PointCircleClassifier(cx,cy,radius,x,y)
    adj = x-cx;
    opp = y-cy;
    z = (adj^2) + (opp^2) - (radius^2);
    %z = (x-cx)^2 + (y-cy)^2 - radius^2;
    if (z > 0)
        position='Outside';
    elseif (z < 0)
        position = 'Inside';
    else
        position = 'On the circle';
    end
end