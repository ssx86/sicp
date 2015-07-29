#lang racket

(define (fringe l)
  (cond ((null? l) '())
        ((pair? l) (append (fringe (car l)) (fringe (cdr l))))
        (else (list l))))

(define x (list (list 1 2) (list 3 4)))
(fringe x)
(fringe (list x (list x x (list x))))