function [y] = CHSAN10(xx)
%% chsan10
% domain x <- [0, 1]
%% 

x1 = xx(1, :);
x2 = xx(2, :);

fact1 = cos(x1 + x2);
fact2 = exp(x1.*x2);

y = fact1 .* fact2;

end
