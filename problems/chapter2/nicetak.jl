### A Pluto.jl notebook ###
# v0.17.3

using Markdown
using InteractiveUtils

# ╔═╡ d94dba42-ed44-4f71-9c0c-175ecdb60879
md"""
# Chapter 2
#### Nicetak
 $(import Dates; Dates.format(Dates.today(), Dates.DateFormat("U d, Y")))
"""

# ╔═╡ 043fecbc-89d0-4878-a62b-64049b147f4c
md"""
## 2.1
>1.1節の例1.2の輸送問題を, 線形計画問題として定式化せよ.
"""

# ╔═╡ f918f843-3b33-4e7f-9b26-ce57c2461dc9
md"""
```math
\begin{aligned}
\min\, &x_1 + 2x_2 + 3x_3 + 4x_4 + 8x_5 + 7x_6 \\
\text{s.t. }& x_1 + x_2 + x_3 = 20, \\
& x_4 + x_5 + x_6 = 15, \\
& x_1 + x_4 = 8.5, \\
& x_2 + x_5 = 12.5, \\
& x_3 + x_6 = 14, \\
& x_1, \dots, x_6 \ge 0.
\end{aligned}
```
"""

# ╔═╡ 02cd6c44-6048-4680-87fe-4fc038cb89e7
md"""
## 2.2
>次の線形計画問題を等式標準形に直せ
"""

# ╔═╡ 476f4ae1-dcdd-4200-b7b8-c9e8b85ca490
md"""
### 2.2 (i)
>```math
>\begin{aligned}
>\text{Maximize }& -x_1 + 4x_2 \\
>\text{subject to }& x_1 + 3x_2 \ge 3, \\
>&-2x_1 + x_2 \le 2, \\
>&x_1, x_2 \ge 0.
>\end{aligned}
>```
"""

# ╔═╡ fcdcdca2-5bf8-4e10-bd90-7215bab88236
md"""
```math
\begin{aligned}
\text{Minimize }& x_1 - 4x_2 \\
\text{subject to }& x_1 + 3x_2 - s_1 = 3, \\
& 2x_1 - x_2 - s_2 = -2, \\
& x_1, x_2, s_1, s_2 \ge 0.
\end{aligned}
```
"""

# ╔═╡ 8fa17152-0158-4685-8c75-2478d50ef868
md"""
### 2.2 (ii)
>```math
>\begin{aligned}
>\text{Minimize }& x_1 + 2x_2 + x_3 \\
>\text{subject to }& x_1 + 2x_2 + 4x_2 = 6, \\
>& 5x_1 + 4x_2 \le 20, \\
>&x_2 \ge 0.
>\end{aligned}
>```

"""

# ╔═╡ ab0c1802-085b-488d-81f3-17c9d36c6d19
md"""
```math
\begin{aligned}
\text{Minimize }& x_1 + 2x_2 + x_3 \\
\text{subject to }& x_1 + 2x_2 + 4x_3 = 6, \\
& 5x_1 + 4x_2 + s = 20, \\
& x_1, x_2, x_3, s \ge 0.
\end{aligned}
```
"""

# ╔═╡ ad382c42-4b91-4af9-ae68-d54832862f6b
md"""
## 2.3
>練習問題2.2の線形計画問題の双対問題を導け.
"""

# ╔═╡ 8c70e99e-a777-46da-9dcc-772c92b44d20
md"""
### 2.3 (i)

```math
\begin{aligned}
\text{Minimize }& -3y_1 + 2y_2 \\
\text{subject to }& -y_1 - 2y_2  = 1, \\
& -3y_1 + y_2 = -4, \\
& y_1, y_2 \ge 0.
\end{aligned}
```
"""

# ╔═╡ 7eab9948-3b2e-4f3a-b3ae-f9a3419d6d23
md"""
### 2.3 (ii)

```math
\begin{aligned}
\text{Maximize }& 6y_1 + 20y_2 \\
\text{subject to }& y_1 + 5y_2  \le 1, \\
& 2y_1 + 4y_2 \le 2, \\
& 4y_1 \le 3, \\
& y_2 \le 0, \\
& y_1, y_2 \ge 0.
\end{aligned}
```
"""

