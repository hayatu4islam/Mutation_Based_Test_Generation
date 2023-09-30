function y=my_conv(x,h) 
%this function compute convolution of two vectors: 
% given two vectors; x1 and x2, convolution function generate a new
% vector y based on x1 and x2.
% e.g. x = 1:0.5:10; h = rand(1,19);
% y= my_conv(x,h);
x2=h; 
lx=length(x); 
lh=length(h); 
if lx>lh 
x2=[x2 zeros(1,lx-lh)]; 
else 
x=[x zeros(1,lh-lx)]; 
end 
y=zeros(1,lx+lh-1); 
x=fliplr(x); 
for i=1:length(y) 
if i<=length(x) 
y(i)=sum(x(1,length(x)-i+1:length(x)).*x2(1,1:i)); 
else 
j=i-length(x); 
y(i)=sum(x(1,1:length(x)-j).*x2(1,j+1:length(x2))); 
end 
end 