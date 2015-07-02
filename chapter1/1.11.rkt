#lang racket
;;;如果n<3, f(n) = n;
;;;如果n>=3, f(n) = f(n-1) + 2f(n-2) + 3f(n-3)

(define (g a b c)
  (+ a (* 2 b) (* 3 c)))

(define (f1 n)
  (cond ((< n 3) n)
        (else (g (f1 (- n 1)) (f1 (- n 2)) (f1 (- n 3))))))

(f1 1)
(f1 2)
(f1 3)
(f1 4)
(f1 5)

(define (f2 n)
  (cond ((< n 3) n)
        (else (f2-iter n 3 (f2 2) (f2 1) (f2 0)))))

(define (f2-iter n count a b c)
  (cond ((= n count) (g a b c))
        (else (f2-iter n (+ 1 count)
                       (g a b c) a b))))

(f2 1)
(f2 2)
(f2 3)
(f2 4)
(f2 5)
