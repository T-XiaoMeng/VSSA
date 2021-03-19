function [bestx, val, his, iter] = SSA(fun, dim, par_num, prop_pt, prop_pd, lb, ub, max_iter, eps)
%% 原始的SSA算法

%%
x = unifrnd(lb(1), ub(1), dim, par_num);
fx = fun(x);
[~, id] = sort(fx);
x = x(:, id);
pt_num = ceil(prop_pt*par_num);
pd_num = ceil(prop_pd*par_num);
his(1) = min(fx);
%% 
for i = 2:max_iter
    % 更新生产者
    for j = 1:pt_num
        R2 = rand;
        ST = 0.5 * rand/2;
        alpha = rand + 1e-9;
        Q = randn;
        tmpx = x(:, j);
        if R2 < ST
            x(:, j) = x(:, j) * exp(-i / (alpha*max_iter));
        else
            x(:, j) = x(:, j) + Q;
        end
        tmpx2 = x(:, j);
        tmpx2(tmpx2<lb(1)) = lb(1);
        tmpx2(tmpx2>ub(1)) = ub(1);
        x(:, j) = tmpx2;
        if fun(x(:, j)) > fun(tmpx)
            x(:, j) = tmpx;
        end
    end
    % 更新跟随者
    x_w = x(:, end);
    x_p = x(:, 1);
    for j = pt_num+1:par_num
        A = randi(2, 1, dim);
        A(A==2) = -1;
        Ap = A'*inv(A*A');
        Q = randn;
        tmpx = x(:, j);
        if j > par_num/2
            x(:, j) = Q * exp((x_w - x(:, j)) / (j^2));
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
        K = -1 + 2*rand;
        tmpx = x(:, rnd(j));
        if fx(rnd(j)) > fg
            x(:, rnd(j)) = x_p + beta * abs(x(:, rnd(j)) - x_p);
        elseif fx(rnd(j)) == fg
            x(:, rnd(j)) = x(:, rnd(j)) + K * ((abs(x(:, rnd(j)))-x_w) / ((fx(rnd(j))-fw)+eps));
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

