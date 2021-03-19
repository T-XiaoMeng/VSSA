tic, clc, clear, close all, format longG
%% 这是最原始的主程序，计算了所有函数
f1 = @StyblinskiTang;
f2 = @Michalewicz;
f3 = @Perm;
f4 = @Trid;
f5 = @GRAMACY;
f6 = @MCCORMICK;
f7 = @BUKIN;
f8 = @HOLDER;
f9 = @BRANIN;
f10 = @SANTETAl03dc;
f11 = @CHSAN10;
f12 = @ROSEN;
f13 = @paper8;
f14 = @crossit;
f15 = @levy13;
f16 = @colville;
f17 = @booth;
f18 = @shubert;
f19 = @ishigami;
f20 = @egg;
f21 = @levy;
f22 = @powersum;
f23 = @camel6;
f24 = @dixonpr;
f25 = @easom;
f26 = @beale;
f27 = @dejong5;
f28 = @fried;
f29 = @detpep108d;
f30 = @welchetal92;
f31 = @detpep10exp;
f32 = @grlee09;
%% SSA & VSSA
%%
n = 50;
dim = 10;
dims = [dim, dim, dim, dim, 1, 2, 2, 2, 2, 1, 2, dim, dim, 2,...
    2, 4, 2, 2, 3, 2, dim, 4, 2, dim, 2, 2, 2, 5, 8, 20, 3, 6];

bds = [-5, 5; 0, pi; -dim, dim; -dim^2, dim^2; 0.5, 2.5; -3, 4; -15, 3; -10, 10; -5, 15; 0, 1; 0, 1; ...
    -5, 10; -500, 500; -10, 10; -10, 10; -10, 10; -10, 10; -5.12, 5.12; -pi, pi; -512, 512; -10, 10;...
    0, 4;-3, 3; -10, 10; -100, 100; -4.5, 4.5; -65.536, 65.536; 0, 1; 0, 1; -0.5, 0.5; 0, 1; 0, 1];

LB = bds(:, 1);
UB = bds(:, 2);
VLB = -2;
VUB = 2;
w = [0.1, 0.9];

max_iter = 100;
%% 
fun = {f1, f2, f3, f4, f5, f6, f7, f8, f9, f10,...
    f11, f12, f13, f14, f15, f16, f17, f18, f19, f20,...
    f21, f22, f23, f24, f25, f26, f27, f28, f29, f30...
    f31, f32};


%%
for ite = 1:32
    valmat1 = zeros(n, max_iter);
    valmat2 = zeros(n, max_iter);
    fprintf('搜索第%d个函数\n', ite)
for i = 1:n
    [x1, val1, his1, iter1] = SSA(fun{ite}, dims(ite), 100, 0.2, 0.1, LB(ite), UB(ite), max_iter, 1e-6);
    [x2, val2, his2, iter2] = VSSA(fun{ite}, dims(ite), 100, 0.2, 0.1, LB(ite), UB(ite), VLB, VUB, w, max_iter, 1e-6);
    
%     if mod(i, 5) == 0
%         disp(i)
%     end
    
%     v1(i) = val1;
%     v2(i) = val2;
    
    valmat1(i, :) = his1;
    valmat2(i, :) = his2;
end

% plot(1:length(his1), his1, 'r-', 1:length(his2), his2, 'b-')
% figure
% xx = 1:n;
% plot(xx, v1, 'ro-', xx, v2, 'gx-', xx, repmat(mean(v1), 1, n), 'r--', xx, repmat(mean(v2), 1, n), 'g--')
% legend('原始算法', '改进的算法')
% xlabel('第x次试验')
% ylabel('最小值')
% figure
% plot(xx, it1, 'ro-', xx, it2, 'gx-')

% figure
subplot(4, 8, ite)
plot(1:max_iter, mean(valmat1), 'r.--', 1:max_iter, mean(valmat2), 'g.--')
title(['f^{', num2str(ite), '}'])

end
%% 
% times = 7;
% saveas(gcf, ['0', num2str(times), '.png'])
%%
toc