#lang racket

;;基础内容练习
(define one-through-four (list 1 2 3 4 7))

(car one-through-four)
(cdr one-through-four)
(car (cdr one-through-four))
(cons 10 one-through-four)
(cons 5 one-through-four)
(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))
(list-ref one-through-four 1)
(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))
(length one-through-four)

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))
(append '(1 2 3) '(4 5 6))

;;