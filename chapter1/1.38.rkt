#lang racket
;; 用迭代版本实现
(define (cont-frac n d k)
  (define (iter i result)
    (if (= 1 i)
        (/ (n i) (+ (d i) result))
        (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter k (/ (n k) (d k))))

(define (e x)
  (+ 2 (cont-frac (lambda(i) 1.0)
            (lambda(i) 
              (if (= 2 (remainder i 3)) 
                  (* 2 (/ (+ i 1) 3))  ;; 2 4 6 8
                  1))
            x)))

(e 10)
(e 10000)

