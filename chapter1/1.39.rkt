#lang racket
;; 用迭代版本实现
(define (cont-frac n d k)
  (define (iter i result)
    (if (= 1 i)
        (/ (n i) (+ (d i) result))
        (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter k (/ (n k) (d k))))

(define (tan-cf x k)
  (let ((square-x (* x x)))
   (cont-frac 
          (lambda(i) 
            (if (= i 1) 
                i
                (- 0 square-x)))
          (lambda(i) 
            (- (* 2 i) 1))   ;;这里写成了× 2 x, 一直不对。
          k)))

(exact->inexact (tan-cf 1 10))
(exact->inexact (tan-cf 1 100))
(exact->inexact (tan-cf 1 10000))