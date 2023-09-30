clc;
fname='sumOfRoots.m';
n=20;
fof=cell(n,1);
for i=1:n
    fof{i}=randMutantGen(fname);
end
disp('Completed');