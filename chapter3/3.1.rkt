#lang racket

;; init with 100

(define withdraw
  (let ([balance 100])
    (λ (x)
    (if (<= balance x)
        (printf "Insufficient funds\n")
        (begin
          (set! balance (- balance x))
          balance)))))

(withdraw 25)
(withdraw 25)
(withdraw 60)
(withdraw 15)

(define (make-withdraw balance)
  (λ (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))

(define W1 (make-withdraw 100))
(define W2 (make-withdraw 100))

(W1 50)
(W2 70)
(W2 40)
(W1 40)

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond [(eq? m 'withdraw) withdraw]
          [(eq? m 'deposit) deposit]
          [else (error "unknown request -- MAKE-ACCOUNT" m)]))
  dispatch)

(define account (make-account 100))
((account 'deposit) 3000)
((account 'withdraw) 500)

;; 一个累加器是一个过程，反复用数值参数调用它，就会使它的各个参数累加到
;; 一个和数中。每次调用时累加器将返回当前的累加和。
(define (make-accumulator x)
  (let ([sum x])
    (λ (n)
      (begin
        (set! sum (+ sum n))
        sum))))

(define A (make-accumulator 5))
(A 10)
(A 10)
(define B (make-accumulator 10))
(A 50)
(B 1)
(B 2)
(A 100)