# ╔═╡ d28a071b-d977-4c92-8268-556b61152d8d
md"""
## 2.4
>2.3.1節では, 線形計画問題 (2.15) の実行可能基底解が得られていることを前提に, 単体法の一反復を説明した. 実行可能基底解を得るために, しばしば次の線形計画問題が利用される:
>```math
>\begin{aligned}
>\text{Minimize }& \mathbf{1}^T\mathbf{z} \\
>\text{subjet to }& A\mathbf{x} + \mathbf{z} = \mathbf{b}, \\
>& \mathbf{x} \ge \mathbf{0}, \mathbf{z} \ge \mathbf{0}.
>\end{aligned}
>```
>ただし, ``\mathbf{b} \ge \mathbf{0}``であるとする (もし ``\mathbf{b}`` が負の成分を持つ場合は, その成分に対応する等式制約の両辺に-1を乗じることで ``\mathbf{b} \ge \mathbf{0}`` とできる.) ここで, ``\mathbf{z}`` を基底変数とする. この問題の実行可能基底解はどのようなものか. また, この問題の最適解と問題 (2.15) の実行可能基底解とにはどのような関係があるか.
"""

# ╔═╡ 1a092d55-d89b-43e2-85ef-7e9842b4d536
md"""
``\mathbf{z}`` を基底変数とすると
```math
\begin{pmatrix}A & I \end{pmatrix} 
\begin{pmatrix}\mathbf{x} \\ \mathbf{z}\end{pmatrix} = \mathbf{b}
```
より, ``\mathbf{x} = \mathbf{0}``, ``\mathbf{z} = \mathbf{b}``.

また, この問題の最適解は明らかに ``A\mathbf{x} = \mathbf{b}`` かつ ``\mathbf{z} = \mathbf{0}``であるので, 問題 (2.15) の実行可能基底解は ``\mathbf{x}`` に関してこれを満たす.
"""

# ╔═╡ 5d1abc24-70fd-46ba-b47c-fee07dc0df1b
md"""
## 2.5
>次の最適化問題を, 線形計画問題か凸二次計画問題のいずれかに帰着せよ. ただし, ``\gamma`` および ``\rho`` は正の定数である.
"""

# ╔═╡ 8aa98211-3b79-4f68-ae23-8ac71ed67b46
md"""
### 2.5 (i)
>チェビシェフ近似問題:
>```math 
>\text{Minimize } ||A\mathbf{x} - \mathbf{b}||_{\infty}
>```
"""

# ╔═╡ ea1ffeb3-6d1d-457e-8436-b28d918c4558
md"""
### 2.5 (i)
```math
\begin{aligned}
\text{Minimize } & y \\
\text{subject to } & A\mathbf{x} - \mathbf{b} \ge -y\mathbf{1} \\
& A\mathbf{x} - \mathbf{b} \le y\mathbf{1} 
\end{aligned}
```
"""

# ╔═╡ b77b1d64-7a87-4d6c-91fe-fec6863051ea
md"""
### 2.5 (ii)
>``\ell_1`` ノルム正則化付きチェビシェフ近似問題:
>```math
>\text{Minimize } ||A\mathbf{x} - \mathbf{b}||_{\infty} + \gamma||\mathbf{x}||_1
>```
"""

# ╔═╡ 24625aaf-6203-4556-9274-5d95e82c4f05
md"""
```math
\begin{aligned}
\text{Minimize } & y + \gamma \mathbf{1}^T\mathbf{z}\\
\text{subject to } & A\mathbf{x} - \mathbf{b} \ge -y\mathbf{1} \\
& A\mathbf{x} - \mathbf{b} \le y\mathbf{1} \\
& \mathbf{x} \ge -\mathbf{z} \\
& \mathbf{x} \le \mathbf{z} \\
\end{aligned}
```
"""

