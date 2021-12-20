r = 20;
rng(0,'twister');
A = [randn(r,1), ones(r,1)];
b = ((10*randn)*A(:,1)) + (0.5*randn(r,1));
cvx_begin
    variable x(2,1)
    minimize( (A*x - b)' * (A*x - b) )
cvx_end

figure;
set(gcf,'defaultAxesFontSize',18);
set(gcf,'defaultAxesFontName','Times New Roman');
plot([min(A(:,1))-0.3, max(A(:,1))+0.3],...
    [x(1)*(min(A(:,1))-0.3)+x(2), x(1)*(max(A(:,1))+0.3)+x(2)],...
    'k-', 'LineWidth', 1);
hold on;
plot(A(:,1), b, 'bo', 'LineWidth',1, 'MarkerSize',8);
xlim([min(A(:,1))-0.3, max(A(:,1))+0.3]);
xlabel('$s$', 'Interpreter', 'latex');
ylabel('$t$', 'Interpreter', 'latex');
