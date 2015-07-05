#lang racket

;; 加法代替乘法
(define (halve x)
  (/ x 2))

(define (double x)
  (* x 2))

(define (fast-multi x n)
  (cond ((= n 0) 0)
        ((even? n) (fast-multi (double x) (halve n)))
        (else (+ x (fast-multi x (- n 1))))))

(fast-multi 4 9)
