#lang racket

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate combiner null-value term (next a) next b))))

(define (accumulate2 combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (term a)))))
  (iter a null-value))


(define (sum a b)
  (accumulate (lambda(x y) (+ x y)) 0 (lambda(x) x) a (lambda(x) (+ x 1)) b))

(define (sum2 a b)
  (accumulate2 (lambda(x y) (+ x y)) 0 (lambda(x) x) a (lambda(x) (+ x 1)) b))

(sum 0 10)
(sum2 0 10)