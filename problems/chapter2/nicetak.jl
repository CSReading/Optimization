### A Pluto.jl notebook ###
# v0.17.5

using Markdown
using InteractiveUtils

# ╔═╡ 22687fac-b338-4634-976b-73d784512027
begin
	using JuMP
	using GLPK
	using PlutoUI
end

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

# ╔═╡ 5c7d1f02-475e-4c63-97d0-1f67517a3787
let
	model = Model(GLPK.Optimizer)
	
	@variable(model, x[1:6] ≥ 0)
	
	c = [1.0, 2.0, 3.0, 4.0, 8.0, 7.0]
	@objective(model, Min, c'x)
	
	@constraints(model, begin
		x[1] + x[2] + x[3] == 20
		x[4] + x[5] + x[6] == 15
		x[1] + x[4] == 8.5
		x[2] + x[5] == 12.5
		x[3] + x[6] == 14
	end)

	optimize!(model)
	with_terminal() do
		println(model)
		@show solution_summary(model)
		@show value.(x)
	end
end

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

# ╔═╡ 88c32e00-1b60-4f3f-b4eb-a426d571c650
let
	model = Model(GLPK.Optimizer)
	
	@variables(model, begin
		x₁ ≥ 0
		x₂ ≥ 0
	end)
	
	@objective(model, Max, -x₁ + 4x₂)
	
	@constraints(model, begin
		x₁ + 3x₂ ≥ 3
		-2x₁ + x₂ ≤ 2
	end)

	optimize!(model)
	with_terminal() do
		println(model)
		@show solution_summary(model)
		@show value.([x₁, x₂])
	end
end

# ╔═╡ 3bef6ce0-0a83-4377-b4ed-232aefe56c71
let
	model = Model(GLPK.Optimizer)
	
	@variables(model, begin
		x₁ ≥ 0
		x₂ ≥ 0
		s₁ ≥ 0
		s₂ ≥ 0
	end)
	
	@objective(model, Min, x₁ - 4x₂)
	
	@constraints(model, begin
		x₁ + 3x₂ - s₁ == 3
		2x₁ - x₂ - s₂ == -2
	end)

	optimize!(model)
	with_terminal() do
		println(model)
		@show solution_summary(model)
		@show value.([x₁, x₂])
	end
end

# ╔═╡ 8fa17152-0158-4685-8c75-2478d50ef868
md"""
### 2.2 (ii)
>```math
>\begin{aligned}
>\text{Minimize }& x_1 + 2x_2 + x_3 \\
>\text{subject to }& x_1 + 2x_2 + 4x_3 = 6, \\
>& 5x_1 + 4x_2 \le 20, \\
>&x_2 \ge 0.
>\end{aligned}
>```

"""

# ╔═╡ ab0c1802-085b-488d-81f3-17c9d36c6d19
md"""
```math
\begin{aligned}
\text{Minimize }& x_1^{+} - x_1^{-} + 2x_2 + x_3^{+} - x_3^{-}\\
\text{subject to }& x_1^{+} - x_1^{-} + 2x_2 + 4x_3^{+} - 4x_3^{-} = 6, \\
& 5x_1^{+} - 5x_1^{-} + 4x_2 + s = 20, \\
& x_1^{+}, x_1^{-}, x_2, x_3^{+}, x_3^{-}, s \ge 0.
\end{aligned}
```
"""

# ╔═╡ 36b761c3-a6a3-4673-96f7-2c006d9a778e
let
	model = Model(GLPK.Optimizer)
	
	@variables(model, begin
		x₁
		x₂ ≥ 0
		x₃
	end)
	
	@objective(model, Min, x₁ + 2x₂ + x₃)
	
	@constraints(model, begin
		x₁ + 2x₂ + 4x₃ == 6
		5x₁ + 4x₂ ≤ 20
	end)

	optimize!(model)
	with_terminal() do
		println(model)
		@show solution_summary(model)
		@show value.([x₁, x₂, x₃])
	end
end

# ╔═╡ 110235f0-5dd6-4a3e-8029-99ef7ab49ea8
let
	model = Model(GLPK.Optimizer)
	
	@variables(model, begin
		x₁⁺ ≥ 0
		x₁⁻ ≥ 0
		x₂ ≥ 0
		x₃⁺ ≥ 0
		x₃⁻ ≥ 0
		s ≥ 0
	end)
	
	@objective(model, Min, x₁⁺ - x₁⁻ + 2x₂ + x₃⁺ - x₃⁻)
	
	@constraints(model, begin
		x₁⁺ - x₁⁻ + 2x₂ + 4x₃⁺ - 4x₃⁻ == 6
		5x₁⁺ - 5x₁⁻ + 4x₂ + s == 20
	end)

	optimize!(model)
	with_terminal() do
		println(model)
		@show solution_summary(model)
		println([value(x₁⁺) - value(x₁⁻), value(x₂), value(x₃⁺) - value(x₃⁻)])
	end
end

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

# ╔═╡ a22581bc-41da-4f1b-bdca-cfa25858c826
let
	model = Model(GLPK.Optimizer)
	
	@variables(model, begin
		y₁ ≥ 0
		y₂ ≥ 0
	end)
	@objective(model, Min, -3y₁ + 2y₂)
	@constraints(model, begin
		-y₁ - 2y₂ == 1
		-3y₁ + y₂ == -4
	end)

	optimize!(model)
	with_terminal() do
		println(model)
		@show solution_summary(model)
		@show value.([y₁, y₂])
	end
end

# ╔═╡ 7eab9948-3b2e-4f3a-b3ae-f9a3419d6d23
md"""
### 2.3 (ii)

```math
\begin{aligned}
\text{Maximize }& 6y_1 + 20y_2 \\
\text{subject to }& y_1 + 5y_2  \le 1, \\
& -y_1 - 5y_2  \le -1, \\
& 2y_1 + 4y_2 \le 2, \\
& 4y_1 \le 1, \\
& -4y_1 \le -1, \\
& y_2 \le 1, \\
& y_1, y_2 \ge 0.
\end{aligned}
```
"""

# ╔═╡ 769a2e0a-9762-4d4a-bc93-a6ed70075a45
let
	model = Model(GLPK.Optimizer)
	
	@variable(model, y[1:2] ≥ 0)

	b = [6, 20]
	
	@objective(model, Max, b'y)
	
	c = [1, -1, 2, 1, -1]
	A = [1 -1 2 4 -4
		 5 -5 4 0 0]
	@constraint(model, A'y .≤ c)

	optimize!(model)
	with_terminal() do
		println(model)
		@show solution_summary(model)
		@show value.(y)
	end
end

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
GLPK = "60bf3e95-4087-53dc-ae20-288a0d20c6a6"
JuMP = "4076af6c-e467-56ae-b986-b466b2749572"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
GLPK = "~0.15.2"
JuMP = "~0.22.1"
PlutoUI = "~0.7.29"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.1"
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

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "940001114a0147b6e4d10624276d56d531dd9b49"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.2.2"

[[deps.BinaryProvider]]
deps = ["Libdl", "Logging", "SHA"]
git-tree-sha1 = "ecdec412a9abc8db54c0efc5548c64dfce072058"
uuid = "b99e7846-7c00-51b0-8f62-c81ae34c0232"
version = "0.5.10"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.CEnum]]
git-tree-sha1 = "215a9aa4a1f23fbd05b92769fdd62559488d70e9"
uuid = "fa961155-64e5-5f13-b03f-caf6b980ea82"
version = "0.4.1"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "926870acb6cbcf029396f2f2de030282b6bc1941"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.11.4"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "bf98fa45a0a4cee295de98d4c1462be26345b9a1"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.2"

[[deps.CodecBzip2]]
deps = ["Bzip2_jll", "Libdl", "TranscodingStreams"]
git-tree-sha1 = "2e62a725210ce3c3c2e1a3080190e7ca491f18d7"
uuid = "523fee87-0ab8-5b00-afb7-3ecf72e48cfd"
version = "0.7.2"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "44c37b4636bc54afac5c574d2d02b625349d6582"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.41.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DiffResults]]
deps = ["StaticArrays"]
git-tree-sha1 = "c18e98cba888c6c25d1c3b048e4b3380ca956805"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.0.3"

