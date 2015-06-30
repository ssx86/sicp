#lang racket
(define (max-3 x y z)
  (cond ((and (>= y x) (>= z x)) (+ y z))
        ((and (>= x y) (>= z y)) (+ x z))
        ((and (>= x z) (>= y z)) (+ x y))
        ))

;; test:
(define (test x y z res)
  (printf "case: ~a ~a ~a, respected: ~a\n" x y z res)
  (= res (max-3 x y z)))


(test 1 2 3 5)
(test -1 2 3 5)
(test 4 4 4 8)
(test 1 1 9 10)
(test 1 1 -9 2)
