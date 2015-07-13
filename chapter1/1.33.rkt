#lang racket

(define (filtered-accumulate combiner null-value term a next b filter)
  (define (iter a result)
    (cond ((> a b) result)
          ((filter (term a)) (iter (next a) (combiner result (term a))))
          (else (iter (next a) result))))
  (iter a null-value))

(define (GCD x y)
  (if (= y 0)
      x
      (GCD y (remainder x y))))

(define (smallest-divisor x)
  (define (find-divisor x y)
    (cond ((> (* y y) x) x)
          ((= (remainder x y) 0) y)
          (else (find-divisor x (+ y 1)))))
  (find-divisor x 2))

(define (prime? x)
  (cond ((= x 1) #f)
        ((= (smallest-divisor x) x) #t)
        (else #f)))

(define (prime-sum a b)
  (filtered-accumulate (lambda(x y) (+ x y))
                       0
                       (lambda(x) x)
                       a
                       (lambda(x) (+ x 1))
                       b
                       prime?))

;;(prime-sum 5 8) ;; 5 + 7 = 12

;;不会命名是硬伤
(define (fun2 n)
  (define (ok i)
    (= (GCD i n) 1))
  (filtered-accumulate (lambda(x y) (* x y))
                       1
                       (lambda(x) x)
                       1
                       (lambda(x) (+ x 1))
                       n
                       ok))

(fun2 10)



