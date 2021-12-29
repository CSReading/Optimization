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

import matplotlib.pyplot as plt
s = np.arange(c.min()-0.3, c.max()+0.3, 0.1)
t = np.asscalar(x.value[0]) * s + np.asscalar(x.value[1])
plt.plot(s, t)
plt.plot(c.T, b, 'ro')
plt.show()
