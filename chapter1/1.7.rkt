#lang racket

(define (sqt-iter guess x last-guess)
  (if (good-enough? guess last-guess)
    (exact->inexact guess)
    (sqt-iter (improve guess x) x guess)
    ))

(define (good-enough? guess last-guess)
  (< (/ (abs (- guess last-guess)) guess) 0.0001))

(define (square x)
  (* x x)) 

(define (improve guess x)
  (everage guess (/ x guess)))

(define (everage x y)
  (/ (+ x y) 2))

(define (sqt x)
  (sqt-iter 1 x x))

(sqt 1)
(sqt 10)
(sqt 25)
