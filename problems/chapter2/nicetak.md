# Chapter 2
#### Nicetak

## 2.1
>1.1節の例1.2の輸送問題を, 線形計画問題として定式化せよ.

$\begin{aligned}
\min\, &x_1 + 2x_2 + 3x_3 + 4x_4 + 8x_5 + 7x_6 \\
\text{s.t. }& x_1 + x_2 + x_3 = 20, \\
& x_4 + x_5 + x_6 = 15, \\
& x_1 + x_4 = 8.5, \\
& x_2 + x_5 = 12.5, \\
& x_3 + x_6 = 14, \\
& x_1, \dots, x_6 \ge 0.
\end{aligned}$

## 2.2
>次の線形計画問題を等式標準形に直せ
>
>(i)
>$\begin{aligned}
\text{Maximize }& -x_1 + 4x_2 \\
\text{subject to }& x_1 + 3x_2 \ge 3, \\
&-2x_1 + x_2 \le 2, \\
&x_1, x_2 \ge 0.
\end{aligned}$
>
>(ii)
$\begin{aligned}
\text{Minimize }& x_1 + 2x_2 + x_3 \\
\text{subject to }& x_1 + 2x_2 + 4x_2 = 6, \\
& 5x_1 + 4x_2 \le 20, \\
&x_2 \ge 0.
\end{aligned}$

### 2.2 (i)

$\begin{aligned}
\text{Minimize }& x_1 - 4x_2 \\
\text{subject to }& x_1 + 3x_2 - s_1 = 3, \\
& 2x_1 - x_2 - s_2 = -2, \\
& x_1, x_2, s_1, s_2 \ge 0.
\end{aligned}$

### 2.2 (ii)

$\begin{aligned}
\text{Minimize }& x_1 + 2x_2 + x_3 \\
\text{subject to }& x_1 + 2x_2 + 4x_3 = 6, \\
& 5x_1 + 4x_2 + s = 20, \\
& x_1, x_2, x_3, s \ge 0.
\end{aligned}$

## 2.3
>練習問題2.2の線形計画問題の双対問題を導け

### 2.3 (i)

$\begin{aligned}
\text{Minimize }& -3y_1 + 2y_2 \\
\text{subject to }& -y_1 - 2y_2  = 1, \\
& -3y_1 + y_2 = -4, \\
& y_1, y_2 \ge 0.
\end{aligned}$

### 2.3 (ii)

$\begin{aligned}
\text{Maximize }& 6y_1 + 20y_2 \\
\text{subject to }& y_1 + 5y_2  \le 1, \\
& 2y_1 + 4y_2 \le 2, \\
& 4y_1 \le 3, \\
& y_2 \le 0, \\
& y_1, y_2 \ge 0.
\end{aligned}$

## 2.4
>2.3.1節では, 線形計画問題 (2.15) の実行可能基底解が得られていることを前提に,
単体法の一反復を説明した. 実行可能基底解を得るために, しばしば次の線形計画問題が利用される:
$\begin{aligned}
\text{Minimize }& \mathbf{1}^T\mathbf{z} \\
\text{subjet to }& A\mathbf{x} + \mathbf{z} = \mathbf{b}, \\
& \mathbf{x} \ge \mathbf{0}, \mathbf{z} \ge \mathbf{0}.
\end{aligned}$
ただし, $\mathbf{b} \ge \mathbf{0}$であるとする (もし $\mathbf{b}$ が負の成分を
持つ場合は, その成分に対応する等式制約の両辺に-1を乗じることで
$\mathbf{b} \ge \mathbf{0}$ とできる.) ここで, $\mathbf{z}$ を基底変数とする
この問題の実行可能基底解はどのようなものか. また, この問題の最適解と問題 (2.15) 
の実行可能基底解とにはどのような関係があるか.

$\mathbf{z}$ を基底変数とすると
$$\begin{pmatrix}A & I \end{pmatrix} 
\begin{pmatrix}\mathbf{x} \\ \mathbf{z}\end{pmatrix} = \mathbf{b}$$
より, $\mathbf{x} = \mathbf{0}$, $\mathbf{z} = \mathbf{b}$.

また, この問題の最適解は明らかに $A\mathbf{x} = \mathbf{b}$ かつ $\mathbf{z} = \mathbf{0}$
であるので, 問題 (2.15) の実行可能基底解は $\mathbf{x}$ に関してこれを満たす.

