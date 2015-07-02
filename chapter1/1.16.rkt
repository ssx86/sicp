#lang racket
;; 读题开始体现智商低了。看了好几遍也没弄明白要干什么
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (fast-expt (square b) (/ n 2)))
        (else (* b (fast-expt b (- n 1))))))

(define (square x)
  (* x x))

(define (even? x)
  (= (remainder x 2) 0))

(fast-expt 3 3)

;; 实在读不懂题！！抓狂啊
