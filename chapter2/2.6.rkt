#lang racket
;;终于到这个玩意儿了。。
;; church 计数

;;接受任何函数，返回一个y = x的函数
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n) (lambda (f) (lambda (x) (f ((n f) x)))))

;; so: one = (add-1 zero)
;(define one (add-1 zero))
;(define one (lambda (f) (lambda (x) (f ((zero f) x)))))
;(define one (lambda (f) (lambda (x) (f ((lambda (x) x) x)))))
(define one (lambda (f) (lambda (x) (f x))))

;(define two (add-1 one))
;(define two (lambda (f) (lambda (x) (f ((one f) x)))))
;(define two (lambda (f) (lambda (x) (f ((lambda (x) (f x)) x)))))
(define two (lambda (f) (lambda (x) (f (f x)))))

(define three (lambda (f) (lambda (x) (f (f (f x))))))

(define (inc x)
  (+ x 1))

((zero inc) 0)
((one inc) 0)
((two inc) 0)
((three inc) 0)

(define (add m n) (lambda (f) (lambda (x) ((m f) ((n f) x)))))

(define five (add two three))
(define eight (add five three))
((eight inc) 10)

