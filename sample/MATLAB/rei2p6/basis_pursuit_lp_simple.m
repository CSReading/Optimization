m = 5;  n = 10;
rng(0,'twister');
A = randn(m,n);  b = randn(m,1);
cvx_begin
    variables x(n,1)
    minimize( norm(x, 1) )
    subject to
        A * x == b;
cvx_end