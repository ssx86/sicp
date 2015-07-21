#lang racket

(define (square x)
  (* x x))

(define (average x y)
  (/ (+ x y) 2))

;; 1.1.7 sqrt
;;(define (sqrt x)
;;  (sqrt-iter 1.0 x))
;;
;;(define (sqrt-iter guess x)
;;  (if (good-enough? guess x)
;;      guess
;;      (sqrt-iter (improve guess x) x)))
;;
;;(define (good-enough? guess x)
;;  (< (abs (- (square guess) x)) 0.001))
;;
;;(define (improve guess x)
;;  (average guess (/ x guess)))
;
;;; 1.3.3 fixed-point
;(define (fixed-point f guess)
;  (define (close-enough? x y)
;    (< (abs (- x y)) 0.00001))
;  (let ((next (f guess)))
;    (if (close-enough? guess next)
;        next
;        (fixed-point f next))))

;;(fixed-point (lambda (y) (+ 1 (/ 1 y))) 0.1)

(define (iterative-improve judge-f improve-f)
  (define (iter guess)
    (if (judge-f guess)
        guess
        (iter (improve-f guess))))
  iter)

(define (fixed-point f guess)
  (define (close-enough? x )
    (< (abs (- x (f x))) 0.00001))
  ((iterative-improve close-enough? f) guess))


(fixed-point (lambda (y) (+ 1 (/ 1 y))) 0.1)       



(define (sqrt x)
  (define (good-enough? guess )
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  ((iterative-improve good-enough? improve) 1))

(exact->inexact (sqrt 10))

;;没想到这个题这么多坑。现在写出来的这个版本显然是有问题的。虽然结果正确，但实际上浪费了一次迭代，两个函数fixed point和sqrt行为并不一致，
;;主要原因在于一个的judge需要guess和next， 另一个的需要guess和x（sqrt x的x）因为正好群里有人说curring，就顺手马上改造成了单参数的函数。
;;等到第二次扫的时候一定要看这个题
