function y=Mutate_t(x,mu)

    nVar=numel(x);
    
    nmu=ceil(mu*nVar);
    
    j=randsample(nVar,nmu);
    
    y=x;
    y(j)=1-x(j);

end