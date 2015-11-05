#lang racket
;; 增加连续访问7次就call-the-cops的功能
(define (make-account balance password)
  (define error-count 0)
  (define (call-the-cops)
    (printf "call the cops!!\n"))
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
        (λ (whatever)
          (begin (set! error-count (+ 1 error-count))
                 (if (>= error-count 7)
                     (call-the-cops)
                     "Incorrect password")))
        (cond [(eq? m 'withdraw) withdraw]
              [(eq? m 'deposit) deposit]
              [else (error "Unknown request -- MAKE_ACCOUNT"
                           m)])))
  dispatch)

(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)
; 60
((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
;; call the cops!!
((acc 'some-other-password 'deposit) 50)
;; call the cops!!
((acc 'some-other-password 'deposit) 50)
;; call the cops!!
