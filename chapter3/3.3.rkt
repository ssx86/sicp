#lang racket
;; 修改make-account过程，使它能创建一种带密码保护的账户。
(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch pwd m)
    (if (not (eq? pwd password))
        (λ (whatever) "Incorrect password")
        (cond [(eq? m 'withdraw) withdraw]
              [(eq? m 'deposit) deposit]
              [else (error "Unknown request -- MAKE_ACCOUNT"
                           m)])))
  dispatch)

(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)
; 60
((acc 'some-other-password 'deposit) 50)
; "Incorrect password"
