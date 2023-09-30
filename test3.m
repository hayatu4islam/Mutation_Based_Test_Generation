clc;
result = inputdlg('Enter number of input in program: ');
result = str2double(result);
%pp = cell(result,1);
%pp = zeros(result,1);
prompt = {'Enter the number of rows: ','Enter the number of columns: '};
defaultans = {'1','1'};
total=0;
for i=1:result
    dim = inputdlg(prompt,'Input',1,defaultans);
    pp = prod(str2double(dim));
    total = total + pp;
end
disp(total);