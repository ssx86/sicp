#lang racket

;;子集
(define (subsets s)
  (if (null? s)
      '()
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x)  x) rest)))))

(subsets (list 1 2 3 4 5 6 7))
