#lang racket
;;;实现一个union-set

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((< (car set1) (car set2))
         (cons (car set1) (union-set (cdr set1) set2)))
        ((= (car set1) (car set2))
         (cons (car set1) (union-set (cdr set1) (cdr set2))))
        ((> (car set1) (car set2))
         (cons (car set2) (union-set set1 (cdr set2))))))

(union-set '(1 2 5 6 7 9) '(2 3 4 5))




  