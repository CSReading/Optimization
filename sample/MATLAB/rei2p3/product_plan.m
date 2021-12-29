cvx_begin
    variables x1 x2
    maximize( 20*x1 + 60*x2 )
    subject to
        5*x1 + 4*x2 <= 80;
        2*x1 + 4*x2 <= 40;
        2*x1 + 8*x2 <= 64;
        x1 >= 0;
        x2 >= 0;
cvx_end