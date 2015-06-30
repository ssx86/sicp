#lang racket

(define (subtriplicate x)
  (subtriplicate-iter 1 x))

(define (subtriplicate-iter guess x)
  (printf "~a ~a\n" (exact->inexact guess) x)
  (if (good-enough? guess x)
    (exact->inexact guess)
    (subtriplicate-iter (improve guess x) x)))

(define (good-enough? x y)
  (print "good")
  (< (abs (- (* x x x) y)) 0.001))

(define (improve guess x)
  (print "improve")
  (/ 
    (+ (/ x (* guess guess)) 
      (* 2 guess)) 
    3))

(subtriplicate 8)
(subtriplicate 1000)

