function y = Perm(xx)
%% Perm function
% http://www.sfu.ca/~ssurjano/perm0db.html
% domain xi <- (-dim, dim)
% Global Minimum : 0
% x* = (1, 1/2, 1/3, ..., 1/dim)
%%
if (nargin == 1)
    b = 10;
end

% d = length(xx);
[d, ~] = size(xx);
outer = 0;

for ii = 1:d
	inner = 0;
	for jj = 1:d
		xj = xx(jj, :);
        inner = inner + (jj+b)*(xj.^ii-(1./jj).^ii);
	end
	outer = outer + inner.^2;
end

y = outer;

end
%% 

