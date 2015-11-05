#lang racket
;; implement a gcd function first

(define (gcd x y)
  (if (= y 0)
      x
      (gcd y (remainder x y))))

(define random-init 3)
(define rand
  (let ([x random-init])
    (λ ()
      (set! x (rand-update x))
      x)))
;; monte-carlo
(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))

(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond [(= trials-remaining 0)
           (/ trials-passed trials)]
          [(experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1))]
          [else
           (iter (- trials-remaining 1) trials-passed)])))
