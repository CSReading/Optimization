import cvxpy as cp
import numpy as np
r = 20
np.random.seed(1)
A = np.hstack((np.random.randn(r,1), np.ones([r,1])))
c = A[:,0]
b = (10.0*np.random.randn() * c) + \
        + (0.5*np.random.randn(r))
x    = cp.Variable(2)
obj  = cp.Minimize( cp.sum_squares(A @ x - b) )
P = cp.Problem(obj)
P.solve(verbose=True)
print(x.value)
