#lang racket
(define (double f)
  (lambda (x)
    (f (f x))))

(define (inc x)
  (+ x 1))

((double inc) 3)

(((double double) inc) 5)

(((double (double double)) inc) 5)

;;分析：
;; double让后面的函数对参数执行两次运算
;; 因此(double double)返回了一个函数，让作为它参数的那个函数连续调用4次
;; 因此(double (double double))返回了一个函数，这个函数执行了(double double) 两次, 相当于连续调用了16次
;; （并没有才对。。分析是按照结果写的）
;; 所以结果是21