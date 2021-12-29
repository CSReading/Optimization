### A Pluto.jl notebook ###
# v0.17.3

using Markdown
using InteractiveUtils

# ╔═╡ a8670966-56ac-4b74-9cf6-79fc50808019
using PlutoUI

# ╔═╡ 9c4b2e8e-68cd-11ec-3c24-e748898b66d0
md"""
# Chapter 3
#### Nicetak
 $(import Dates; Dates.format(Dates.today(), Dates.DateFormat("U d, Y")))
"""

# ╔═╡ 8b2d12e0-16da-4cdb-b277-98d700b29e07
md"""
## 3.1
>次の関数の勾配とヘッセ行列を求めよ.
"""

# ╔═╡ 666f4700-37cb-4ec3-b0df-ac81b66e2080
md"""
### 3.1 (i) 
>$$f(\mathbf{x}) = 2x_1^3 - x_1^2x_2 + 2x_2^2$$

$$\begin{aligned}
\nabla f(\mathbf{x}) &= \begin{pmatrix}6x_1^2 -2x_1x_2 \\ -x_1^2 + 4x_2\end{pmatrix} \\
Hf(\mathbf{x}) &= \begin{pmatrix}
12x_1 - 2x_2 & -2x_1 \\
-2x_1 & 4
\end{pmatrix} 
\end{aligned}$$
"""

# ╔═╡ 212c0b63-e76d-45f6-9e98-0696f677d56c
md"""
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
"""

# ╔═╡ ae88de68-5fc6-42a0-befd-04a56bb95feb
md"""
### 3.1 (iii)
>$$f(\mathbf{x}) = ||A\mathbf{x} - \mathbf{b}||_2^2 + \gamma||\mathbf{x}||_2^2$$

$$\begin{aligned}
\nabla f(\mathbf{x}) &= 2(A^TA + \gamma I) \mathbf{x} - 2A^T\mathbf{b} \\
Hf(\mathbf{x}) &= 2(A^TA + \gamma I)
\end{aligned}$$
"""

# ╔═╡ f5d62214-e886-4b75-8edc-aa1ce9375da7
md"""
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
"""

# ╔═╡ 32828a9e-c06f-4a97-910a-70a61189e6c3
md"""
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
"""

# ╔═╡ 582de7d6-64d4-48f6-aa52-7a6cfe5f8abe
md"""
## 3.2
>例 3.11 の設定において, 連立１次方程式 (3.32) の解と無制約最適化問題 (3.33) の解が一致することを示せ. また, $\nabla^2f(\mathbf{x}) = A$ であることを示せ.
"""

# ╔═╡ 55669c13-bf15-45c6-931a-cfb4fb0c9ffd
md"""
$f(\mathbf{x}) = \frac{1}{2}\mathbf{x}^TA\mathbf{x} - \mathbf{b}^T\mathbf{x}$ 
とおくと, 

$$\begin{aligned}
\nabla f(\mathbf{x}) &= A\mathbf{x} - \mathbf{b} \\
Hf(\mathbf{x}) &= A
\end{aligned}$$

ヘッセ行列の正定値性から, $f$ は凸関数であり, 一階条件

$$\nabla f(\mathbf{x}) = A\mathbf{x} - \mathbf{b} = 0$$

が大域最適条件である.
"""

# ╔═╡ a4c64b38-3f39-4372-a769-9ca4b989aa88
md"""
## 3.3
>練習問題 3.1 の (i) および (ii) の関数について, 初期点を適当に定め, 最急降下法での最初の2反復目までを実際に計算してみよ. また， 同様に, ニュートン法での最初の2反復目までを実際に計算してみよ.
"""

