function y = StyblinskiTang(x)
%% Styblinski-Tang function
% http://www.sfu.ca/~ssurjano/stybtang.html
% Domain xi <- (-5, 5)
% Global Minimum : -39.16599 * dim
% x* = (-2.903534, ..., -2.903534)
%% 

y = 0.5 * sum(x.^4 - 16*x.^2 + 5*x);

end
