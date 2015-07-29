#lang racket
(define x (list (list 1 2) (list 3 4)))
(define y (list (list 1 (list 5 6 8)) (list 3 4)))
x
;; '((1 2) (3 4))
y

(reverse x)
;; '((3 4) (1 2))
(reverse y)

(define (deep-reverse l)
  (reverse
   (map
    (lambda (x)
      (if (pair? x)
          (deep-reverse x)
          x))
    l)))

(deep-reverse x)
(deep-reverse y)
