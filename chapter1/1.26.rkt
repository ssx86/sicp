#lang racket
;; (square (expmod base (/ exp 2) m))每次折半，做一次运算，相当于每一层一共遍历一次，log n
;; (* (expmod base (/ exp 2) m)
;;    (expmod base (/ exp 2) m)) 每次折半，每一半做一次操作，相当于每一层每一个节点都遍历了一次, n