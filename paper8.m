function y = paper8(x)
%% paper's 8th function
% http://www.sfu.ca/~ssurjano/schwef.html
% domain x <- [-500, 500]
% global miinmum: 0
%% 
[d, ~] = size(x);
y = 418.9829*d + sum(-x .* sin(sqrt(abs(x))), 1);
end

