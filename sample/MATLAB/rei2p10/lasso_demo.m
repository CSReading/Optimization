m = 10;  n = 5;  gam = 10^2;
rng(0,'twister');
A = randn(m,n);  b = 100 * randn(m,1);
cvx_begin
    variables x(n,1) z(n,1)
    minimize( ((A*x-b)' * (A*x-b)) + (gam * ones(n,1)' * z) )
    subject to
        z >=  x;
        z >= -x
cvx_end