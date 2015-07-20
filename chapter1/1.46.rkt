#lang racket

(define (square x)
  (* x x))

(define (average x y)
  (/ (+ x y) 2))

;; 1.1.7 sqrt
(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

;; 1.3.3 fixed-point
(define (fixed-point f guess)
  (define (close-enough? x y)
    (< (abs (- x y)) 0.00001))
  (let ((next (f guess)))
    (if (close-enough? guess next)
        next
        (fixed-point f next))))

;;(fixed-point (lambda (y) (+ 1 (/ 1 y))) 0.1)

(define (iterative-improve judge-f improve-f)
  )

