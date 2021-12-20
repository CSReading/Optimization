m = 5;  n = 10;
rng(0,'twister');
A = randn(m,n);  b = randn(m,1);
cvx_begin
    variables x(n,1) z(n,1)
    minimize( ones(1,n) * z )
    subject to
        A * x == b;
        z >=  x;
        z >= -x;
cvx_end