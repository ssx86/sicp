#lang racket

(define (square x)
  (* x x))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items '()))

(square-list (list 1 2 3 4 5))

;;因为无论如何遍历都是从前到后的，只能用append整理出正确的顺序。之前的题错就错在这里。