# ╔═╡ 8f91ab06-93d8-40b4-9d3c-ac1eb2ba39b6
begin
	f₁((x₁, x₂)) = 2x₁^3 - x₁^2 * x₂ + 2x₂^2
	f₂((x₁, x₂)) = (x₁ - 3)^2 + x₁ * x₂ + .0625x₂^2 + (x₂ - 1)^2
	∇f₁((x₁, x₂)) = [6x₁^2 - 2x₁ * x₂, -x₁^2 + 4x₂]
	∇f₂((x₁, x₂)) = [2x₁ + x₂ - 6, x₁ + .25x₂^3 + 2x₂ - 2]
	∇²f₁((x₁, x₂)) = [12x₁-2x₂ -2x₁
					 -2x₁ 4]
	∇²f₂((x₁, x₂)) = [2 1
					  1 .75x₂^2+2]

	update_gd(𝐱, ∇f; α = 0.2) = 𝐱 .- α * ∇f(𝐱)
	update_newton(𝐱, ∇f, ∇²f) = 𝐱 .- (∇²f(𝐱) \ ∇f(𝐱))
	
	𝐱₀ = [1.0, 1.0]
end;

# ╔═╡ 2c019e57-2289-40a4-9e40-97a667bb6612
md"""
### 3.3 (i)
初期値を $\mathbf{x}_0 = (1, 1)^T$ とし, 最急降下法の更新幅を $\alpha = 1$ とする.
"""

# ╔═╡ 246382b2-5144-4d7d-9899-e555049251ab
let
	𝐱₁ = update_gd(𝐱₀, ∇f₁)
	𝐱₂ = update_gd(𝐱₁, ∇f₁)

	Print("Gradient Descent\n𝐱₁ = $(round.(𝐱₁, digits = 4))\n𝐱₂ = $(round.(𝐱₂, digits = 4))")
end

# ╔═╡ 77b39d1c-d518-41f6-9438-aed39622ad39
let
	𝐱₁ = update_newton(𝐱₀, ∇f₁, ∇²f₁)
	𝐱₂ = update_newton(𝐱₁, ∇f₁, ∇²f₁)

	Print("Newton Method\n𝐱₁ = $(round.(𝐱₁, digits = 4))\n𝐱₂ = $(round.(𝐱₂, digits = 4))")
end

# ╔═╡ 6bb876fc-cfb6-4d54-9648-d885fb8dfafe
md"""
### 3.3 (ii)
"""

# ╔═╡ e1cf7463-a554-4e90-bd21-83696977874c
let
	𝐱₁ = update_gd(𝐱₀, ∇f₂)
	𝐱₂ = update_gd(𝐱₁, ∇f₂)

	Print("Gradient Descent\n𝐱₁ = $(round.(𝐱₁, digits = 4))\n𝐱₂ = $(round.(𝐱₂, digits = 4))")
end

# ╔═╡ 49cc5a3a-bb18-4d0e-8265-cf82fc99e029
let
	𝐱₁ = update_newton(𝐱₀, ∇f₂, ∇²f₂)
	𝐱₂ = update_newton(𝐱₁, ∇f₂, ∇²f₂)

	Print("Newton methhod\n𝐱₁ = $(round.(𝐱₁, digits = 4))\n𝐱₂ = $(round.(𝐱₂, digits = 4))")
end

# ╔═╡ 475e258f-4b26-4a0c-997d-e8e2e33a279a
md"""
## 3.4
>次の制約付き最適化問題に対する KKT 条件を書け. ただし, $A \in \mathbb{R}^{m \times n}$ は定行列であり, $\mathbf{b} \in \mathbb{R}^m$ は定ベクトルである.
"""

# ╔═╡ 07ec869e-e190-433d-aabd-87e191db0c61
md"""
### 3.4 (i)
>非負制約付き最小2乗法:
>
>$\begin{aligned}
>\text{Minimize }& \frac{1}{2}||A\mathbf{x} - \mathbf{b}||_2^2 \\
>\text{subject to }& \mathbf{x} \ge \mathbf{0}.
>\end{aligned}$
"""

