#lang racket

(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))

(define (count-leaves t)
  (accumulate + 0 (map (λ (x)
                         (if (not (pair? x))
                             1
                             (count-leaves x)))
                       t)))

(count-leaves (list 1 2 (list (list 3 4) 5 (list 3 6))))