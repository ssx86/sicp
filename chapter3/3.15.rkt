#lang racket

(define x (list 'a 'b))
(define z1 (cons x x))
(define z2 (cons (list 'a 'b) (list 'a 'b)))
z1
z2

(eq? (car z1) (cdr z1))
(eq? (car z2) (cdr z2))

;; 略
