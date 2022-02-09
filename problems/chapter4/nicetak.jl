### A Pluto.jl notebook ###
# v0.17.7

using Markdown
using InteractiveUtils

# ╔═╡ 923dabf6-695b-11ec-029f-094a80e5df01
md"""
# Chapter 4
#### Nicetak
 $(import Dates; Dates.format(Dates.today(), Dates.DateFormat("U d, Y")))
"""

# ╔═╡ ed4149d5-bf42-4b6e-a9ff-d0b8df5333db
md"""
## 4.1
>第 3 章の練習問題 3.1 で考えた関数について, それぞれが凸関数であるか否かを調べよ.
"""

# ╔═╡ f5dfb3aa-a3fd-4001-9a57-fe0c82cbf383
md"""
### 4.1 (i)
> ```math
> f(\mathbf{x}) = 2x_1^3 - x_1^2x_2 + 2x_2^2
>```
"""

# ╔═╡ e0a7c3f8-5fb7-49eb-92b9-12e83ca4a522
md"""
```math
Hf(\mathbf{x}) = \begin{pmatrix}
12x_1 - 2x_2 & -2x_1 \\
-2x_1 & 4
\end{pmatrix}
```
であり, ``\mathbf{x} = (0, 1)^T`` において, 固有値は明らかに ``\lambda = -2, 4`` であるから半正定値ではない. よって, 凸関数ではない.
"""

# ╔═╡ 2a2c3982-1a15-40c0-b678-fd619f71e33e
md"""
### 4.1 (ii)
>```math
>f(\mathbf{x}) = (x_1 - 3)^2 + x_1x_2 + \frac{1}{16}x_2^4 + (x_2 - 1)^2
>```
"""

# ╔═╡ 83d86a71-55e8-485a-b589-78f79dccf0bd
md"""
```math
Hf(\mathbf{x}) = \begin{pmatrix}
2 & 1 \\
1 & \frac{3}{4}x_2^2 + 2
\end{pmatrix}
```
このヘッセ行列の固有値は, 
```math
\lambda = \frac{3}{8}x_2^2 + 2 \pm \sqrt{\frac{9}{64}x_2^4 + 1} > 0
```
より, 凸関数.
"""

# ╔═╡ 6e40cf5d-f4d0-40e2-aa8e-f743ec430cd0
md"""
### 4.1 (iii)
>$$f(\mathbf{x}) = ||A\mathbf{x} - \mathbf{b}||_2^2 + \gamma||\mathbf{x}||_2^2$$
"""

# ╔═╡ f199ed65-286d-46e5-8e85-d56dd12d3a7f
md"""
ヘッセ行列, ``Hf(\mathbf{x}) = 2(A^TA + \gamma I)`` は明らかに正定値行列である. なぜなら,
- ``A^TA`` は半正定値行列 (``\mathbf{u}^TA^TA\mathbf{u} = ||A\mathbf{u}||_2^2 \ge 0``)
- ``I`` は正定値行列 (``\mathbf{u}^T I \mathbf{u} = ||\mathbf{u}||_2^2 > 0``)

よって凸関数.
"""

# ╔═╡ 633d42a9-1fc7-447e-9e5d-5c831adc5d37
md"""
### 4.1 (iv)
>$$f(\mathbf{x}) = \sum_{j = 1}^n \log (1 + \exp(-x_j))$$
"""

# ╔═╡ 9665855b-0444-4f2b-8509-1f2d4a560b33
md"""
```math
Hf(\mathbf{x}) = diag\left(\frac{\exp(-x_1)}{(1 + \exp(-x_1))^2}, \dots, \frac{\exp(-x_n)}{(1 + \exp(-x_n))^2}\right)
```
ヘッセ行列は明らかに正定値行列である. なぜなら, 任意の非零ベクトル ``\mathbf{u}`` に対して,
```math
\mathbf{u}^T Hf(\mathbf{x}) \mathbf{u} = \sum_{j = 1}^n \frac{\exp(-x_j)}{(1 + \exp(-x_j))^2} u_j^2 > 0
```

よって, 凸関数.
"""

# ╔═╡ 1d1f83cc-9bd2-44fe-9f23-e7e2b9d73534
md"""
### 4.1 (v)
>$$f(\mathbf{x}) = \log \left(\sum_{j = 1}^n \exp(x_j) \right)$$
"""

