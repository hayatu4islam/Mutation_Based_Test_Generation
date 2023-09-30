function [expo] = pdfKernel(Xn, mu, sigmaX)
%This function compute e^-0.5*(x - mu)^2/sigma^2+b^2 for pdf estimation.
% 
%   if size(Xn,1)> size(mu,1)
%   
%     zro = zeros(1,size(mu,2));
%     mu = [zro;mu];
%  
% 
%  end
% nofexpo = zeros(size(Xn,1));
%% 
% E.g Xn =rand(1,100); mu = mean(Xn); sigmaX = std(Xn);

b= 0.5;       % bwidth value is changeable. Choose between 0 and 1.
nofexpo = Xn - mu;
nofexpo = nofexpo.^2;   %numerators of the expo
dofexpo = sigmaX.^2 + b.^2; %denominators of the expo
for i = 1:size(nofexpo,2)
    if numel(dofexpo) == 1
    ex(:,i) = nofexpo(:,i)./dofexpo;
    else
    ex(:,i) = nofexpo(:,i)./dofexpo(i); %ex = nofexpo/dofexpo;
    end
end
expo = exp(-0.5*ex); 
