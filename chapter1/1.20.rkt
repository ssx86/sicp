#lang racket
(define (GCD a b)
  (if (= b 0)
      a
      (GCD b (remainder a b))))

(GCD 50 30)
(GCD 30 50)

;;正则序 206 40
(GCD 206 40)
(if (= 40 0)
    40
    (GCD 40 (remainder 206 40)))
#|
(if (= 40 0)
    40
    ...)
|#

;;太长，不知道什么时候规约。。

;;应用序
(GCD 206 40)
(GCD 40 6)
(GCD 6 4)
(GCD 4 2)
(GCD 2 0)
2