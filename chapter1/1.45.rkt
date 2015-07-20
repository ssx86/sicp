#lang racket
(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (lambda (x)
    (define (iter g n)
      (if (<= n 1)
          (g x)
          (iter (compose f g) (- n 1))))
    (iter f n)))

(define (average-damp f)
  (lambda (x)
    (/ (+ (f x) x) 2)))

(define (fixed-point-of-average n f guess )
  (fixed-point ((repeated average-damp n) f) guess))

(define (fixed-point f first-guess)
  (define delta 0.000001)
  (define (close-enough? x y)
    (< (abs (- x y)) delta))
  (define (iter guess)
    (if (close-enough? guess (f guess))
        (f guess)
        (iter (f guess))))
  (iter first-guess))

(define (sqrt x)
  (fixed-point-of-average 1 (lambda (y) (/ x y)) 1))

;;默写了一次fixed-point..
;;基本掌握
(define (power n x)
  (define (iter result n)
    (if (= n 0)
        result
        (iter (* result x) (- n 1))))
  (iter 1 n))

(define (nth-root-test x n test)
  (fixed-point-of-average test (lambda (y) (/ x (power (- n 1) y)))
                          1.0))
(define (nth-root x n)
  (fixed-point-of-average (lg n) (lambda (y) (/ x (power (- n 1) y)))
                          1.0))

(nth-root-test 16 3 1)

(nth-root-test 16 4 2)
(nth-root-test 16 5 2)
(nth-root-test 16 6 2)
(nth-root-test 16 7 2)

(nth-root-test 16 8 3)
(nth-root-test 16 9 3)
(nth-root-test 16 10 3)
(nth-root-test 16 11 3)
(nth-root-test 16 12 3)
(nth-root-test 16 13 3)
(nth-root-test 16 14 3)
(nth-root-test 16 15 3)

(nth-root-test 16 16 4)
;;推测出，阻尼次数是lg n
;;需要改进次数的计算方法，或者对lg n取整

;;问题是现在不会写lg函数，貌似默认没有提供
;;手写了lg函数，并且改进了repeated 次数小于等于1都结束
(define (lg x)
  (/ (log x) (log 2)))

(nth-root 100 2)
(nth-root 100 3)
(nth-root 100 22)
(nth-root 100 32)
(nth-root 100 42)
(nth-root 100 52)
