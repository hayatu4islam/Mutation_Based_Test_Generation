clc;
clear;
%clear all;
limit=30;
mutants=cell(10,1);

for i=1:10
    mutants{i}=randi([0 1],[1 6]);
    
end
for j=1:10
    %disp(mutants(j));
    disp([ mutants(j) ': Value = ' bin2dec(num2str(mutants{j}(1:end)))]);
    %disp(size(mutants));
end
count=0;
values=zeros(1,10);
for k=1:length(mutants)
    value=bin2dec(num2str(mutants{k}));
%     value=bin2dec(num2str(mutants(k)));
    if(value>limit)
        %break;
        %mutants(k,:)=[];
        
        mutants{k}=[];
    end
end
a=length(mutants);
nmut=cell(1);

for p=1:a
    
    if(~isempty(mutants{p}))
        nmut=[nmut;mutants{p}];
        %a=a-1;
    end
end
nmut(1)=[];
%disp((mutants));
disp((nmut));