clear;
close all;

d = 2;  m = 10;
S = [...
    -2.05, -1.20, -1.05, -0.82, -0.27, -0.27,  0.03, 0.50, 0.82, 1.12;
    -0.35,  2.90, -0.46, -1.57,  0.70,  1.09, -1.33, 0.28, 1.37, 0.35];
t = [1, -1, 1, 1, -1, -1, 1, -1, -1, 1];
cvx_begin
    variable w(d,1)
    variable v
    minimize( sum_log(1 + exp(-diag(t) * (S'*w + v))) )
cvx_end

figure;
hold on;
for i=1:m
    if t(i) > 0
        plot(S(1,i), S(2,i), 'bo');
    else
        plot(S(1,i), S(2,i), 'rx');
    end
end
s1_min = min(S(1,:)) - 0.5;
s1_max = max(S(1,:)) + 0.5;
s2_min = -(v + (s1_min * w(1))) / w(2);
s2_max = -(v + (s2_min * w(1))) / w(2);
plot([s1_min, s1_max], [s2_min, s2_max], 'k-');
