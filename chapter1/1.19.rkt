#lang racket

;; 先正确的抄题
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))
                   (+ (* 2 p q) (* q q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))
#|
a' -> bq + aq + ap
b' -> bp + aq

a'' -> (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
    -> qpb + qqa + qqb + qqa + qpa + qpb + qpa + ppa
    -> (qq + qq + qp + qp + pp)a + (qp + qq + qp)b
    -> (2qq + 2qp + pp)a + (2qp + qq)b
!!!!-> (2qp + qq)a + (2qp + qq)b + (qq + pq)a

b'' -> (bp + aq)p + (bq + aq + ap)q
    -> ppb + qpa + qqb + qqa + qpa
    -> (qp + qq + qp)a + (pp + qq)b
!!!!-> (2qp + qq)a + (pp + qq)b


so:
q' -> (2qp + qq)
p' -> (pp + qq)

|#

(fib 1)
(fib 2)
(fib 3)
(fib 4)
(fib 5)
(fib 6)
(fib 7)
(fib 8)
(fib 9)
(fib 10)

