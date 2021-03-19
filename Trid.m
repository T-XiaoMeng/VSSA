function y = Trid(x)
%% Tird function
% http://www.sfu.ca/~ssurjano/trid.html
% domain x <- (-d^2, d^2)
% Global Minimum:
% f(x*) = -d*(d+4)*(d-1)/6
%   xi* = i*(d+1-i)
%%

y = sum((x-1).^2, 1) - sum(x(2:end, :).*x(1:end-1, :), 1);

end
