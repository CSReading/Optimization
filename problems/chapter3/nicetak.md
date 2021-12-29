## 3.1
>次の関数の勾配とヘッセ行列を求めよ.

### 3.1 (i) 
>$$f(\mathbf{x}) = 2x_1^3 - x_1^2x_2 + 2x_2^2$$

$$\begin{aligned}
\nabla f(\mathbf{x}) &= \begin{pmatrix}6x_1^2 -2x_1x_2 \\ -x_1^2 + 4x_2\end{pmatrix} \\
Hf(\mathbf{x}) &= \begin{pmatrix}
12x_1 - 2x_2 & -2x_1 \\
-2x_1 & 4
\end{pmatrix} 
\end{aligned}$$

### 3.1 (ii)
>$$f(\mathbf{x}) = (x_1 - 3)^2 + x_1x_2 + \frac{1}{16}x_2^4 + (x_2 - 1)^2$$

$$\begin{aligned}
\nabla f(\mathbf{x}) &= \begin{pmatrix}
2x_1 + x_2 - 6 \\
x_1 + \frac{1}{4}x_2^3 + 2x_2 - 2
\end{pmatrix} \\
Hf(\mathbf{x}) &= \begin{pmatrix}
2 & 1 \\
1 & \frac{3}{4}x_2^2 + 2
\end{pmatrix}
\end{aligned}$$

### 3.1 (iii)
>$$f(\mathbf{x}) = ||A\mathbf{x} - \mathbf{b}||_2^2 + \gamma||\mathbf{x}||_2^2$$

$$\begin{aligned}
\nabla f(\mathbf{x}) &= 2(A^TA + \gamma I) \mathbf{x} - 2A^T\mathbf{b} \\
Hf(\mathbf{x}) &= 2(A^TA + \gamma I)
\end{aligned}$$

### 3.1 (iv)
>$$f(\mathbf{x}) = \sum_{j = 1}^n \log (1 + \exp(-x_j))$$

$$\begin{aligned}
\nabla f(\mathbf{x}) &= \begin{pmatrix}
-\frac{\exp(-x_1)}{1 + \exp(-x_1)} \\
\vdots \\
-\frac{\exp(-x_n)}{1 + \exp(-x_n)}
\end{pmatrix} \\
Hf(\mathbf{x}) &= diag\left(\frac{\exp(-x_1)}{(1 + \exp(-x_1))^2}, \dots, \frac{\exp(-x_n)}{(1 + \exp(-x_n))^2}\right)
\end{aligned}$$

### 3.1 (v)
>$$f(\mathbf{x}) = \log \left(\sum_{j = 1}^n \exp(x_j) \right)$$

$$\begin{aligned}
\nabla f(\mathbf{x}) &= \frac{1}{\sum_{j = 1}^n \exp(x_j)}\begin{pmatrix}
\exp(x_1) \\
\vdots \\
\exp(x_n)
\end{pmatrix} \\
Hf(\mathbf{x}) &= diag(\nabla f(\mathbf{x})) - \nabla f(\mathbf{x}) \nabla f(\mathbf{x})^T
\end{aligned}$$
