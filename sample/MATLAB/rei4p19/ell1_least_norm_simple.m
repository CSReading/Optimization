m = 10;  n = 5;
rng(0,'twister');
A = randn(m,n);  b = randn(m,1);
g = 1.0;
cvx_begin
    variable x(n,1)
    minimize( norm(A * x - b) + (g * norm(x,1)) )
cvx_end