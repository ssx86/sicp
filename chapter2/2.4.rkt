#lang racket
(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

;;带入
(car (cons 'x 'y))

( (cons 'x 'y) (lambda (p q) p))

( (lambda (m) (m 'x 'y)) (lambda (p q) p))

( (lambda (p q) p) 'x 'y )

'x 
