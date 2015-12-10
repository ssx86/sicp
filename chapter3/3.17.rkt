#lang racket

(define (count-pairs x)
  (let ([point-list null])
    (define (test lst)
      (if (or (not (pair? lst))
              (memq lst point-list))
          0
          (begin
            (set! point-list (cons lst point-list))
            (+ (test (car lst))
               (test (cdr lst))
               1))))
    (test  x)))

(define x (cons 'a 'a))
(define y (cons x x))
(define z (cons y y))

(display (count-pairs z))
;; 第一次做的完全错了。不仅定义成了一个变量而不是函数，而且逻辑上，遇到之前存在的节点也没有停止，还继续探索左右子节点。
;; 现在修正了。
