#lang racket
;; 理论上素数最多检查到sqrt(n)就可以得到结论
;; 所以实际上检查的数量从sqrt(n)下降到了sqrt(n)/2
;; 考虑到虽然减少了一个remainder计算，但是增加了一个查找下个test值的计算，因此并不能达到2倍的速度

;; 代码因为上一题的精确计时问题没有解决，暂时没法写。下一次扫时一定会补上
