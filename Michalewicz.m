function y = Michalewicz(x)
%% Michalewicz function
% http://www.sfu.ca/~ssurjano/michal.html
% Domain : for every xi <- (0, pi)
% Global Minimum :
% d = 2: y = -1.8013
%        x* = (2.20, 1.57)
% d = 5: y = -4.687658
% d = 10 y = -9.66015
% Michalewicz([2.2, 1.57]', 10)
%% 
m = 10;
%%
[dim, ~] = size(x);

lis = 1:dim;

tmp1 = sin(x);
tmp2 = sin((lis' .* (x.^2))./pi) .^ (2*m);
y = -sum(tmp1 .* tmp2, 1);
end