# ╔═╡ 14aa596e-9c95-4683-a7e7-e7e6ffcc6cea
md"""
$\begin{aligned}
A^TA \mathbf{x} = \mathbf{b} + \mathbf{\lambda} \\
\mathbf{x}, \mathbf{\lambda} \ge \mathbf{0}, 
\mathbf{\lambda} \circ \mathbf{x} = \mathbf{0}
\end{aligned}$

なお $\circ$ はアダマール積を表す.
"""

# ╔═╡ 013fe2e3-12bb-425c-8999-b243807632e7
md"""
### 3.4 (ii)
>$\begin{aligned}
>\text{Minimize } & \sum_{j = 1}^n x_j \log x_j \\
>\text{subect to} & \sum_{j = 1}^n x_j = 1, \\
>&\mathbf{x} \ge \mathbf{0}.
>\end{aligned}$
"""

# ╔═╡ 889f4a0a-d7f3-42e8-a1fa-5b2887c1e8eb
md"""
$\begin{aligned}
\log x_j + 1 &= \lambda_j + \mu  \text{ for } j = 1, \dots, n\\
\mathbf{x}, \mathbf{\lambda} &\ge \mathbf{0}, \\
\mathbf{\lambda} \circ \mathbf{x} &= \mathbf{0}, \\
\mathbf{1}^T \mathbf{x} &= 1
\end{aligned}$
"""

# ╔═╡ 7c6f4183-0052-450f-90f7-42ae8350be27
md"""
## 3.5
>2変数の非線形計画問題の例で, 局所最適解において1次独立制約想定が成り立たないものを作り, その局所最適解で KKT 条件を満たすラグランジュ乗数が存在するかを調べよ.
"""

# ╔═╡ 4e443cf1-5128-4d72-915a-ccf93cacccdd
md"""
```math
\begin{aligned}
\text{Minimize }& x_1^2 + x_2^2 \\
\text{subject to }& x_1^2 - x_2 \ge 0 \\
& x_2 \ge 0
\end{aligned}
```

最適解は自明に ``\mathbf{x} = (0, 0)^T`` である.
制約関数 ``g_1(\mathbf{x}) = -x_1^2 + x_2``, ``g_2(\mathbf{x}) = -x_2`` の勾配は,
```math
\begin{aligned}
\nabla g_1(\mathbf{x}) &= \begin{pmatrix}-2x_1 \\ 1\end{pmatrix} \\
\nabla g_2(\mathbf{x}) &= \begin{pmatrix} 0 \\ -1 \end{pmatrix} \\
\end{aligned}
```
であるから, 最適解において, １次独立制約想定を満たさない. また, KKT 条件の一つである
```math
\begin{pmatrix}2x_1 \\ 2x_2\end{pmatrix} + \lambda_1 \nabla g_1(\mathbf{x}) + \lambda_2 g_2(\mathbf{x}) = \mathbf{0}
```
は最適解において, ``\lambda_1 = 1, \lambda_2 = 1`` において満たされている. (他の条件が満たされているのは自明.)

追記として, 任意の ``\lambda_1 = \lambda_2 \ge 0`` において KKT 条件が満たされる. また, 解答例のように1次独立制約想定を満たさず, KKT 条件を満たす``\mathbf{\lambda}``が存在しない例を作ることが可能である.

"""

# ╔═╡ c259663d-9c04-4b70-bcd0-326de9731ecf
md"""
## 3.6
>``\ell_1``ノルム正則化付き最小2乗法
>```math
>\text{Minimize } \frac{1}{2}\left|\left|\sum_{j = 1}^n x_j\mathbf{a_j} - \mathbf{b}\right|\right|_2^2 + \gamma \sum_{j = 1}^n |x_j|
>```
>に対する座標降下法の更新は
>```math
>x_l \leftarrow \frac{1}{||a||_2^2}\psi\left(\left(\mathbf{b} - \sum_{j \ne l}x_j \mathbf{a_j}\right)^T\mathbf{a_j}\right)
>```
>と書けることを示せ.
>ただし, $\gamma$ は正の定数であり,
>```math
>\psi(s) = \begin{cases}
>s - \gamma & s > \gamma \\
>0 & |s| \le \gamma \\
>s + \gamma & s < -\gamma
>\end{cases}
>```
>である.
"""

