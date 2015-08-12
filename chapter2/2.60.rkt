#lang racket
(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (adjoin-set (car set1)             ;;突发奇想。cons改成了adjoin-set
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (append set1 set2))                       ;;这里不再需要啰嗦的判断，都加在一起即可

(intersection-set '(1 2 2 3 4 5) '(2 3 4 5 6))