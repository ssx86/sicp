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

((repeated (lambda (x) (* x x))
          2) 5)

;;逐渐进入高潮了。
;;这几个高阶函数理解的并不好，没有很顺利的写出repeated, 还是看了提示用compose，
;;之前一直在纠结在else那里iter的第一个参数貌似要展开成另一个lambda函数，
;;感觉不应该这么复杂。
;;实际上复杂的原因就是少了一层抽象。

;;总之写出来了