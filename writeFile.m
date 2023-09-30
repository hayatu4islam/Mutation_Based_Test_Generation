function y = writeFile(filename,tempFile)
i=1:5;
newFile=sprintf(filename,i);
fout=fopen(newFile,'a');
fprintf(fout,'%s\n',tempFile);
fclose(fout);
