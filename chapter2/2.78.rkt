#lang racket

;;get and put

(define global-array '())

(define (make-entry k v) (list k v))
(define (key entry) (car entry))
(define (value entry) (cadr entry))

(define (put op type item)
  (define (put-helper k array)
    (cond ((null? array) (list(make-entry k item)))
          ((equal? (key (car array)) k) array)
          (else (cons (car array) (put-helper k (cdr array))))))
  (set! global-array (put-helper (list op type) global-array)))

(define (get op type)
  (define (get-helper k array)
    (cond ((null? array) #f)
          ((equal? (key (car array)) k) (value (car array)))
          (else (get-helper k (cdr array)))))
  (get-helper (list op type) global-array))

(define (square x) (* x x))
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
;; if scheme-number
(define (attach-tag x y)
  (if (eq? x 'scheme-number)
      y
      (cons x y)))

;; cond scheme-number case
(define (type-tags z)
  (cond ((pair? z) (car z))
        ((number? z) 'scheme-number)
        (else
         (error "TAGS ERROR" z))))
;; cond scheme-number case
(define (contents z)
  (cond ((pair? z) (cdr z))
        ((number? z) z)
        (else
         (error "CONTENTS ERROR" z))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tags args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error "No method for these types -- APPLY-GENERIC" (list op type-tags))))))


(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number)
       (λ (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (λ (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (λ (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (λ (x y) (tag (/ x y))))
  (put 'make 'scheme-number
       (λ (x) x))
  'done)

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(install-scheme-number-package)
(define x (make-scheme-number 3))
(define y (make-scheme-number 4))
(add x y)