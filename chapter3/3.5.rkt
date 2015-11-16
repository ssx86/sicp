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

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (estimate-integral x1 x2 y1 y2 time)
  (monte-carlo time (λ ()
                      (let ([m (random-in-range x1 y1)]
                            (n (random-in-range x2 y2)))
                        (<= (+ (square m) (square n));这里不会写了。。后面明明就是R (=1) 就行了。。不知道要抽象到什么程度
                            (square (abs x1)))))))

(define pi (* 4 (estimate-integral -100 -100 100 100 50000000)))
(display (exact->inexact pi))

;; 最后一次计算的结果是: 3.14161816