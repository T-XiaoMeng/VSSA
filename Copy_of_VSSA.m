function [bestx, val, his] = VSSA(fun, dim, par_num, prop_pt, prop_pd, lb, ub, vlb, vub, w, max_iter, eps)
%% SSA 算法
x = unifrnd(lb(1), ub(1), par_num, dim);
fx = fun(x');
[~, id] = sort(fx);
x = x(id, :);
pt_num = ceil(prop_pt*par_num);
pd_num = ceil(prop_pd*par_num);
his(1) = min(fx);
%% 
v = unifrnd(vlb, vub, par_num, dim);
p_best = x;
w1 = w(1);
w2 = w(2);

% f13 = @(x) -abs(sin(x(1)).*cos(x(2)).*exp(abs(1-(sqrt(x(1).^2 + x(2).^2))./pi)));

%% 
for i = 2:max_iter
     x_w = x(end, :);
     x_p = x(1, :);
    % 更新生产者
   for j = 1:pt_num
       new_w = w2 - (w1-w2)/((i+pt_num) / max_iter);
       v(j, :) = new_w * v(j, :) +  randn .* abs((p_best(j, :)-x(j, :))) + randn .* abs((x_p - x(j, :)));
       
%        if j == 1 & i < 200
%        randn(1, dim) .* abs((p_best(j, :)-x(j, :))) + randn(1, dim) .* abs((x_p - x(j, :)))
%        end
       
        tempxv = v(j, :);
        tempxv(tempxv<lb(1)) = lb(1);
        tempxv(tempxv>ub(1)) = ub(1);
        v(j, :) = tempxv;
       
       x(j, :) = x(j, :) + v(j, :);
       
       tempx2 = x(j, :);
        tempx2(tempx2<lb(1)) = lb(1);
        tempx2(tempx2>ub(1)) = ub(1);
        x(j, :) = tempx2;
        

        
       if fun(x(j, :)) < fun(p_best(j, :))
           p_best(j, :) = x(j, :);
       end
   end
   % 更新更随者
   x_w = x(end, :);
   x_p = x(1, :);
   for j = pt_num+1:par_num
       A = randi(2, 1, dim);
       A(A==2) = -1;
       Ap = A'*inv(A*A');
       Q = randn;
       tempx = x(j, :);
       if j > par_num/2
           x(j, :) = Q * exp((x_w-x(j, :)) / (i*i));
       else
           x(j, :) = x_p + abs(x(j, :) - x_p)*Ap*ones(1, dim);
       end
       
       tempx2 = x(j, :);
        tempx2(tempx2<lb(1)) = lb(1);
        tempx2(tempx2>ub(1)) = ub(1);
        x(j, :) = tempx2;
        
       if fun(x(j, :)) > fun(tempx)
           x(j, :) = tempx;
       end
   end
   % 更新察觉危险者
   rnd = randperm(par_num);
   fg = min(fx);
   fw = max(fx);
   for j = 1:pd_num
       beta = randn;
       K = rand;
       tempx = x(rnd(j), :);
       if fx(rnd(j)) > fg
           x(rnd(j), :) = x_p + beta*abs(x(rnd(j), :)-x_p);
       elseif fx(rnd(j)) == fg
           x(rnd(j), :) = x(rnd(j), :) + K*((abs(x(rnd(j), :))-x_w) / ((fx(rnd(j))-fw)+eps));
       else
           continue;
       end
       
       tempx2 = x(rnd(j), :);
        tempx2(tempx2<lb(1)) = lb(1);
        tempx2(tempx2>ub(1)) = ub(1);
        x(rnd(j), :) = tempx2;
        
       if fun(x(rnd(j), :)) > fun(tempx)
           x(rnd(j), :) = tempx;
       end

   end
   % 停止条件
   fx = fun(x');
   if his(i-1) < min(fx)
       his(i) = his(i-1);
   else
     his(i) = min(fx);
   end
   val = his(i);
   bestx = x(1, :);
%    if abs(his(i) - his(i-1)) < eps
%        break
%    end
   [~, id] = sort(fx);
   x = x(id, :);
end

end





