#lang racket
(define (f g)
  (g 2))

(define (square x)
  (* x x))

(f square)
(f (lambda (z) (* z (+ z 1))))
(f f)

;;(f f)在调用(g 2)时，实际上扩展成了(g g)需要一个procedure，但是提供了2所以无法执行，出错