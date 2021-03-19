function [y] = SANTETAl03dc(x)
%% SANTETAl03dc function
% http://www.sfu.ca/~ssurjano/
% domain x <- [0, 1]
%% 


fact1 = exp(-1.4*x);
fact2 = cos(3.5*pi*x);

y = fact1 .* fact2;

end