# ╔═╡ b9427eda-130b-424e-887a-b0a5fcdba8f9
md"""
### 2.5 (iii)
>ティコノフ正則化付きチェビシェフ近似問題:
>```math
>\text{Minimize } ||A\mathbf{x} - \mathbf{b}||_{\infty} + \gamma||\mathbf{x}||^2_2
>```
"""

# ╔═╡ 492345aa-41f1-4dea-bdf1-76e58978c17e
md"""
```math
\begin{aligned}
\text{Minimize } & y + \gamma \mathbf{x}^T\mathbf{x}\\
\text{subject to } & A\mathbf{x} - \mathbf{b} \ge -y\mathbf{1} \\
& A\mathbf{x} - \mathbf{b} \le y\mathbf{1} 
\end{aligned}
```
"""

# ╔═╡ 60db7fbc-024e-4fcf-8b1c-5b8c5b062faf
md"""
### 2.5 (iv)
>エラスティックネット正則化付き最小2乗法:
>```math
>\text{Minimize } ||A\mathbf{x} - \mathbf{b}||^2_2 + \gamma||\mathbf{x}||^2_2 + \rho||\mathbf{x}||_1
>```
"""

# ╔═╡ 9b72455a-7e12-4084-aafa-ff199d84fcef
md"""
```math
\begin{aligned}
\text{Minimize } & \mathbf{x}^T(A^TA + \gamma I)\mathbf{x} - 
2\mathbf{b}^T A\mathbf{x} + \rho \mathbf{1}\mathbf{z}\\
\text{subject to } & \mathbf{x} \ge -\mathbf{z} \\
& \mathbf{x} \le \mathbf{z}
\end{aligned}
```
"""

# ╔═╡ a090bd7d-1c85-4b09-b02d-d522acdd7ef8
md"""
## 2.6
>サポートベクターマシンに関連する次の問いに答えよ.
"""

# ╔═╡ d45ba462-c101-4357-84d7-c5390280b0e4
md"""
### 2.6 (i)
>問題 (2.45) を問題 (2.33) の形に直した時, ``Q, A, \mathbf{b}, \mathbf{c}``はどのようになるか.
"""

# ╔═╡ ddb76e52-18d4-45e1-82fa-240b00463548
md"""
決定変数は``\mathbf{\omega}, v, \mathbf{e}`` であるが,
``\mathbf{\omega}, v`` は負の数も取りうる.
またスラック変数 ``\mathbf{z}`` を導入すると, 決定変数は以下のように定義できる.
```math
\mathbf{x} = \begin{pmatrix} \mathbf{\omega}^{+} & \mathbf{\omega}^{-} &
v^{+} & v^{-} & \mathbf{e} &  \mathbf{z} \end{pmatrix}^T
```

また, ``\mathbf{t} = \begin{pmatrix}t_1 & \dots & t_r\end{pmatrix}^T`` と
``U = \begin{pmatrix}t_1\mathbf{s}_1 & \dots & t_r\mathbf{s}_r\end{pmatrix}^T``
を定義すると, この問題は以下のように書き換えられる.
```math
\begin{aligned}
&\min_{\mathbf{x}} \frac{1}{2}\mathbf{x}^T\begin{pmatrix}
2I & -2I & O & O & O & O \\
-2I & 2I & O & O & O & O \\
O & O & O & O & O & O \\
O & O & O & O & O & O \\
O & O & O & O & O & O \\
O & O & O & O & O & O \\
\end{pmatrix}\mathbf{x}
+ \begin{pmatrix}\mathbf{0}^T & \mathbf{0}^T & 0 & 0 & \gamma \mathbf{1}^T & \mathbf{0}^T\end{pmatrix}\mathbf{x} \\
&\text{s.t. } \begin{pmatrix}U & -U & \mathbf{t} & -\mathbf{t} & I & -I\end{pmatrix}\mathbf{x} = \mathbf{1},\,\mathbf{x} \ge \mathbf{0}
\end{aligned}
```
"""