# ╔═╡ a6702017-55d9-48cb-b075-6320d44c44e8
md"""
最適解が``x_l > 0`` にあるとすると, 一階条件から
```math
x_l = \frac{1}{||\mathbf{a_l}||_2^2}\left(\left(\mathbf{b} - \sum_{j \ne l} x_j \mathbf{a_j}\right)^T\mathbf{a_j} - \gamma\right)
```
なお, これが``x_l > 0`` に存在する場合は, ``\left(\mathbf{b} - \sum_{j \ne l} x_j \mathbf{a_j}\right)^T\mathbf{a_j} > \gamma`` を満たす.
同様に, ``\left(\mathbf{b} - \sum_{j \ne l} x_j \mathbf{a_j}\right)^T\mathbf{a_j} < - \gamma`` の時, 
```math
x_l = \frac{1}{||\mathbf{a_l}||_2^2}\left(\left(\mathbf{b} - \sum_{j \ne l} x_j \mathbf{a_j}\right)^T\mathbf{a_j} + \gamma\right)
```
が最適解となる.
いずれの条件も満たさない場合は, 自明に端点の ``x_l = 0`` が解である.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.27"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "d7fa6237da8004be601e19bd6666083056649918"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "fed057115644d04fba7f4d768faeeeff6ad11a60"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.27"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─9c4b2e8e-68cd-11ec-3c24-e748898b66d0
# ╟─a8670966-56ac-4b74-9cf6-79fc50808019
# ╟─8b2d12e0-16da-4cdb-b277-98d700b29e07
# ╟─666f4700-37cb-4ec3-b0df-ac81b66e2080
# ╟─212c0b63-e76d-45f6-9e98-0696f677d56c
# ╟─ae88de68-5fc6-42a0-befd-04a56bb95feb
# ╟─f5d62214-e886-4b75-8edc-aa1ce9375da7
# ╟─32828a9e-c06f-4a97-910a-70a61189e6c3
# ╟─582de7d6-64d4-48f6-aa52-7a6cfe5f8abe
# ╟─55669c13-bf15-45c6-931a-cfb4fb0c9ffd
# ╟─a4c64b38-3f39-4372-a769-9ca4b989aa88
# ╠═8f91ab06-93d8-40b4-9d3c-ac1eb2ba39b6
# ╟─2c019e57-2289-40a4-9e40-97a667bb6612
# ╟─246382b2-5144-4d7d-9899-e555049251ab
# ╟─77b39d1c-d518-41f6-9438-aed39622ad39
# ╟─6bb876fc-cfb6-4d54-9648-d885fb8dfafe
# ╟─e1cf7463-a554-4e90-bd21-83696977874c
# ╟─49cc5a3a-bb18-4d0e-8265-cf82fc99e029
# ╟─475e258f-4b26-4a0c-997d-e8e2e33a279a
# ╟─07ec869e-e190-433d-aabd-87e191db0c61
# ╟─14aa596e-9c95-4683-a7e7-e7e6ffcc6cea
# ╟─013fe2e3-12bb-425c-8999-b243807632e7
# ╟─889f4a0a-d7f3-42e8-a1fa-5b2887c1e8eb
# ╟─7c6f4183-0052-450f-90f7-42ae8350be27
# ╟─4e443cf1-5128-4d72-915a-ccf93cacccdd
# ╟─c259663d-9c04-4b70-bcd0-326de9731ecf
# ╟─a6702017-55d9-48cb-b075-6320d44c44e8
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
