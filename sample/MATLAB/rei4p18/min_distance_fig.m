mat_data = [2 4 5 1 3; 4 2 3 3 1];
cvx_begin
    variable var_x(2,1)
    variable var_z(5,1)
    minimize( sum(var_z) )
    subject to
    for l=1:r
        var_z(l) >= norm(var_x - mat_data(:,l));
    end
cvx_end

figure;
set(gcf,'defaultAxesFontSize',14);
set(gcf,'defaultAxesFontName','times');
plot(mat_data(1,:), mat_data(2,:), 'rx', 'MarkerSize', 8);
hold on;
plot(var_x(1), var_x(2), 'bo', 'MarkerSize', 8);
axis equal;
axis([min(mat_data(1,:))-1, max(mat_data(1,:))+1,...
    min(mat_data(2,:))-1, max(mat_data(2,:))+1]);
