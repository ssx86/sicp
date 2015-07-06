#lang racket
(define (smallest-divisor x)
  (find-divisor x 2))

(define (find-divisor x test-divisor)
  (cond ((> (* test-divisor test-divisor) x) x)
        ((= 0 (remainder x test-divisor)) test-divisor)
        (else (find-divisor x (+ test-divisor 1)))))

(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)

