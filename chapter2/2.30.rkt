#lang racket

(define (square x)
  (* x x))

;;纯手写，和书上代码几乎完全一致～
(define (square-tree-recurv item)
  (cond ((null? item) '())
        ((not (pair? item)) (square item))
        (else (cons (square-tree-recurv (car item))
                    (square-tree-recurv (cdr item))))))

(define (square-tree-map item)
  (map (lambda (x)
         (if (pair? x)
             (square-tree-map x)
             (square x)))
       item))

(square-tree-recurv
 (list 1 (list 2 (list 3 4) 5) (list 6 7)))

(square-tree-map
  (list 1 (list 2 (list 3 4) 5) (list 6 7)))