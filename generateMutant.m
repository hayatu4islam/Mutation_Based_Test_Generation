function generateMutant(fname,mutantName,binMutant)
    
    [x,y,z]=analyzeMutant(binMutant);
    if (x==1)
        mutated = arithRep(fname,y,z);
    else
        mutated = relRep(fname,y,z);
        
    end
    writeToFile(mutantName,mutated);
    
end