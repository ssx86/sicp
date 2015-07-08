#lang racket
;;; 首先默写fast-expt
;(define (fast-expt base exp)
;  (define (even? x)
;    (= (remainder x 2) 0))
;  (cond ((= exp 0) 1)
;        ((even? exp) (* base base) (/ exp 2))
;        (else (* base (fast-expt base (- exp 1))))))
;
;;;经检查，又特么写错了
;; 这里就是square为什么不展开成*的那个题。。
(define (even? x)
  (= (remainder x 2) 0))
(define (square x)
  (* x x))

(define (fast-exp b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-exp b (/ n 2))))
        (else (* b (fast-exp b (- n 1))))))

;;然后 expmod
(define (expmod base exp m)
  (remainder (fast-exp base exp) m))
;;下面这个又写的乱七八糟。TODO
(define (expmod1 base exp m)
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod1 base (/ exp 2) m)) m))
        (else (remainder (* base (expmod1 base (- exp 1) m)) m))))

(expmod 3 4 5)
(expmod1 3 4 5)

;;结论倒是很简单。因为在整个过程中expmod不停的在消化每一步的结果，每次递归都会取模，
;;而expmod全程生硬的乘上去得到一个巨大的数字，不仅在乘法上越来越慢，最后取模也会影响