#lang racket
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

;;没有lambda哦
;;x = 2 * x
(define (double x) 
  (* x 2))
;;x = x * x * x
(define (cube x)
  (* x x x))

;;x = x + 1
(define (add-1 x)
  (+ x 1))

(sum double 1 add-1 10)

;;辛普森积分
(define (simpson f a b n)
  ;; h
  (define h (/ (- b a) n))
  
  ;; y[k]
  (define (y k)
    (f (+ a (* h k))))
  
  (define (even? x)
    (= (remainder x 2) 0))
  
  ;; term
  (define (term x)
    (cond ((= x 0) (y x))
          ((= x b) (y x))
          ((even? x) (* 2 (y x)))
          (else (* 4 (y x)))))
  ;; next
  (define (next x)
    (+ x 1))
  
  (* (/ h 3)
     (sum term 0 next n)))

(exact->inexact (simpson cube 0 1 100))
(exact->inexact (simpson cube 0 1 1000))
(exact->inexact (simpson cube 0 1 10000))
;;;这是为啥，结果倒是差不多，不过就是不一样啊
;;Welcome to DrRacket, version 6.1 [3m].
;;Language: racket; memory limit: 128 MB.
;;110
;;0.25333332333333336
;;0.2503333333323333
;;0.2500333333333332