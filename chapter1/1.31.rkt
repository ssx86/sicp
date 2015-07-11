#lang racket
;; 
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
    (iter a 1))

;; 1*2*3*4*5 = 120
(product (lambda(x) x) 1 (lambda(x) (+ x 1)) 5)

(define (even? x)
  (= (remainder x 2) 0))

;;假设从0开始
(define (term x)
  (cond ((even? x) (/ (+ 2 x) (+ 3 x)))
        (else (/ (+ 3 x) (+ 2 x)))))


(define (next x)
  (+ x 1))

(define (factorial x)
  (* 4 (product term 0 next x)))

(exact->inexact (factorial 50000))

;;已经由递归改成迭代了。没问题～。之前的sum在例题中