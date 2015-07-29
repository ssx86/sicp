#lang racket

(define case1 '(1 3 (5 7) 9))
(define case2 '((7)))
(define case3 '(1 (2 (3 (4 (5 (6 7)))))))

(car (cdr (car (cdr (cdr case1)))))
(car (car case2))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr case3))))))))))))