#lang racket

(define (square x)
  (* x x))

;; monte-carlo
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond [(= trials-remaining 0)
           (/ trials-passed trials)]
          [(experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1))]
          [else
           (iter (- trials-remaining 1) trials-passed)]))
  (iter trials 0))

;; 刚刚查了手册，random函数不接受参数的时候返回0-1之间的随机数，否则返回整数
;; 因此修改一下这个实现,精确多了
(define (random-in-range low high)
  (let ([range (- high low)])
    (+ low (* range
              (random)))))

(define (estimate-integral x1 x2 y1 y2 time)
  (* 4
     (monte-carlo time (λ ()
                         (let ([m (random-in-range x1 y1)]
                               (n (random-in-range x2 y2)))
                           (< (+ (square m) (square n));这里不会写了。。后面明明就是R (=1) 就行了。。不知道要抽象到什么程度
                               1))))))

(define pi  (estimate-integral -1 -1 1 1 50000000))
(display (exact->inexact pi))

;; 最后一次计算的结果是: 3.14161816