# ╔═╡ 944b9ecb-25be-43c1-81d3-70afbadde590
md"""
```math
\begin{aligned}
\nabla f(\mathbf{x}) &= \frac{1}{\sum_{j = 1}^n \exp(x_j)}\begin{pmatrix}
\exp(x_1) \\
\vdots \\
\exp(x_n)
\end{pmatrix} \\
Hf(\mathbf{x}) &= diag(\nabla f(\mathbf{x})) - \nabla f(\mathbf{x}) \nabla f(\mathbf{x})^T
\end{aligned}
```

任意の非零ベクトル ``\mathbf{u}`` に対して,
```math
\begin{aligned}
\mathbf{u}^T Hf(\mathbf{x}) \mathbf{u}
&= \mathbf{u}^T diag(\nabla f(\mathbf{x})) \mathbf{u} 
- \mathbf{u}^T \nabla f(\mathbf{x}) \nabla f(\mathbf{x})^T\mathbf{u} \\
&= \sum_{j = 1}^n f_j u_j^2 - \left(\sum_{j = 1}^n f_j u_j^2\right)^2 \\
&= \left(\sum_{j = 1}^n f_j \right) \left(\sum_{j = 1}^n f_j u_j^2\right)
- \left(\sum_{j = 1}^n f_j u_j^2\right)^2 \\
& \ge 0 
\end{aligned}
```
なお, 最後の不等式はコーシーシュワルツの不等式から (``f_j \ge 0``.)
また, 途中で``\sum_{j = 1}^n f_j = 1`` を利用した.
"""

# ╔═╡ 4bcb77e0-c28c-4391-aed7-486235a91410
md"""
## 4.2
>次の関数が凸関数であることを示せ. ただし, ``c`` は正の定数とする.
"""

# ╔═╡ 6bb0713f-13e7-49ba-ab5c-3e73c95c68b9
md"""
### 4.2 (i)
> ヒンジ関数 ``f(x) = \max\{c - x, 0\}``
"""

# ╔═╡ 03484244-1972-47d8-856b-d238a534b43f
md"""
任意の ``x, x' \in \mathbb{R}`` と任意の ``\lambda \in [0, 1]`` に対して,
```math
\begin{aligned}
f(\lambda x + (1 - \lambda)x') =& \max\{c - \lambda x - (1 - \lambda) x'\} \\
=& \max\{\lambda(c - x) + (1 - \lambda)(c - x')\} \\
\le& \max\{\lambda(c - x), 0\} + \max\{(1 - \lambda)(c - x'), 0\} \\
&= \lambda\max\{c - x, 0\} + (1 - \lambda)\max\{c - x', 0\} \\
&= \lambda f(x) + (1 - \lambda)f(x')
\end{aligned}
```
"""

# ╔═╡ 20287435-7dec-4004-95c7-3b8135c9ebcc
md"""
### 4.2 (ii)
>指数損失関数 ``f(x) = e^{-cx}``

``f''(x) = c^2e^{-cx} > 0`` より凸関数.
"""

# ╔═╡ 11044e74-0166-471a-985f-6200ea04d76e
md"""
## 4.3
>次の最適化問題を2次錐計画問題 (4.7) の形に直せ. ただし, ``\gamma`` は正の定数とする.
"""

# ╔═╡ 3976a2c2-7c14-4eb7-a60e-d499310a6d92
md"""
### 4.3 (i)
> ``\ell_1`` ノルム正則化付き最小2乗法 (LASSO)
> ```math
> \text{Minimize } ||A\mathbf{x} - \mathbf{b}||_2^2 + \gamma||\mathbf{x}||_1.
>```
"""

