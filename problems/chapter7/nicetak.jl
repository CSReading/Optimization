### A Pluto.jl notebook ###
# v0.18.1

using Markdown
using InteractiveUtils

# ╔═╡ 3e6aab3a-4fb9-42d5-ac6a-988d6c558ee6
begin
	using JuMP
	using GLPK
	using PlutoUI
	using Test
end

# ╔═╡ 6a72b8b6-9cb5-11ec-2df9-09aa2b588736
md"""
# Chapter 7 Integer Programming
#### Nicetak
 $(import Dates; Dates.format(Dates.today(), Dates.DateFormat("U d, Y")))
"""

# ╔═╡ f22ecc13-4a54-431e-acff-21ca95f4ce81
md"""
## 7.1
>ナップサック問題 (7.7) を, 整数計画のソルバーで解いてみよ.
"""

# ╔═╡ dedf3c22-e377-43a6-b34f-b2cb5eae70c9
function solve_knapsack(; verbose = true)
	# Model
	model = Model(GLPK.Optimizer)
	@variable(model, x[1:5], Bin)

	profit = [28, 33, 10, 45, 32]
	weight = [2, 3, 1, 5, 4]
	capacity = 7

	@objective(model, Max, profit' * x)
	@constraint(model, weight' * x ≤ capacity)

	# Solve
	optimize!(model)
	
	if verbose
		println("Objective is: ", objective_value(model))
		println("Solution is:")
        for i in 1:5
            print("x[$i] = ", value(x[i]))
            println(", p[$i]/w[$i] = ", profit[i] / weight[i])
        end
    end

	# Test
	Test.@test termination_status(model) == OPTIMAL
    Test.@test primal_status(model) == FEASIBLE_POINT
	
	return
end

# ╔═╡ 6ea652df-5b2f-4b94-a133-dd15099cb9c9
with_terminal() do
	solve_knapsack()
end

# ╔═╡ 5d3ee1e9-a999-4f9d-a71b-3099e9b7a1f4
md"""
## 7.2
>水曜3限の $n$ 個の講義科目を $m$ 個の教室 $(m > n)$ に割り当てる問題を考える. 講義の受講者数を $d_1, \dots, d_n$ とおき, 教室の収容人数を $r_1, \dots, r_m$ とおく. 受講者数が収容人数を超える教室の数を最小にする問題を, 整数計画問題として定式化せよ. ただし, $n$ 個すべての講義をいずれかの教室で開講しなければならない. また, 一つの教室で複数の講義を開講することはできない.
"""

# ╔═╡ fc158338-7ae5-48b0-93f6-4134a1903a89
md"""
教室 $i$ で講義 $j$ が開講されることを示すダミー変数を $x_{i, j}$ とする. また, 教室 $i$ において収容人数が超えた場合を示すダミー変数を $y_i$ とする. このとき, 最小化の目的関数は
$\sum_{i = 1}^m y_i$.　制約条件は
- 講義 $j$ はある一つの教室で開講される必要があるので, $\sum_{j = 1}^n x_{i, j} = 1$
- 教室 $i$ はたかだか一つの講義が開講されるので, $\sum_{i = 1}^m x_{i, j} \le 1$
-  $y_i = 0$ の時, 受講者数 $d_i$ は $r_i$ 以下. $y_i = 1$ の時は $r_i$ より大きいことが許容される. この2つの条件は十分大きい $M$ に対して, $\sum_{j = 1}^n d_j x_{i, j} \le r_i + My_i$ と表される.

よって,
```math
\begin{aligned}
\min &\, \sum_{i = 1}^n y_i \\
\text{s. t. } & \sum_{i = 1}^m x_{i, j} = 1 & j = 1, \dots, n\\
& \sum_{j = 1}^n x_{i, j} \le 1 & i = 1, \dots, m\\
& \sum_{j = 1}^n d_j x_{i, j} \le r_i + M y_i & i = 1, \dots, n \\
& x_{i, j} \in \{0, 1\} & i = 1, \dots, n; j = 1, \dots, m \\
& y_{i} \in \{0, 1\} & i = 1, \dots, n
\end{aligned}
```
"""

# ╔═╡ c3e03cb2-271f-4093-ac26-9d852198e4ac
md"""
## 7.3
>非階層的クラスタリングの一つとして, クラスターの半径のうち最大のものを最小化する問題を考える. ただし, クラスターの半径とはそのクラスターに属するすべての点を含む最小の円の半径であると定義する. 図7.9 の例では, 点線で表した線分の長さがクラスターの半径である. この問題を, 整数制約付き2字錐計画問題として定式化せよ.
"""

# ╔═╡ 38da91bf-48e7-4c78-8404-67759b415e29
md"""
 $m$ 個のデータ点 $s_1, \dots, s_m \in \mathcal{R}^d$ を $k$ 個のクラスター $C_1, \dots, C_k$ に分けるとする. 点 $s_h$ が $C_l$ に属することを示すダミー変数を $y_{h, l}$ とする. 各クラスターの中心点 $c_l \in \mathcal{R}^d$ と定義する.  任意の点はどこか一つのクラスターに属さなければならないので, $\sum_{l = 1}^m y_{h, l} = 1$. 最小化の目的関数は $\max_{h, l} y_{h, l}||s_h - c_l||_2$. $\max$ の部分は 演習2.5(i) チェビシェフ近似問題のように考えればよい. また, $y_{h, l} = 1$ の時のみ $||s_h - c_l||_2$　を考えればよいので, 十分大きな $M$ をとって, 

```math
\begin{aligned}
\min&\,  z \\
\text{s. t. }& z + M(1 - y_{h, l}) \ge ||s_h - c_l||_2 & h=1,\dots,m; l=1,\dots,k \\
&\sum_{l = 1}^m y_{h, l} = 1 & h = 1, \dots, m \\
&y_{h, l} \in {0, 1} & h=1,\dots,m; l=1,\dots,k
\end{aligned}
```

"""

# ╔═╡ 814e0859-4b2f-46f1-9bb0-b5afd42871aa
md"""
## 7.4
>  $k-$means クラスタリング法では, クラスターの重心からデータ点の距離の2乗和を最小化する問題を考えた.
>```math
>\begin{aligned}
>\min&\, \sum_{i = 1}^k \sum_{s_l \in C_i} \rho(s_l, \mu_i)^2 \\
>\text{s.t. }& \mu_{i} = \arg \min_{\mu' \in \mathcal{R}^n} \sum_{s_l \in C_i} \rho(s_l, \mu')^2
>\end{aligned}
>```
>この問題と当科な問題として, 目的関数が線形関数であり, 制約が線形制約, 2次錐制約, 整数制約の3種類のみであるような問題を定式化せよ.
"""

# ╔═╡ 032dc2a3-67f6-4839-8475-71a1a3b94c7b
md"""
7.3とほとんど同様の設定であるので,
```math
\begin{aligned}
\min&\,  \sum_{l = 1}^m z_l \\
\text{s. t. }& z_l + M(1 - y_{h, l}) \ge ||s_h - c_l||_2^2 & h=1,\dots,m; l=1,\dots,k \\
&\sum_{l = 1}^m y_{h, l} = 1 & h = 1, \dots, m \\
&y_{h, l} \in {0, 1} & h=1,\dots,m; l=1,\dots,k
\end{aligned}
```
7.4.2節と同様に, 2次制約 $z_l + M(1 - y_{h, l}) \ge ||s_h - c_l||_2^2$ は2次錐制約
```math
z_l + M(1 - y_{h, l}) + 1\ge 
\left|\left|\begin{pmatrix}
z_l + M(1 - y_{h, l}) - 1 \\
2(s_h - c_l)
\end{pmatrix}\right|\right|_2
```
と等価である.
"""

# ╔═╡ 0d1a62bb-5825-4c70-872b-113bb4ab028e
md"""
## 7.5
>6.4.3 節で取り上げた文章要約に関する最適化問題を, 整数計画問題として定式化せよ.
"""

# ╔═╡ f804e7a3-70c5-498d-819e-d1d2d284b20f
md"""
式 (6.15) を評価尺度として, 文章 $i$ を要約に含めるかどうかのダミー変数を $x_i$ とおく. このときの最大化目的関数は $\sum_{i \in V} r_i x_i$. このままでは, もとの文章そのままが最適値になってしまうので, 要約文の文数に上限 $m$ を設けて,

```math
\begin{aligned}
\max_{i \in V} & \, \sum_{i \in V} r_i x_i \\ 
\text{s.t. }& \sum_{i in V} x_i \le m \\
& x_i \in \{0, 1\} & i \in V.
\end{aligned}
```

式 (6.16) を評価尺度とした場合, 単語 $j$ を要約に含めるかどうかのダミー変数を $y_j$ とする. 文章 $i$ を要約に含めたとき, 任意の単語 $j \in W_i$ は必ず要約に含まれるので $y_j \ge x_i$. 
よって,

```math
\begin{aligned}
\max_{j \in \cup_{i \in V} W_i} & \, t_j y_j \\ 
\text{s.t. }& y_j \ge x_i & \forall j \in W_i;\, \forall i \in V \\
& \sum_{i \in V} x_i \le m \\
& x_i \in \{0, 1\} & i \in V \\
& y_j \in \{0, 1\} & j \in \cup_{i \in V} W_i.
\end{aligned}
```
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
GLPK = "60bf3e95-4087-53dc-ae20-288a0d20c6a6"
JuMP = "4076af6c-e467-56ae-b986-b466b2749572"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[compat]
GLPK = "~1.0.0"
JuMP = "~0.23.1"
PlutoUI = "~0.7.35"
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
git-tree-sha1 = "4c10eee4af024676200bc7752e536f858c6b8f93"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.3.1"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c9a6160317d1abe9c44b3beb367fd448117679ca"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.13.0"

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
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "dd933c4ef7b4c270aacd4eb88fa64c147492acf0"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.10.0"

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
git-tree-sha1 = "1bd6fc0c344fc0cbee1f42f8d2e7ec8253dda2d2"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.25"

[[deps.GLPK]]
deps = ["GLPK_jll", "MathOptInterface"]
git-tree-sha1 = "7971e2ce3715a873b539174137bd8c4e19ac7a8f"
uuid = "60bf3e95-4087-53dc-ae20-288a0d20c6a6"
version = "1.0.0"

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
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JuMP]]
deps = ["Calculus", "DataStructures", "ForwardDiff", "LinearAlgebra", "MathOptInterface", "MutableArithmetics", "NaNMath", "OrderedCollections", "Printf", "SparseArrays", "SpecialFunctions"]
git-tree-sha1 = "ab093fae27d6ccbb41eb7c8e8c5664b881c79929"
uuid = "4076af6c-e467-56ae-b986-b466b2749572"
version = "0.23.1"

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
git-tree-sha1 = "a62df301482a41cb7b1db095a4e6949ba7eb3349"
uuid = "b8f27783-ece8-5eb3-8dc8-9495eed66fee"
version = "1.1.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "ba8c0f8732a24facba709388c74ba99dcbfdda1e"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "1.0.0"

[[deps.NaNMath]]
git-tree-sha1 = "b086b7ea07f8e38cf122f5016af580881ac914fe"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.7"

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
git-tree-sha1 = "13468f237353112a01b2d6b32f3d0f80219944aa"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "85bf3e4bd279e405f91489ce518dedb1e32119cb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.35"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "de893592a221142f3db370f48290e3a2ef39998f"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.4"

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
git-tree-sha1 = "5ba658aeecaaf96923dce0da9e703bd1fe7666f9"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.4"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "74fb527333e72ada2dd9ef77d98e4991fb185f04"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.4.1"

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
# ╟─6a72b8b6-9cb5-11ec-2df9-09aa2b588736
# ╠═3e6aab3a-4fb9-42d5-ac6a-988d6c558ee6
# ╟─f22ecc13-4a54-431e-acff-21ca95f4ce81
# ╠═dedf3c22-e377-43a6-b34f-b2cb5eae70c9
# ╟─6ea652df-5b2f-4b94-a133-dd15099cb9c9
# ╟─5d3ee1e9-a999-4f9d-a71b-3099e9b7a1f4
# ╟─fc158338-7ae5-48b0-93f6-4134a1903a89
# ╟─c3e03cb2-271f-4093-ac26-9d852198e4ac
# ╟─38da91bf-48e7-4c78-8404-67759b415e29
# ╟─814e0859-4b2f-46f1-9bb0-b5afd42871aa
# ╟─032dc2a3-67f6-4839-8475-71a1a3b94c7b
# ╟─0d1a62bb-5825-4c70-872b-113bb4ab028e
# ╟─f804e7a3-70c5-498d-819e-d1d2d284b20f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
