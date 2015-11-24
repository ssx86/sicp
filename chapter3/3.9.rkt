#lang racket

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(define (factorial-2 n)
  (fact-iter 1 1 n))
(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

;; 环境1
;; 全局中有factorial, E1中n = 6,(factorial n)在E1中展开
;; 计算之后创建E2 n = 5, (* 6 (factorial n))在E2中展开
;; 计算之后创建E3 n = 4, (* 6 (* 5 (factorial n)))在E3中展开
;; ...

;; 环境2
;; 全局中有factorial-2和fact-iter
;; (factorial-2 6)在E1(n = 6)中展开
;; (fact-iter product counter max-count)在E2(product=1, counter=1, max-count=6)中展开
;; (fact-iter product counter max-count)在E3(product=1, counter=2, max-count=5)中展开
;; ...
