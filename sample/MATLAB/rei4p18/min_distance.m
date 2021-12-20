mat_data = [2 4 5 1 3; 4 2 3 3 1];
d = size(mat_data,1);  r = size(mat_data,2);
cvx_begin
    variable v(d,1)
    variable z(r,1)
    minimize( sum(z) )
    subject to
        for l=1:r
            z(l) >= norm(v - mat_data(:,l));
        end
cvx_end