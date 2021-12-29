m = 10;  n = 5;
rng(0,'twister');
A = randn(m,n);  b = randn(m,1);  g = 1.0;
cvx_begin
    variable x(n,1)
    variable z
    variable w(n,1)
    minimize( z + (g * sum(w)) )
    subject to
       z >= norm( A * x - b );
       for j=1:n
           w(j) >= norm(x(j));
       end
cvx_end