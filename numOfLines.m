% function n = numOfLines(files)
% n = 0;
% fid=fopen(files);
% tline = fgetl(fid);
% while ischar(tline)
%   tline = fgetl(fid);
%   n = n+1;
%   n=19;
% end

function y= numOfLines(files)
% Reading the original file
fid = fopen(files);
res={};
while ~feof(fid)
  res{end+1,1} =fgetl(fid);
end
fclose(fid);
number_of_lines=numel(res);
y=number_of_lines;

