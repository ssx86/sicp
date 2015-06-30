#lang racket

(define (sqt-iter guess x)
  (if (good-enough? guess x)
    (exact->inexact guess)
    (sqt-iter (improve guess x) 
              x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (square x)
  (* x x)) 

(define (improve guess x)
  (everage guess (/ x guess)))

(define (everage x y)
  (/ (+ x y) 2))

(define (sqt x)
  (sqt-iter 1 x))

(sqt 1)
(sqt 10)
(sqt 25)

;; new-if
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

;; new-if version sqt-iter
(define (new-sqt-iter guess x)
  (new-if (good-enough? guess x)
    (exact->inexact guess)
    (new-sqt-iter (improve guess x) 
              x)))

(define (new-sqt x)
  (new-sqt-iter 1 x))

(new-sqt 1)
(new-sqt 10)
(new-sqt 25)

;; new-if 会导致死循环
;; 原因是1.1.6中说的，if, cond都是特殊形式，而new-if是普通函数
;; 对cond和if来说，后面的参数会按需求值，而new-if按照应用序把else-clause直接求值，在这里直接产生了死循环
