tic, clc, clear, close all, format longG
%% 这个主程序用于绘制16个图形的迭代过程
f1 = @StyblinskiTang;
f2 = @Michalewicz;
f3 = @Perm;
% f4 = @Trid;
% f5 = @GRAMACY;
f6 = @MCCORMICK;
% f7 = @BUKIN;
f8 = @HOLDER;
f9 = @BRANIN;
% f10 = @SANTETAl03dc;
% f11 = @CHSAN10;
% f12 = @ROSEN;
f13 = @paper8;
% f14 = @crossit;
% f15 = @levy13;
% f16 = @colville;
f17 = @booth;
f18 = @shubert;
f19 = @ishigami;
f20 = @egg;
% f21 = @levy;
% f22 = @powersum;
f23 = @camel6;
f24 = @dixonpr;
f25 = @easom;
f26 = @beale;
% f27 = @dejong5;
% f28 = @fried;
% f29 = @detpep108d;
% f30 = @welchetal92;
% f31 = @detpep10exp;
f32 = @grlee09;
%% SSA & VSSA
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

err = zeros(2, 16);
%%
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
y1 = mean(valmat1);
y2 = mean(valmat2);
err(1, ite) = y1(end);
err(2, ite) = y2(end);

subplot(4, 4, ite)
plot(1:max_iter, y1, 'r.--', 1:max_iter, y2, 'g.--')
hold on
plot(1:max_iter, repmat(minf(ite), 1, max_iter), 'b-')
legend('SSA', 'VSSA', 'Real-Val')
grid on
title(['f^{', num2str(ite), '}'])

end
%% 绘制精确度对比图
% figure
% for i = 1:16
%     subplot(4, 4, i)
% %     bar([err(:, i)'; [0 0]], 'stacked')
%     c = categorical({'SSA','VSSA','REAL'});
%     prices = [err(1, i), err(2, i), minf(i)];
%     bar(c, prices)
%     title('error')
%     colormap(cool)
% end

%% 
% times = 7;
% saveas(gcf, ['0', num2str(times), '.png'])
% ANS = [err', minf'];
% writematrix(ANS, 'ANS.txt', 'Delimiter', 'tab')
% D = [err', minf']
% writematrix(D, 'D.txt', 'Delimiter', 'tab')
%%
toc