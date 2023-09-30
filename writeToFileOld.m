function writeToFile(filename,arr) % arr is a cell array
%arr = {'boy', 'cat', 'dog', 'doll', 'vase', 'sweet', 'log'};
%% writeToFile: stores cell array as a text file named in line 13.

% directory = char(pwd);
% disp('File saved to Location : '), 
% disp(directory)

%% Function Body
% Dummy Cell Array := arr = {'boy', 'cat', 'dog', 'doll', 'vase', 'sweet', 'log'};

arr = char(arr); %Data conversion: from cell --> char_array

fid = fopen(filename, 'w'); % Filename : 

[nr , ~]=size(arr);

for r = 1:nr % This loops across the char elements in the file
    
    fprintf(fid, '%s\r\n', arr(r,:)); 
    %fprintf(fid, '%s\r\n', arr(r,:)); 
    % fetch all chars (cols) in each row
    % remove one '\r\n' to remove double line spacing
    
end
fclose(fid);