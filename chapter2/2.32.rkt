#lang racket

;;子集
(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x)
                            (append x (list (car s)))
                            ) rest)))))

(subsets (list 1 2 3 ))