# ╔═╡ 9a16fed6-453e-4d12-830a-f6a1cae2e2e7
md"""
前章の内容を踏まえると, 目的関数のうち ``\gamma||\mathbf{x}||_1`` の項は容易に
```math
\begin{aligned}
\text{Minimize }& \gamma \mathbf{1}^T \mathbf{z} \\
\text{subject to }& \mathbf{x} + \mathbf{z} \ge \mathbf{0} \\
& \mathbf{x} - \mathbf{z} \ge \mathbf{0}
\end{aligned}
```
と変換できる. ``||A\mathbf{x} - \mathbf{b}||_2^2`` の項は, 目的関数を ``y`` とおき, 制約条件 ``y \ge ||A\mathbf{x} - \mathbf{b}||_2^2`` を 2次錐の形に直せば良い.

```math
\begin{aligned}
y \ge& ||A\mathbf{x} - \mathbf{b}||_2^2 \\
\Leftrightarrow (y + 1)^2 \ge& (y - 1)^2 + 4||A\mathbf{x} - \mathbf{b}||_2^2 \\
& = \left|\left|\begin{pmatrix} y - 1 \\ 2(A\mathbf{x} - \mathbf{b}) \end{pmatrix}\right|\right|_2^2 \\
\therefore y + 1 \ge& \left|\left|\begin{pmatrix} y - 1 \\ 2(A\mathbf{x} - \mathbf{b}) \end{pmatrix}\right|\right|_2
\end{aligned}
```

故に, 
```math
\begin{aligned}
\text{Minimize }& y + \gamma \mathbf{1}^T \mathbf{z} \\
\text{subject to }&
y + 1 \ge \left|\left|\begin{pmatrix} y - 1 \\ 2(A\mathbf{x} - \mathbf{b}) \end{pmatrix}\right|\right|_2 \\
& \mathbf{x} + \mathbf{z} \ge \mathbf{0} \\
& \mathbf{x} - \mathbf{z} \ge \mathbf{0}
\end{aligned}
```
"""

# ╔═╡ de88efd1-f5d0-4c25-8380-024ec76e1106
md"""
### 4.3 (ii)
> ``\ell_2`` ノルム正則化付き ``\ell_1`` ノルム回帰
> ```math
> \text{Minimize } ||A\mathbf{x} - \mathbf{b}||_1 + \gamma||\mathbf{x}||_2.
>```
"""

# ╔═╡ 6751f89f-114c-4c61-ad55-b5d4dd6982f8
md"""
``\ell_1`` ノルムに関しては前問と同様に変換すればよく, ``\ell_2`` ノルムは変換の必要がない.
```math
\begin{aligned}
\text{Minimize }& \mathbf{1}^T\mathbf{y} + \gamma z \\
\text{subject to }& \mathbf{y} + A\mathbf{x} - \mathbf{b} \ge \mathbf{0} \\
& \mathbf{y} - A\mathbf{x} + \mathbf{b} \ge \mathbf{0} \\
& z \ge ||\mathbf{x}||_2
\end{aligned}
```
"""

# ╔═╡ 4c0e127c-e608-4395-9aed-f2034038ed0e
md"""
### 4.3 (iii)
> 変数 ``\mathbf{x}_l \in \mathbb{R}^{n_l} (l = 1, \dots, r)`` に関する最適問題
> ```math
> \text{Minimize } \frac{1}{2}\left|\left|\sum_{l = 1}^r A_l\mathbf{x}_l - \mathbf{b}\right|\right|_2^2 + \gamma\sum_{l = 1}^r ||\mathbf{x}_l||_2.
>```
"""

# ╔═╡ 03c4d2bf-f61c-4478-adc8-1626dca5a5f6
md"""
```math
\begin{aligned}
\text{Minimize }& \frac{1}{2}y + \gamma \sum_{l = 1}^r z_l \\
\text{subject to }&
y + 1 \ge \left|\left|\begin{pmatrix} y - 1 \\ 2\left(\sum_{l = 1}^r A_l\mathbf{x}_l - \mathbf{b}\right) \end{pmatrix}\right|\right|_2 \\
& z_l \ge ||\mathbf{x}_l||_2 \,\,\text{ for } l = 1, \dots, r
\end{aligned}
```
"""

# ╔═╡ e3ebbd1c-6279-4a69-972e-1f2aa2bd974c
md"""
## 4.4
>次の問に答えよ.
"""

# ╔═╡ f4c2f661-c354-4d67-a821-63b46758ee99
md"""
### 4.4 (i)
>関数 ``h(\mathbf{x}) = ||\mathbf{x}||_2`` の近接作用素 ``\textbf{prox}_h`` を求めよ.
"""

