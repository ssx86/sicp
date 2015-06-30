#lang racket
(define (a-plus-abs-b a b)
  (if (> b 0) + -) a b)

;; (op a b)如果b是整数，则op = +, 否则op = -
