clc;
n=5;
%vv=cell(1,n);
%vv=zeros(1,n);
vv=[];
for i=1:n
    v=randi([0 1],30,30);
    vv=[vv v];
end
disp(vv);