# ╔═╡ 1ca24fe3-482a-4168-a537-02c263bfa753
md"""
``\textbf{prox}_h``を求めるための目的関数を``f(\mathbf{z})``として
```math
\begin{aligned}
f(\mathbf{z}) &= ||\mathbf{z}||_2 + \frac{1}{2}||\mathbf{z} - \mathbf{s}||_2^2 \\
&= \left(\mathbf{z}^T\mathbf{z}\right)^{\frac{1}{2}} + \frac{1}{2}(\mathbf{z} - \mathbf{s})^T(\mathbf{z} - \mathbf{s})
\end{aligned}
```
FOC of ``\mathbf{z}``:
```math
\begin{aligned}
\mathbf{s} &= \frac{\mathbf{z}}{(\mathbf{z}^T\mathbf{z})^{\frac{1}{2}}} + \mathbf{z} \\ &= \left(\frac{\mathbf{1}}{||\mathbf{z}||_2} + 1\right)\mathbf{z}
\end{aligned}
```
両辺の ``\ell_2`` ノルムを取ると
```math
\begin{aligned}
||\mathbf{s}||_2 &= \left(\frac{\mathbf{1}}{||\mathbf{z}||_2} + 1\right)||\mathbf{z}||_2 \\
\Rightarrow ||\mathbf{z}||_2 &= ||\mathbf{s}||_2 - 1
\end{aligned}
```
これを代入して, ``\mathbf{z} = \left(1 - \frac{1}{||\mathbf{s}||}\right)\mathbf{s}`` を得る. この時, ``||\mathbf{z}||_2 = ||\mathbf{s}||_2 - 1 \ge 0`` より,
内点解条件は ``||\mathbf{s}||_2 \ge 1``.

内点解条件を満たさないときは, 端点解 ``\mathbf{z} = \mathbf{0}`` が解であることを示す. 目的関数 ``f(\mathbf{z})`` の定数項 ``||\mathbf{s}||_2^2`` を除いた ``g(\mathbf{z})`` を考える.
```math
\begin{aligned}
g(\mathbf{z}) &= ||\mathbf{z}||_2 + \frac{1}{2}||\mathbf{z}||_2^2 - \mathbf{z}^{\top}\mathbf{s} \\
&\ge ||\mathbf{z}||_2 + \frac{1}{2}||\mathbf{z}||_2^2 - ||\mathbf{s}||_2||\mathbf{z}||_2 & (\because -||\mathbf{s}||_2||\mathbf{z}||_2 \le \mathbf{z}^{\top}\mathbf{s} \le ||\mathbf{s}||_2||\mathbf{z}||_2) \\
&\ge \frac{1}{2}||\mathbf{z}||_2^2 & (\because ||\mathbf{s}||_2 \le 1)\\
&\ge 0
\end{aligned}
```
この時, ``g(\mathbf{z} = \mathbf{0}) = 0`` より, 下界と一致するため, これが最小値の解である. 以上より,
```math
\text{prox}_h(\mathbf{s}) = \begin{cases}
\mathbf{0} & ||\mathbf{s}||_2 < 1 \\
\left(1 - \frac{1}{||\mathbf{s}||}\right)\mathbf{s} & ||\mathbf{s}||_2 \ge 1
\end{cases}
```


"""

# ╔═╡ 705da6b7-c63c-40e7-9109-f7d9e7731477
md"""
### 4.4 (ii)
>グループ LASSO (4.32) に近接勾配法を適用したときの解の更新方法を示せ.
"""

# ╔═╡ b3325489-40e4-4cca-b265-023f62e1563a
md"""
近接勾配法を適用するため, 以下のように定義する.
```math
\begin{aligned}
f(\mathbf{x}) &= \frac{1}{2}\left|\left|\sum_{l = 1}^r A_l\mathbf{x}_l - \mathbf{b}\right|\right|_2^2 \\
g(\mathbf{x}) &= \gamma\sum_{l = 1}^r ||\mathbf{x}_l||_2 \\
\mathbf{x} &= \begin{pmatrix}\mathbf{x}_1 \\ \vdots \\ \mathbf{x}_r\end{pmatrix}
\end{aligned}
```
このとき,
```math
\begin{aligned}
\nabla f_l(\mathbf{x}) &= A_l^TA_l\mathbf{x}_l + A_l^T\left(\sum_{j \ne r} A_j\mathbf{x}_j - \mathbf{b}\right) \\
\mathbf{x}^{k + 1} &\leftarrow \textbf{prox}_{\alpha_k h}(\mathbf{x}^k - \alpha_k\nabla f(\mathbf{x}^k)) \\
&= \arg\min_{\mathbf{z}} \alpha_k \gamma\sum_{l = 1}^r ||\mathbf{z}_l||_2 
+ \frac{1}{2}||\mathbf{z} - \mathbf{x}^k + \alpha_k\nabla f(\mathbf{x}^k)||_2^2
\end{aligned}
```

この解析解の導出方法は全問とほとんど同様である. また, 目的関数はすべて``l = 1, \dots, r`` ごとに分離可能なので, 最終的な更新式は,
```math
\mathbf{x}_l^{k + 1} \leftarrow \begin{cases}
\mathbf{0} & ||\mathbf{z}_l^k||_2 < \alpha \gamma \\
\left(1 - \frac{\alpha \gamma}{||\mathbf{z}_l^k||_2}\right)\mathbf{z}_l^k & ||\mathbf{z}_l^k||_2 \ge \alpha \gamma
\end{cases}
```


"""

