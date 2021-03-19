tic, clc, clear, close all, format longG
%% 这个主程序用来绘制3D图形
%% 加载函数
load_fun;
%% 绘制图形
funs = {f1, f2, f3, f6, f8, f9, f13, f17, f18, f20, f23, f24, f25, f26};
bd = [-5, 5; 0, pi; -2, 2; -3, 4; -10, 10; -5, 15; -500, 500; -10, 10; -10, 10; -512, 512; -3, 3; -10, 10; -100, 100; -4.5, 4.5];
step = [0.05, 0.02, 0.02, 0.02, 0.05, 0.05, 1, 0.05, 0.05, 1, 0.02, 0.05, 0.5, 0.02]*5;
lb = bd(:, 1);
ub = bd(:, 2);
funstr = {'f1', 'f2', 'f3', 'f6', 'f8', 'f9', 'f13', 'f17', 'f18', 'f20', 'f23', 'f24', 'f25', 'f26'};
%% 
for i = 1:14
    [X, Y, Z] = plot_this(lb(i), ub(i), step(i), funs{i});
    subplot(3, 5, i)
%     figure
    mesh(X, Y, Z)
    colormap(jet)
    title(funstr(i))
    fprintf('正在绘制第%d个函数\n', i)
end
% saveas(gcf, 'fun3d.bmp')
%% 
