clc;
emp.operator=[];
emp.score=[];
opscore=repmat(emp,5,1);
opscore(1).operator='Arithmetic';
opscore(2).operator='Relational';
opscore(3).operator='Conditional';
opscore(4).operator='Logical';
opscore(5).operator='Assignment';
for i=1:5
    opscore(i).score=num2str(50);
end
value=str2double(opscore(4).score)*5;
opscore(4).score=num2str(value);
for i=1:5
    disp([opscore(i).operator ' = ' opscore(i).score]);
end