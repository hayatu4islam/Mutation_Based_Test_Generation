%function y=writeToFile(filename,array)
array = cell(1,10);
for i=1:10
    array{i} = 'Welcome to MATLAB';
end
fid = fopen('filename.m', 'w');
formatSpec='%s %d %2.1f %s\n';
[nrows ncols]=size(array);
for row=1:ncols-1
    fprintf(fid,'%s\n',array{row});
end
fprintf(fid,'%s',array{row});
fclose(fid);