#lang racket

;;是否可以使用atom?
(define (atom? a)
  (and (not (null? a))
       (not (pair? a))))

;(atom? '1)
;(atom? '(3 4))
;(atom? 'a)

(define (equal? l1 l2)
  (if (or (and (null? l1) (null? l2))
          (and (atom? l1) (atom? l2) (eq? l1 l2))
          (and (pair? l1)
               (pair? l2)
               (equal? (car l1) (car l2))
               (equal? (cdr l1) (cdr l2))))
      #t
      #f))

(equal? '() '())
(equal? '(a b c) '(a b c))
(equal? 'b 'c)
(equal? '(a b c) 3)