#lang racket

;;递归版本
(define (cont-frac n d k)
  (define (iter i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (iter (+ i 1))))))
  (iter 1))

(cont-frac (lambda(i) 1.0)
           (lambda(i) 1.0)
           10000)

;;迭代版本
(define (cont-frac1 n d k)
  (define (iter i result)
    (if (= 1 i)
        (/ (n i) (+ (d i) result))
        (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter k (/ (n k) (d k))))

(cont-frac1 (lambda(i) 1.0)
            (lambda(i) 1.0)
            10000)

;;没问题，递归的慢很多～
      