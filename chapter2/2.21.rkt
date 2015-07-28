#lang racket

(define (square x)
  (* x x))

;; 因为没看完题就开始写了，所以先写了一个自己的实现
(define (square-list l)
  (map (lambda (x) (square x)) l))

(square-list (list 1 2 3 4))

;;上面的完成了map版本的实现。下面是手动递归实现
(define (square-list2 items)
  (if (null? items)
      '()
      (cons (square (car items)) (square-list2 (cdr items)))))

(square-list2 (list 1 2 3 4))