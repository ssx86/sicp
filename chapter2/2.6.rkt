#lang racket
;;终于到这个玩意儿了。。
;; church 计数

;;接受任何函数，返回一个y = x的函数
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n) (lambda (f) (lambda (x) (f ((n f) x)))))

;; so: one = (add-1 zero)
;;(define one (add-1 zero))
;;(define one (lambda (f) (lambda (x) (f ((zero f) x)))))
;;(define one (lambda (f) (lambda (x) (f (lambda (x) x)))))


;; (define (zero f x) x)
;; (define (one f x) f(lambda (x) x))

;;实在不会。。。。。