# ╔═╡ 5bb3ef6c-2be7-4686-a350-0d374ae86c70
md"""
## 4.5
>行列 ``A \in \mathbb{R}^{m \times n}`` とベクトル ``b \in \mathbb{R}^m`` が与えられたとき, 次の問いに答えよ.
### 4.5 (i)
>```math
>\text{Minimize } ||A\mathbf{x} - \mathbf{b}||_1
>```
>に交互方向乗数法を適用せよ.
"""

# ╔═╡ f4a7bde1-107d-4727-8988-9a5698796d91
md"""
最小化問題を
```math
\begin{aligned}
\text{Minimize }& ||\mathbf{z}||_1 \\
\text{subject to }& A\mathbf{x} - \mathbf{b} - \mathbf{z} = \mathbf{0}
\end{aligned}
```
と定義すると, 拡張 ``\mathcal{L}_\rho`` は
```math
\begin{aligned}
\mathcal{L}_\rho(\mathbf{x}, \mathbf{z}; \mathbf{v})
&= ||\mathbf{z}||_1 + \frac{\rho}{2}||A\mathbf{x} - \mathbf{b} - \mathbf{z} + \mathbf{v}||_2^2 - \frac{\rho}{2}||\mathbf{v}||_2^2
\end{aligned}
```

``\mathbf{x}^k`` の更新は ``||A\mathbf{x} - \mathbf{b} - \mathbf{z} + \mathbf{v}||_2^2`` の最小化より,
```math
\mathbf{x}^{k + 1} \leftarrow (A^TA)^{-1}A^T(\mathbf{b} + \mathbf{z}^k - \mathbf{v}^k)
```

``\mathbf{z}^k`` の更新は ``\frac{1}{\rho}||\mathbf{z}||_1 + \frac{1}{2}||A\mathbf{x} - \mathbf{b} - \mathbf{z} + \mathbf{v}||_2^2`` の最小化より,
```math
z_j^{k + 1} \leftarrow \text{sthr}_{\frac{1}{\rho}}\left((A\mathbf{x}^{k + 1} - \mathbf{b} + \mathbf{v}^k)_j\right)
```

``\mathbf{v}^k`` の更新は, 交互方向乗数法の定義から,
```math
\mathbf{v}^{k + 1} \leftarrow \mathbf{v}^k + A\mathbf{x}^{k + 1} - \mathbf{b} - \mathbf{z}^{k + 1}
```
"""

# ╔═╡ d9a7c775-0515-479b-9813-d41f3c1b6dee
md"""
### 4.5 (ii)
>```math
>\begin{aligned}
>\underset{\mathbf{x}: A\mathbf{x} = \mathbf{b}, \mathbf{z}}{\text{Minimize }}& ||\mathbf{z}||_1 \\
>\text{subject to }& \mathbf{x} - \mathbf{z} = \mathbf{0}
>\end{aligned}
>```
>に交互方向乗数法を適用せよ.
"""

