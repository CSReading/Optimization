c = [20; 60];
G = [5 4; 2 4; 2 8];
h = [80; 40; 64];
cvx_begin
    variable x(2,1)
    maximize( c' * x )
    subject to
        G * x <= h;
        x >= 0;
cvx_end