function y = MCCORMICK(xx)
%% MCCORMICK function
% http://www.sfu.ca/~ssurjano/mccorm.html
% domain x1 <- (-1.5, 4)
%        x2 <- (-3, 4)
% global minimum : -1.9133
%               x* = (-0.54719, -1.54719)
%% 
x1 = xx(1, :);
x2 = xx(2, :);

term1 = sin(x1 + x2);
term2 = (x1 - x2).^2;
term3 = -1.5*x1;
term4 = 2.5*x2;

y = term1 + term2 + term3 + term4 + 1;
end

