tic, clc, clear, close all, format longG
%% 这个脚本用来对比迭代次数以及方差
%% 加载函数
load_fun;
%% 
n = 100;
dim = 10;
% dims = [dim, dim, dim, dim, 1, 2, 2, 2, 2, 1, 2, dim, dim, 2,...
%     2, 4, 2, 2, 3, 2, dim, 4, 2, dim, 2, 2, 2, 5, 8, 20, 3, 6];

dims = [dim, dim, dim, 2, 2, 2, dim,...
    2, 2, 3, 2, 2, dim, 2, 2, 4];

% bds = [-5, 5; 0, pi; -dim, dim; -dim^2, dim^2; 0.5, 2.5; -3, 4; -15, 3; -10, 10; -5, 15; 0, 1; 0, 1; ...
%     -5, 10; -500, 500; -10, 10; -10, 10; -10, 10; -10, 10; -5.12, 5.12; -pi, pi; -512, 512; -10, 10;...
%     0, 4;-3, 3; -10, 10; -100, 100; -4.5, 4.5; -65.536, 65.536; 0, 1; 0, 1; -0.5, 0.5; 0, 1; 0, 1];

bds = [-5, 5; 0, pi; -dim, dim; -3, 4; -10, 10; -5, 15;...
    -500, 500; -10, 10; -5.12, 5.12; -pi, pi; -512, 512;...
    -3, 3; -10, 10; -100, 100; -4.5, 4.5; 0, 1];

minf = [-391.66599, -9.6602, 0, -1.9133, -19.2085, 0.3979, 0, 0,...
    -186.7309, -10.7409, -959.6407, -1.0316, 0, -1, 0, 0.3679];

LB = bds(:, 1);
UB = bds(:, 2);
VLB = -2;
VUB = 2;
w = [0.1, 0.9];

max_iter = 100;
%% 
fun = {f1, f2, f3, f6, f8, f9,...
    f13, f17, f18, f19, f20,...
    f23, f24, f25, f26...
    f32};

%%
var_ls = zeros(2, 16);
ite_ls = zeros(2, 16);
% ----------------------------
for ite = 1:16
    valmat1 = zeros(n, max_iter);
    valmat2 = zeros(n, max_iter);
    fprintf('搜索第%d个函数\n', ite)
    for i = 1:n
        [x1, val1, his1, iter1] = SSA(fun{ite}, dims(ite), 100, 0.2, 0.1, LB(ite), UB(ite), max_iter, 1e-6);
        [x2, val2, his2, iter2] = VSSA(fun{ite}, dims(ite), 100, 0.2, 0.1, LB(ite), UB(ite), VLB, VUB, w, max_iter, 1e-6);
        valmat1(i, :) = his1;
        valmat2(i, :) = his2;
    end
    var_ls(1, ite) = var(valmat1(:, end));
    var_ls(2, ite) = var(valmat2(:, end));
end
subplot 121
bar(var_ls')
%% 
for ite = 1:16
    ites1 = 0;
    ites2 = 0;
    fprintf('搜索第%d个函数\n', ite)
    for i = 1:n
        [x1, val1, his1, iter1] = Ite_SSA(fun{ite}, dims(ite), 100, 0.2, 0.1, LB(ite), UB(ite), max_iter, 1e-9);
        [x2, val2, his2, iter2] = Ite_VSSA(fun{ite}, dims(ite), 100, 0.2, 0.1, LB(ite), UB(ite), VLB, VUB, w, max_iter, 1e-9);
        ites1 = ites1 + iter1;
        ites2 = ites2 + iter2;
    end
    ite_ls(1, ite) = ites1 / n;
    ite_ls(2, ite) = ites2 / n;
end
subplot 122
bar(ite_ls')

%% 
tt = load('D.txt');
ANS2 = [var_ls' ite_ls'];
writematrix([tt, ANS2], 'DD.txt', 'Delimiter', 'tab')
%%
toc