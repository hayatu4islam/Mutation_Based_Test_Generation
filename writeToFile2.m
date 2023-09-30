function y=writeToFile(filename,arr) % arr is a cell array
fid = fopen(filename, 'w'); % Filename is the name of the file I am about to create
formatSpec='%s %d %2.1f %s\n';
[nrows,ncols]=size(arr);
for row=1:ncols-1 % This loops across the n-1 elements in the cell
    fprintf(fid,'%s %d %2.1f %s\n',arr{row});
end
fprintf(fid,'%s',arr{ncols}); % This writes the last element in the cell and I removed \n since it's d end
fclose(fid);