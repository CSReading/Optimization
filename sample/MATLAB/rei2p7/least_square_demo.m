r = 20;
rng(0,'twister');
A = [randn(r,1), ones(r,1)];
b = ((10*randn)*A(:,1)) + (0.5*randn(r,1));
cvx_begin
    variable x(2,1)
    minimize( (A*x - b)' * (A*x - b) )
cvx_end
