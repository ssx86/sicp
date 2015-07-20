#lang racket
(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (lambda (x)
    (define (iter g n)
      (if (= n 1)
          (g x)
          (iter (compose f g) (- n 1))))
    (iter f n)))

(define (square x)
  (* x x))

(define (smooth f)
  (define delta 0.0001)
  (lambda (x)
    (/ (+ (f (- x delta))
            (f x)
            (f (+ x delta))) 3)))

(define smooth-square (smooth square))
(define (rep-smooth f n)
  ((repeated smooth 10) f))

;;这题有坑啊。貌似掉坑里了。
;;晚上回头看
;;刚看了一下，貌似没有什么坑，大多数人的答案跟我一样
((rep-smooth square 10) 5)