#lang r5rs

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))
;; 这段代码的作用是链表倒置

(define x (mystery '(a b b a a b b b )))
(display x)
