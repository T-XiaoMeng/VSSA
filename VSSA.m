function [bestx, val, his, iter] = VSSA(fun, dim, par_num, prop_pt, prop_pd, lb, ub, vlb, vub, w, max_iter, eps)
%% 优化的SSA算法

%%
x = unifrnd(lb(1), ub(1), dim, par_num);
fx = fun(x);
[~, id] = sort(fx);
x = x(:, id);
pt_num = ceil(prop_pt*par_num);
pd_num = ceil(prop_pd*par_num);
his(1) = min(fx);
%% init v
v = unifrnd(vlb, vub, dim, par_num);
p_best = x;
w1 = w(1);
w2 = w(2);
%%
%% 
for i = 2:max_iter
    x_w = x(:, end);
    x_p = x(:, 1);
    % 更新生产者
    for j = 1:pt_num
        
        new_w = w2 - (w1-w2)/((i+pt_num) / max_iter);
        v(:, j) = new_w * v(:, j) +  rand .* ((p_best(:, j)-x(:, j))) + rand .* ((x_p - x(:, j)));
%         v(:, j) = new_w * v(:, j) +  randn .* abs((p_best(:, j)-x(:, j))) + randn .* abs((x_p - x(:, j)));
        tmpv = v(:, j);
        tmpv(tmpv<vlb(1)) = vlb(1);
        tmpv(tmpv>vub(1)) = vub(1);
        v(:, j) = tmpv;
        
        tmpx = x(:, j);
        x(:, j) = x(:, j) + v(:, j);
        tmpx2 = x(:, j);
        tmpx2(tmpx2<lb(1)) = lb(1);
        tmpx2(tmpx2>ub(1)) = ub(1);
        x(:, j) = tmpx2;
        if fun(x(:, j)) > fun(tmpx)
            x(:, j) = tmpx;
        else
            p_best(:, j) = tmpx;
        end
    end
    % 更新跟随者
    
    for j = pt_num+1:par_num
        A = randi(2, 1, dim);
        A(A==2) = -1;
        Ap = A'*inv(A*A');
        Q = randn;
        tmpx = x(:, j);
        if j > par_num/2
%               x(:, j) = Q * exp((x_w - x(:, j)) / (i^2));
              x(:, j) = Q * ((x_w - x(:, j)));
%               x(:, j) = x(:, j) + randn * ((-x_w + x(:, j)));
        else
            tp = x_p' + abs(x(:, j)' - x_p') * Ap * ones(1, dim);
            x(:, j) = tp;
        end
        tmpx2 = x(:, j);
        tmpx2(tmpx2<lb(1)) = lb(1);
        tmpx2(tmpx2>ub(1)) = ub(1);
        x(:, j) = tmpx2;
        if fun(x(:, j)) > fun(tmpx)
            x(:, j) = tmpx;
        end
    end
    % 更新察觉危险者
    fx = fun(x);
    rnd = randperm(par_num);
    fg = min(fx);
    fw = max(fx);
    for j = 1:pd_num
        beta = randn;
        K = rand;
        tmpx = x(:, rnd(j));
        if fx(rnd(j)) > fg
            x(:, rnd(j)) = x_p + beta * abs(x(:, rnd(j)) - x_p);
        elseif fx(rnd(j)) == fg
%             x(:, rnd(j)) = x(:, rnd(j)) + K * ((abs(x(:, rnd(j)))-x_w) / ((fx(rnd(j))-fw)+eps));
%             x(:, rnd(j)) = x(:, rnd(j)) + beta * ((abs(x(:, rnd(j)))-x_w));
              x(:, rnd(j)) = x(:, rnd(j)) + beta;
        else
            continue;
        end
        tmpx2 = x(:, rnd(j));
        tmpx2(tmpx2<lb(1)) = lb(1);
        tmpx2(tmpx2>ub(1)) = ub(1);
        x(:, rnd(j)) = tmpx2;
        if fun(x(:, j)) > fun(tmpx)
            x(:, j) = tmpx;
        end
    end
    % 停止条件
    fx = fun(x);
    his(i) = min(fx);
    val = his(i);
    bestx = x(:, 1);
%     if abs(his(i) - his(i-1)) < eps
%        break
%     end
    [~, id] = sort(fx);
    x = x(:, id);
end
iter = i;

end

