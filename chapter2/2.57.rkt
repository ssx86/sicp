#lang racket
;;略困，状态不好。这题跳过了。和后面的一起跳过。
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ;;2.56 幂运算
        ((exponentiation? exp)
         (let ((n (exponent exp))
               (u (base exp)))
           (make-product n (make-product (make-exponentiation u (- n 1)) (deriv u var)))))
        (else
         (error "unknown expression type -- DERIV" exp))))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 rest)
  (if (null? rest)
      a1
      (let ((a2 (car rest)))
        (cond ((=number? a1 0) (make-sum a2 (cdr rest)))
              ((=number? a2 0) (make-sum a1 (cdr rest)))
              ((and (number? a1) (number? a2)) (make-sum (+ a1 a2) (cdr rest)))
              (else (list '+ a1 (make-sum a2 (cdr rest))))))))

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

(define (addend s) (cadr s))

(define (augend s)
  (if (null? (cdddr s))
      (caddr s)
      (cons '+ (cddr s))))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

(define (base x)
  (cadr x))

(define (exponent x)
  (caddr x))

(define (make-exponentiation base exponent)
  (cond ((= exponent 1) base)
        ((= exponent 0) 1)
        (else (list '** base exponent))))
    


(deriv '(+ x y y) 'x)

