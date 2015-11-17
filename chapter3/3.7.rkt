#lang racket
;; 修改make-account过程,使它能创建一种带密码保护的账户。
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

(define peter-acc (make-account 100 'open-sesame))
((peter-acc 'open-sesame 'withdraw) 40)
; 60

(define (make-joint account old-password new-password)
  (let ([inner-account account])
    (λ (pwd m)
      (if (eq? pwd new-password)
          (account old-password m)
          (account new-password m)))))

(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))
((paul-acc 'rosebud 'withdraw) 40)