#lang racket

(define (subtriplicate x)

  (define (subtriplicate-iter guess)
    (if (good-enough? guess)
      guess
      (subtriplicate-iter (improve guess)) 
      ))

  (define (good-enough? y)
    (< (abs (- (* y y y) x)) 1))

  (define (improve guess)
    (/ 
      (+ (/ x (* guess guess)) 
         (* 2 guess)) 
      3))

  (subtriplicate-iter 1.0))


(subtriplicate 8)
(subtriplicate 1000)

;; 这里遇到一个大坑，iter调用的时候初始如果传递1，会迭代速度异常慢
;; 看别人答案发现是1.0，尝试了一下就可以求解了，暂时还不知道为什么。
