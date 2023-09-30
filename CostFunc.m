function [Tweight,Tvalue,capacity]=CostFunc(x)
    weight = [70 73 77 80 82 87 90 94 98 106 110 113 115 118 120];

    value = [135 139 149 150 156 163 173 184 192 201 210 214 221 229 240];

    TotalWeight=750;
    a=sum(weight.*x);
    b=sum(value.*x);
    
    Tweight=a;
    Tvalue=b;
    capacity=TotalWeight;
end