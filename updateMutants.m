function z=updateMutants(pop)
lent=length(pop);
count=0;

for k=1:lent
    value=pop(k).Cost;
%     value=bin2dec(num2str(mutants(k)));
    if(value==9)
        pop(k).Position=[];
       % pop(k).Cost=[];
    end
        %break;
        %mutants(k,:)=[];
end
a=length(pop);
nmut=cell(1);

for p=1:a
    
    if(~isempty(pop(p).Position))
        nmut=[nmut;pop(p).Position];
        %a=a-1;
    end
end
nmut(1)=[];
%disp((mutants));
%disp((nmut));
z=nmut;