## 2.5
>次の最適化問題を, 線形計画問題か凸二次計画問題のいずれかに帰着せよ.
ただし, $\gamma$ および $\rho$ は正の定数である.
>
>(i) チェビシェフ近似問題:
>$$\text{Minimize } ||A\mathbf{x} - \mathbf{b}||_{\infty}$$
>(ii) $\ell_1$ ノルム正則化付きチェビシェフ近似問題:
>$$\text{Minimize } ||A\mathbf{x} - \mathbf{b}||_{\infty} + \gamma||\mathbf{x}||_1$$
>(iii) ティコノフ正則化付きチェビシェフ近似問題:
>$$\text{Minimize } ||A\mathbf{x} - \mathbf{b}||_{\infty} + \gamma||\mathbf{x}||^2_2$$
>(iv) エラスティックネット正則化付き最小2乗法:
>$$\text{Minimize } ||A\mathbf{x} - \mathbf{b}||^2_2 
>+ \gamma||\mathbf{x}||^2_2 + \rho||\mathbf{x}||_1$$

### 2.5 (i)
$\begin{aligned}
\text{Minimize } & y \\
\text{subject to } & A\mathbf{x} - \mathbf{b} \ge -y\mathbf{1} \\
& A\mathbf{x} - \mathbf{b} \le y\mathbf{1} 
\end{aligned}$

### 2.5 (ii)
$\begin{aligned}
\text{Minimize } & y + \gamma \mathbf{1}^T\mathbf{z}\\
\text{subject to } & A\mathbf{x} - \mathbf{b} \ge -y\mathbf{1} \\
& A\mathbf{x} - \mathbf{b} \le y\mathbf{1} \\
& \mathbf{x} \ge -\mathbf{z} \\
& \mathbf{x} \le \mathbf{z} \\
\end{aligned}$

### 2.5 (iii)
$\begin{aligned}
\text{Minimize } & y + \gamma \mathbf{x}^T\mathbf{x}\\
\text{subject to } & A\mathbf{x} - \mathbf{b} \ge -y\mathbf{1} \\
& A\mathbf{x} - \mathbf{b} \le y\mathbf{1} 
\end{aligned}$

### 2.5 (iv)
$\begin{aligned}
\text{Minimize } & \mathbf{x}^T(A^TA + \gamma I)\mathbf{x} - 
2\mathbf{b}^T A\mathbf{x} + \rho \mathbf{1}\mathbf{z}\\
\text{subject to } & \mathbf{x} \ge -\mathbf{z} \\
& \mathbf{x} \le \mathbf{z}
\end{aligned}$

## 2.6
>サポートベクターマシンに関連する次の問いに答えよ.
>
>(i) 問題 (2.45) を問題 (2.33) の形に直した時, $Q, A, \mathbf{b}, \mathbf{c}$はどのようになるか.
>
>(ii) 問題 (2.43) において, 関数 $\phi$ を
>$$\phi(z) = \begin{cases}0 & z \ge 1 \\ (z - 1)^2 & z < 1 \end{cases}$$
>で定義する. この時, 問題 (2.43) を凸二次計画問題 (2.33) の形に直せ.

### 2.6 (i)
決定変数は$\mathbf{\omega}, v, \mathbf{e}$ であるが,
$\mathbf{\omega}, v$ は負の数も取りうる.
またスラック変数 $\mathbf{z}$ を導入すると, 決定変数は以下のように定義できる.
$$\mathbf{x} = \begin{pmatrix} \mathbf{\omega}^{+} & \mathbf{\omega}^{-} &
v^{+} & v^{-} & \mathbf{e} &  \mathbf{z} \end{pmatrix}^T$$

また, $\mathbf{t} = \begin{pmatrix}t_1 & \dots & t_r\end{pmatrix}^T$ と
$U = \begin{pmatrix}t_1\mathbf{s}_1 & \dots & t_r\mathbf{s}_r\end{pmatrix}^T$
を定義すると, この問題は以下のように書き換えられる.
$$\begin{aligned}
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
\end{aligned}$$

### 2.6 (ii)
$\phi(z) = \min_e \{e^2 | z + e \ge 1, e \ge 0\}$ と書き換えられることに注目すると,
前問と比べて異なる点は,
目的関数が $\mathbf{\omega}^T\mathbf{\omega} + \gamma \mathbf{e}^T\mathbf{e}$
である点のみである. したがって,
$$\begin{aligned}
&\min_{\mathbf{x}} \frac{1}{2}\mathbf{x}^T\begin{pmatrix}
2I & -2I & O & O & O & O \\
-2I & 2I & O & O & O & O \\
O & O & O & O & O & O \\
O & O & O & O & O & O \\
O & O & O & O & 2\gamma I & O \\
O & O & O & O & O & O \\
\end{pmatrix}\mathbf{x} \\
&\text{s.t. } \begin{pmatrix}U & -U & \mathbf{t} & -\mathbf{t} & I & -I\end{pmatrix}\mathbf{x} = \mathbf{1},\,\mathbf{x} \ge \mathbf{0}
\end{aligned}$$