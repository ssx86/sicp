#lang racket

;; 原始sum函数
(define (origin-sum term a next b)
  (if (> a b)
      0
      (+ (term a) (origin-sum term (next a) next b))))

(origin-sum (lambda(x) x) 1 (lambda(x) (+ x 1)) 10)       ;; 1 + 2 + .. + 10 = 55
(origin-sum (lambda(x) (* x x)) 1 (lambda(x) (+ x 1)) 3)  ;; 1 + 4 + 9 = 14

(define (new-sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))


(new-sum (lambda(x) x) 1 (lambda(x) (+ x 1)) 10)       ;; 1 + 2 + .. + 10 = 55
(new-sum (lambda(x) (* x x)) 1 (lambda(x) (+ x 1)) 3)  ;; 1 + 4 + 9 = 14