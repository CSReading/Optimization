import cvxpy as cp
import numpy as np
S = np.array([
    [2.0, 4.0, 5.0, 1.0, 3.0],
    [4.0, 2.0, 3.0, 3.0, 1.0] ])
d, r = S.shape[0], S.shape[1]
v, z = cp.Variable(d), cp.Variable(r)
obj  = cp.Minimize( cp.sum(z) )
cons = []
for l in range(0,r):
    cons += [
        z[l] >= cp.norm(v - S[:,l])
    ]
P = cp.Problem(obj, cons)
P.solve(verbose=True)
print(v.value)
