function [y] = BUKIN(xx)
%% BUKIN function
% http://www.sfu.ca/~ssurjano/bukin6.html
% x <- (-15, 3)
%% 

x1 = xx(1, :);
x2 = xx(2, :);

term1 = 100 * sqrt(abs(x2 - 0.01*x1.^2));
term2 = 0.01 * abs(x1+10);

y = term1 + term2;

end
