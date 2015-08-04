#lang racket

(define (smallest-divisor x)
  (find-divisor x 2))

(define (square x)
  (* x x))

(define (find-divisor x n)
  (cond ((>= (square n) x) x)
        ((= (remainder x n) 0) n)
        (else (find-divisor x (+ n 1)))))

(define (prime? x)
  (= x (smallest-divisor x)))

(define (enumerate-interval begin end)
  (if (= begin end)
      (list begin)
      (cons begin (enumerate-interval (+ begin 1) end))))

(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                (λ (i)
                  (map (λ (j) (list i j))
                       (enumerate-interval 1 (- i 1))))
                (enumerate-interval 1 n)))))

(prime-sum-pairs 1)



(define (permutations s)
  (if (null? s)
      '()
      (accumulate append '()
                  (map (λ (x) (cons x (permutations (remove x s)))) s))))
           
(permutations (list 1 2 3))