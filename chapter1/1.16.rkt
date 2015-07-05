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
;; 2015.7.5今天貌似突然看明白了
;; 试试看
(define (fast-expt-a b n)
  (define (iter b n a)
    (cond ((= n 0) a)
          (else (cond ((even? n)
                       (iter (square b) (/ n 2) a))
                      (else
                       (iter b (- n 1) (* a b))
                       )))))
  (iter b n 1))

(fast-expt-a 3 4)
;;貌似是这个意思吧。
;;注意一个问题，(/ n 2)又写成了(/ 2 n)