[[deps.DiffRules]]
deps = ["LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "9bc5dac3c8b6706b58ad5ce24cffd9861f07c94f"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.9.0"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions", "StaticArrays"]
git-tree-sha1 = "2b72a5624e289ee18256111657663721d59c143e"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.24"

[[deps.GLPK]]
deps = ["BinaryProvider", "CEnum", "GLPK_jll", "Libdl", "MathOptInterface"]
git-tree-sha1 = "ab6d06aa06ce3de20a82de5f7373b40796260f72"
uuid = "60bf3e95-4087-53dc-ae20-288a0d20c6a6"
version = "0.15.2"

[[deps.GLPK_jll]]
deps = ["Artifacts", "GMP_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "fe68622f32828aa92275895fdb324a85894a5b1b"
uuid = "e8aa6df9-e6ca-548a-97ff-1f85fc5b8b98"
version = "5.0.1+0"

[[deps.GMP_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "781609d7-10c4-51f6-84f2-b8444358ff6d"

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

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "a7254c0acd8e62f1ac75ad24d5db43f5f19f3c65"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.2"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[deps.JuMP]]
deps = ["Calculus", "DataStructures", "ForwardDiff", "JSON", "LinearAlgebra", "MathOptInterface", "MutableArithmetics", "NaNMath", "Printf", "Random", "SparseArrays", "SpecialFunctions", "Statistics"]
git-tree-sha1 = "de9c69c0862be0e11afe5d4aa3426af1d7ecac2c"
uuid = "4076af6c-e467-56ae-b986-b466b2749572"
version = "0.22.1"

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

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "e5718a00af0ab9756305a0392832c8952c7426c1"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.6"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MathOptInterface]]
deps = ["BenchmarkTools", "CodecBzip2", "CodecZlib", "JSON", "LinearAlgebra", "MutableArithmetics", "OrderedCollections", "Printf", "SparseArrays", "Test", "Unicode"]
git-tree-sha1 = "38062215a56109442d4ec25a0a2970cbfef55bbc"
uuid = "b8f27783-ece8-5eb3-8dc8-9495eed66fee"
version = "0.10.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "73deac2cbae0820f43971fad6c08f6c4f2784ff2"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "0.3.2"

[[deps.NaNMath]]
git-tree-sha1 = "f755f36b19a5116bb580de457cda0c140153f283"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.6"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

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
git-tree-sha1 = "7711172ace7c40dc8449b7aed9d2d6f1cf56a5bd"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.29"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "2cf929d64681236a2e074ffafb8d568733d2e6af"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

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

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "f0bccf98e16759818ffc5d97ac3ebf87eb950150"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "1.8.1"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "88a559da57529581472320892576a486fa2377b9"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.3.1"

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

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "216b95ea110b5972db65aa90f88d8d89dcb8851c"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.6"

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
# ╟─d94dba42-ed44-4f71-9c0c-175ecdb60879
# ╠═22687fac-b338-4634-976b-73d784512027
# ╟─043fecbc-89d0-4878-a62b-64049b147f4c
# ╟─f918f843-3b33-4e7f-9b26-ce57c2461dc9
# ╟─5c7d1f02-475e-4c63-97d0-1f67517a3787
# ╟─02cd6c44-6048-4680-87fe-4fc038cb89e7
# ╟─476f4ae1-dcdd-4200-b7b8-c9e8b85ca490
# ╟─fcdcdca2-5bf8-4e10-bd90-7215bab88236
# ╟─88c32e00-1b60-4f3f-b4eb-a426d571c650
# ╟─3bef6ce0-0a83-4377-b4ed-232aefe56c71
# ╟─8fa17152-0158-4685-8c75-2478d50ef868
# ╟─ab0c1802-085b-488d-81f3-17c9d36c6d19
# ╟─36b761c3-a6a3-4673-96f7-2c006d9a778e
# ╟─110235f0-5dd6-4a3e-8029-99ef7ab49ea8
# ╟─ad382c42-4b91-4af9-ae68-d54832862f6b
# ╟─8c70e99e-a777-46da-9dcc-772c92b44d20
# ╠═a22581bc-41da-4f1b-bdca-cfa25858c826
# ╟─7eab9948-3b2e-4f3a-b3ae-f9a3419d6d23
# ╟─769a2e0a-9762-4d4a-bc93-a6ed70075a45
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