# ╔═╡ befd0447-d4dc-42c3-ade6-4652d30d91d2
md"""
### 2.6 (ii)
>問題 (2.43) において, 関数 $\phi$ を
>```math
>\phi(z) = \begin{cases}0 & z \ge 1 \\ (z - 1)^2 & z < 1 \end{cases}
>```
>で定義する. この時, 問題 (2.43) を凸二次計画問題 (2.33) の形に直せ.
"""

# ╔═╡ a665a173-63e4-4f53-a4ac-0216be3ca55d
md"""
```math
\phi(z) = \min_e \{e^2 | z + e \ge 1, e \ge 0\}
```
と書き換えられることに注目すると, 前問と比べて異なる点は, 目的関数が ``\mathbf{\omega}^T\mathbf{\omega} + \gamma \mathbf{e}^T\mathbf{e}``
である点のみである. したがって,
```math
\begin{aligned}
&\min_{\mathbf{x}} \frac{1}{2}\mathbf{x}^T\begin{pmatrix}
2I & -2I & O & O & O & O \\
-2I & 2I & O & O & O & O \\
O & O & O & O & O & O \\
O & O & O & O & O & O \\
O & O & O & O & 2\gamma I & O \\
O & O & O & O & O & O \\
\end{pmatrix}\mathbf{x} \\
&\text{s.t. } \begin{pmatrix}U & -U & \mathbf{t} & -\mathbf{t} & I & -I\end{pmatrix}\mathbf{x} = \mathbf{1},\,\mathbf{x} \ge \mathbf{0}
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

julia_version = "1.7.0"
manifest_format = "2.0"

[deps]
"""

# ╔═╡ Cell order:
# ╟─d94dba42-ed44-4f71-9c0c-175ecdb60879
# ╟─043fecbc-89d0-4878-a62b-64049b147f4c
# ╟─f918f843-3b33-4e7f-9b26-ce57c2461dc9
# ╟─02cd6c44-6048-4680-87fe-4fc038cb89e7
# ╟─476f4ae1-dcdd-4200-b7b8-c9e8b85ca490
# ╟─fcdcdca2-5bf8-4e10-bd90-7215bab88236
# ╟─8fa17152-0158-4685-8c75-2478d50ef868
# ╟─ab0c1802-085b-488d-81f3-17c9d36c6d19
# ╟─ad382c42-4b91-4af9-ae68-d54832862f6b
# ╟─8c70e99e-a777-46da-9dcc-772c92b44d20
# ╟─7eab9948-3b2e-4f3a-b3ae-f9a3419d6d23
# ╟─d28a071b-d977-4c92-8268-556b61152d8d
# ╟─1a092d55-d89b-43e2-85ef-7e9842b4d536
# ╟─5d1abc24-70fd-46ba-b47c-fee07dc0df1b
# ╟─8aa98211-3b79-4f68-ae23-8ac71ed67b46
# ╟─ea1ffeb3-6d1d-457e-8436-b28d918c4558
# ╟─b77b1d64-7a87-4d6c-91fe-fec6863051ea
# ╟─24625aaf-6203-4556-9274-5d95e82c4f05
# ╟─b9427eda-130b-424e-887a-b0a5fcdba8f9
# ╟─492345aa-41f1-4dea-bdf1-76e58978c17e
# ╟─60db7fbc-024e-4fcf-8b1c-5b8c5b062faf
# ╟─9b72455a-7e12-4084-aafa-ff199d84fcef
# ╟─a090bd7d-1c85-4b09-b02d-d522acdd7ef8
# ╟─d45ba462-c101-4357-84d7-c5390280b0e4
# ╟─ddb76e52-18d4-45e1-82fa-240b00463548
# ╟─befd0447-d4dc-42c3-ade6-4652d30d91d2
# ╟─a665a173-63e4-4f53-a4ac-0216be3ca55d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
