function [X, Y, Z] = plot_this(lb, ub, step, fun)
%% plot 3d fig
[X, Y] = meshgrid(lb:step:ub);
%% 
XX = reshape(X, 1, []);
YY = reshape(Y, 1, []);
fx = [XX; YY];
[m, n] = size(X);
%%
Z = fun(fx);
Z = reshape(Z, [m, n]);
end
