#lang racket

(define (last-pair l)
  (if (null? (cdr l))
      l
      (last-pair (cdr l))))

;;test case:
(last-pair (list 23 72 149 34))