# ╔═╡ d69507f7-4ee0-432f-9f1b-fa25ae61e2dd
md"""
拡張ラグランジアンは
```math
\mathcal{L}_{\rho}(\mathbf{x}, \mathbf{z}; \mathbf{v}) = ||\mathbf{z}||_1 + \frac{\rho}{2}||\mathbf{x} - \mathbf{z} + \mathbf{v}||_2^2 - \frac{\rho}{2}||\mathbf{v}||_2^2
```
全問とほぼ同様に,
```math
\begin{aligned}
\mathbf{x}^{k + 1} &\leftarrow \arg\min_{\mathbf{x}} \{||\mathbf{x} - (\mathbf{z}^k - \mathbf{v}^k)||_2^2 \,|\, A\mathbf{x} = \mathbf{b}\} \\
z_j^{k + 1} &\leftarrow \text{sthr}_{\frac{1}{\rho}}((\mathbf{x}^{k + 1} + \mathbf{v}^k)_j) \\
\mathbf{v}^{k + 1} &\leftarrow \mathbf{v}^k + \mathbf{x}^{k + 1} - \mathbf{z}^{k + 1}
\end{aligned}
```
であることが示せる.

``\mathbf{x}^k`` の更新は以下のラグランジアンの最小化と一致する.
```math
\mathcal{L}(\mathbf{x}; \mathbf{\lambda}) = ||\mathbf{x} - (\mathbf{z}^k - \mathbf{v}^k)||_2^2 + \mathbf{\lambda}^T(A\mathbf{x} - \mathbf{b})
```
最小化条件は,
```math
\begin{aligned}
2(\mathbf{x} - \mathbf{z}^k + \mathbf{v}^k) &= A^T\mathbf{\lambda}  \\
A\mathbf{x} &= \mathbf{b}
\end{aligned}
```
これを解くと,
```math
\begin{aligned}
\mathbf{\lambda} &=2(AA^T)^{-1}(\mathbf{b} - A(\mathbf{z}^k - \mathbf{v}^k)) \\
\mathbf{x} &= [I - A^T(AA^T)^{-1}A](\mathbf{z}^k - \mathbf{v}^k) + A^T(AA^T)^{-1}A\mathbf{b}
\end{aligned}
```
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
manifest_format = "2.0"

[deps]
"""

# ╔═╡ Cell order:
# ╟─923dabf6-695b-11ec-029f-094a80e5df01
# ╟─ed4149d5-bf42-4b6e-a9ff-d0b8df5333db
# ╟─f5dfb3aa-a3fd-4001-9a57-fe0c82cbf383
# ╟─e0a7c3f8-5fb7-49eb-92b9-12e83ca4a522
# ╟─2a2c3982-1a15-40c0-b678-fd619f71e33e
# ╟─83d86a71-55e8-485a-b589-78f79dccf0bd
# ╟─6e40cf5d-f4d0-40e2-aa8e-f743ec430cd0
# ╟─f199ed65-286d-46e5-8e85-d56dd12d3a7f
# ╟─633d42a9-1fc7-447e-9e5d-5c831adc5d37
# ╟─9665855b-0444-4f2b-8509-1f2d4a560b33
# ╟─1d1f83cc-9bd2-44fe-9f23-e7e2b9d73534
# ╟─944b9ecb-25be-43c1-81d3-70afbadde590
# ╟─4bcb77e0-c28c-4391-aed7-486235a91410
# ╟─6bb0713f-13e7-49ba-ab5c-3e73c95c68b9
# ╟─03484244-1972-47d8-856b-d238a534b43f
# ╟─20287435-7dec-4004-95c7-3b8135c9ebcc
# ╟─11044e74-0166-471a-985f-6200ea04d76e
# ╟─3976a2c2-7c14-4eb7-a60e-d499310a6d92
# ╟─9a16fed6-453e-4d12-830a-f6a1cae2e2e7
# ╟─de88efd1-f5d0-4c25-8380-024ec76e1106
# ╟─6751f89f-114c-4c61-ad55-b5d4dd6982f8
# ╟─4c0e127c-e608-4395-9aed-f2034038ed0e
# ╟─03c4d2bf-f61c-4478-adc8-1626dca5a5f6
# ╟─e3ebbd1c-6279-4a69-972e-1f2aa2bd974c
# ╟─f4c2f661-c354-4d67-a821-63b46758ee99
# ╟─1ca24fe3-482a-4168-a537-02c263bfa753
# ╟─705da6b7-c63c-40e7-9109-f7d9e7731477
# ╟─b3325489-40e4-4cca-b265-023f62e1563a
# ╟─5bb3ef6c-2be7-4686-a350-0d374ae86c70
# ╟─f4a7bde1-107d-4727-8988-9a5698796d91
# ╟─d9a7c775-0515-479b-9813-d41f3c1b6dee
# ╟─d69507f7-4ee0-432f-9f1b-fa25ae61e2dd
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
