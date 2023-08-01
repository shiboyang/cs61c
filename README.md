# CS61C

Resources:
* [Lecture url](https://inst.eecs.berkeley.edu/~cs61c/fa20/#by-week)
* [Lab url](https://github.com/61c-teach/fa20-lab-starter/tree/master)
* [Green Card]()
* [Computer Organization and Design RISC-V Edition, 1st ed. by David Patterson, and John Hennessy](http://home.ustc.edu.cn/~louwenqi/reference_books_tools/Computer%20Organization%20and%20Design%20RISC-V%20edition.pdf)

这是一个反例，最开始考虑实现64位的乘法，然后再将最高有效位取出，电路运行结果虽然正确，但是多了很多不必要的计算，因为这种方式实现的"低64位"都是0。排查过程发现mul32其实自己一开始搞错了，模拟器内部的乘法运算器输出的结果保存在两个位置Output和Carryout上，在根据符号位重新计算product时候，需要将两个输出结果合并成一个二进制表示的整数(64bit)然后进行 * -1的计算。这是错误的原因。