![image-20230725130304738](/home/sparkai/.config/Typora/typora-user-images/image-20230725130304738.png)

### ex1

#### NAAN XOR NOR

**Truth table**

| a    | b    | NAND | XOR  | NOR  |
| ---- | ---- | ---- | ---- | ---- |
| 0    | 0    | 1    | 0    | 1    |
| 0    | 1    | 1    | 1    | 0    |
| 1    | 0    | 1    | 1    | 0    |
| 1    | 1    | 0    | 0    | 0    |

**Boolean Algebra:**
$$
\begin{align}
y&= \overline{a}\overline{b} + \overline{a}b+ a\overline{b}\\
&=\overline{a}\overline{b}+\overline{a}b+ \overline{a}\overline{b} + a\overline{b}\\
&= \overline{a}(\overline{b}+b) + \overline{b}(\overline{a}+a)\\
&=\overline{a} + \overline{b}\\
&=\overline{ab}
\end{align}
$$
![image-20230725130701121](/home/sparkai/.config/Typora/typora-user-images/image-20230725130701121.png)

**XOR:**
$$
\begin{align}
y &= \overline{a}b + a\overline{b}
\end{align}
$$
![image-20230725131541055](/home/sparkai/.config/Typora/typora-user-images/image-20230725131541055.png)

**NOR:**
$$
\begin{align}
y &= \overline{a}\overline{b}\\
&= \overline{a+b}
\end{align}
$$
![image-20230725132139065](/home/sparkai/.config/Typora/typora-user-images/image-20230725132139065.png)

#### MUT2

**Truth Table**

> 这里使用了一种简便的方式表示真值表，如果将原始的真值表列出，我们会发现sel的行为0时，结果为
>
> a的值，sel为1时R为b的值，因此简化为下表

| Sel0 | R    |
| ---- | ---- |
| 0    | a    |
| 1    | b    |

**Boolean Algebra:**
$$
y = \overline{s}a + s b
$$
![image-20230725133545494](/home/sparkai/.config/Typora/typora-user-images/image-20230725133545494.png)

#### MUT4

**Boolean Algebra:**
$$
\begin{align}
y &= \overline{s_0}~\overline{s_1}a+\overline{s_0}s_1b+s_0\overline{s_1}c+s_0s_1d\\
&=\overline{s_0}(\overline{s_1}a + s_1b) + s_0(\overline{s_1}c+s_1d)
\end{align}
$$


![image-20230725135521762](/home/sparkai/.config/Typora/typora-user-images/image-20230725135521762.png)