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

## 3.2
>例 3.11 の設定において, 連立１次方程式 (3.32) の解と無制約最適化問題 (3.33) の
解が一致することを示せ. また, $\nabla^2f(\mathbf{x}) = A$ であることを示せ.

$f(\mathbf{x}) = \frac{1}{2}\mathbf{x}^TA\mathbf{x} - \mathbf{b}^T\mathbf{x}$
とおくと, 
$$\begin{aligned}
\nabla f(\mathbf{x}) &= A\mathbf{x} - \mathbf{b} \\
Hf(\mathbf{x}) &= A
\end{aligned}$$

$Hf(\mathbf{x}) = A$ の正定値性から, $f$ は凸関数であり, 一階条件
$$\nabla f(\mathbf{x}) = A\mathbf{x} - \mathbf{b} = 0$$
が大域最適条件である.

## 3.3
>練習問題 3.1 の (i) および (ii) の関数について,
初期点を適当に定め, 最急降下法での最初の
2反復目までを実際に計算してみよ.
また，同様に, ニュートン法での最初の
2反復目までを実際に計算してみよ.

## 3.4
>次の制約付き最適化問題に対する KKT 条件を書け.
ただし, $A \in \mathbb{R}^{m \times n}$ は定行列であり,
$\mathbf{b} \in \mathbb{R}^m$ は定ベクトルである.

### 3.4 (i)
>非負制約付き最小2乗法:
>$$\begin{aligned}
\text{Minimize }& \frac{1}{2}||A\mathbf{x} - \mathbf{b}||_2^2 \\
\text{subject to }& \mathbf{x} \ge \mathbf{0}.
\end{aligned}$$

$$\begin{aligned}
A^TA \mathbf{x} = \mathbf{b} + \mathbf{\lambda} \\
\mathbf{x}, \mathbf{\lambda} \ge \mathbf{0}, 
\mathbf{\lambda} \circ \mathbf{x} = \mathbf{0}
\end{aligned}$$

なお, $\circ$ はアダマール積を表す.

### 3.4 (ii)
>$$\begin{aligned}
\text{Minimize } & \sum_{j = 1}^n x_j \log x_j \\
\text{subect to} & \sum_{j = 1}^n x_j = 1, \\
&\mathbf{x} \ge \mathbf{0}.
\end{aligned}$$

$$\begin{aligned}
\log x_j + 1 &= \lambda_j + \mu  \text{ for } j = 1, \dots, n\\
\mathbf{x}, \mathbf{\lambda} &\ge \mathbf{0}, \\
\mathbf{\lambda} \circ \mathbf{x} &= \mathbf{0}, \\
\mathbf{1}^T \mathbf{x} &= 1
\end{aligned}$$

## 3.5
>2変数の非線形計画問題の例で, 局所最適解において1次独立制約想定が成り立たないものを作り,
その局所最適解で KKT 条件を満たすラグランジュ乗数が存在するかを調べよ.

## 3.6
>$\ell_1$ ノルム正則化付き最小2乗法
>$$\text{Minimize } \frac{1}{2}\left|\left|\sum_{j = 1}^n x_j\mathbf{a_j} - \mathbf{b}\right|\right|_2^2
>+ \gamma \sum_{j = 1}^n |x_j|$$
>に対する座標降下法の更新は
>$$x_l \leftarrow \frac{1}{||a||_2^2}\psi\left(
    \left(\mathbf{b} - \sum_{j \ne l}x_j \mathbf{a_j}\right)^T\mathbf{a_j}\right)$$
>と書けることを示せ. ただし, $\gamma$ は正の定数であり,
>$\psi(s) = \begin{cases}
s - \gamma & s > \gamma \\
0 & |s| \le \gamma \\
s + \gamma & s < -\gamma
\end{cases}$
>である.

目的関数を$f(\mathbf{x})$ として, $x_l$ に関して展開すると
$$f(x_l) = \frac{1}{2}\left|\left|\sum_{j \ne l} x_j\mathbf{a_j} - \mathbf{b}\right|\right|_2^2
+ \frac{1}{2}||\mathbf{a_l}||_2^2x_l^2
+ \left(\sum_{j \ne l} x_j \mathbf{a_j} - \mathbf{b}\right)^T \mathbf{a_l}x_l
+ \gamma \sum_{j \ne l} |x_j| + \gamma|x_l|$$
定数部分を除くと更新式は
$$x_l \leftarrow \argmin_{x_l} \frac{1}{2}||\mathbf{a_l}||_2^2x_l^2
+ \left(\sum_{j \ne l} x_j \mathbf{a_j} - \mathbf{b}\right)^T \mathbf{a_l}x_l + \gamma|x_l|$$

最適解が$x_l > 0$ にあるとすると, 一階条件から
$$x_l = \frac{1}{||\mathbf{a_l}||_2^2}\left(\left(\mathbf{b} - \sum_{j \ne l} x_j \mathbf{a_j}\right)^T\mathbf{a_j} - \gamma\right)$$
なお, これが$x_l > 0$ に存在する場合は, $\left(\mathbf{b} - \sum_{j \ne l} x_j \mathbf{a_j}\right)^T\mathbf{a_j} > \gamma$ を満たす.
同様に, $\left(\mathbf{b} - \sum_{j \ne l} x_j \mathbf{a_j}\right)^T\mathbf{a_j} < - \gamma$ の時, 
$$x_l = \frac{1}{||\mathbf{a_l}||_2^2}\left(\left(\mathbf{b} - \sum_{j \ne l} x_j \mathbf{a_j}\right)^T\mathbf{a_j} + \gamma\right)$$
が最適解となる.
いずれの条件も満たさない場合は, 自明に端点の$x_l = 0$ が解である.
