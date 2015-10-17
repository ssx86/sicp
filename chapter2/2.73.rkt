#lang racket

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

;
;(define (deriv exp var)
;  (cond ((number? exp) 0)
;        ((variable? exp)
;         (if (same-variable? exp var) 1 0))
;        ((sum? exp)
;         (make-sum (deriv (addend exp) var)
;                   (deriv (augend exp) var)))
;        ((product? exp)
;         (make-sum
;          (make-product (multiplier exp)
;                        (deriv (multiplicand exp) var))
;          (make-product (deriv (multiplier exp) var)
;                        (multiplicand exp))))
;         ;;2.56 幂运算
;        ((exponentiation? exp)
;         (let ((n (exponent exp))
;               (u (base exp)))
;           (make-product n (make-product (make-exponentiation u (- n 1)) (deriv u var)))))
;        (else
;         (error "unknown expression type -- DERIV" exp))))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp)
                                           var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(put 'deriv '+ (λ (exp var)
                 (make-sum (deriv (addend exp) var)
                           (deriv (augend exp) var))))

(put 'deriv '* (λ (exp var)
                 (make-sum
                  (make-product (multiplier exp)
                                (deriv (multiplicand exp) var))
                  (make-product (deriv (multiplier exp) var)
                                (multiplicand exp)))))

(put 'deriv '** (λ (exp var)
                  (let ((n (exponent exp))
                        (u (base exp)))
                    (make-product n (make-product (make-exponentiation u (- n 1)) (deriv u var))))))

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))
(define (=number? exp num)
  (and (number? exp) (= exp num)))
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))
(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (car s))  ;;changed from cadr
(define (augend s) (cadr s)) ;;changed from caddr

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))
(define (multiplier p) (car p))     ;;changed from cadr
(define (multiplicand p) (cadr p))  ;;changed from caddr
(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))
(define (base x)
  (car x))   ;changed from cadr
(define (exponent x)
  (cadr x))  ; changed from caddr
(define (make-exponentiation base exponent)
  (cond ((= exponent 1) base)
        ((= exponent 0) 1)
        (else (list '** base exponent))))
    


;(deriv '(+ (+ 1 (* x 3)) 4) 'x) ;;看不出来对错
;(deriv '(* x 45) 'x)


;;a) 因为数据的类型标识缺失，对于number?和same-variable?函数来说，参数中没有任何识别数据类型的项
;;b) 代码如上
;;c) 代码如上
;;d) 反向索引，只需要把put语句改变一下两个参数的位置即可

(deriv '(+ (* 3 x) (* x x)) 'x)
(deriv '(** x 3) 'x)
(deriv (deriv '(** x 3) 'x) 'x)