#lang racket
;;跳过这个题先~
(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))

(define m1 '((1 2 3 4) (4 5 6 6) (6 7 8 9)))

;;dot-product
(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(dot-product m1 m1)
(map * (list 1 2 3) (list 2 3 4))