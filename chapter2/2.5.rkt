#lang racket

(define (multi x n)
  (define (iter result i)
    (if (= 0 i)
      result
      (iter (* result x) (- i 1))))
  (iter x (- n 1)))

(define (contain x n)
  (define (iter result i)
    (if (= 0 (remainder result n))
      (iter (/ result n) (+ i 1))
      i))
  (iter x 0))

;(multi 10 3)
;(contain 75 5)
;(contain 75 3)

(define (cons x y)
  (* (multi 2 x) (multi 3 y)))

(define (car z)
  (contain z 2))

(define (cdr z)
  (contain z 3))

(car (cons 5 2))
(cdr (cons 5 2))
