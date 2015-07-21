#lang racket

(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

;;(define (make-rat n d) 
;;  (let ((g (gcd n d)))
;;    (cons (/ n g) (/ d g))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (display (numer x))
  (display "/")
  (display (denom x))
  (newline))


;;2.1 正确处理正负数

(define (make-rat n d) 
  (let ((g 
          (gcd (abs n) (abs d)))
        (sign 
          (if (< (* n d) 0) -1 1)))
    (cons (* sign (/ (abs n) g)) (/ (abs d) g))))

(print-rat (add-rat (make-rat 1 -3) (make-rat 3 5))) ;;1/3+3/5 = 14/15
(print-rat (make-rat 100 300))
(print-rat (make-rat -100 -300))
(print-rat (make-rat -100 350))
(print-rat (make-rat 150 350))
(print-rat (make-rat 150 -380))
