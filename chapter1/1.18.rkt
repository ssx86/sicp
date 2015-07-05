#lang racket
(define (double x)
  (* x 2))

(define (halve x)
  (/ x 2))

(define (multi x y)
  (cond ((= y 1) x)
        ((even? y) (multi (double x) (halve y)))
        (else (+ x (multi x (- y 1))))))

(multi 10 32)
