function [y] = HOLDER(xx)
%% HOLDER function 
% http://www.sfu.ca/~ssurjano/holder.html
% HOLDER TABLE FUNCTION
% domain xi <- [-10, 10];
% Global minimum : 
% f(x*) = -19.2085
% four x*
%% 

x1 = xx(1, :);
x2 = xx(2, :);

fact1 = sin(x1).*cos(x2);
fact2 = exp(abs(1 - sqrt(x1.^2+x2.^2)./pi));

y = -abs(fact1.*fact2);

end
