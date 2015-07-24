#lang racket

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))


(define (make-interval a b) (cons a b))


(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))

(define (interval-width x)
  (/ (- (upper-bound x) (lower-bound x)) 2))

(define (make-center-percent c p)
  (make-interval (- c (* c p)) (+ c (* c p))))

(define (percent i)
  (/ (/ (- (upper-bound i) (lower-bound i)) 2)
     (center i)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define a (make-center-percent 1000 0.0001))
(define b (make-center-percent 300 0.0002))

(percent (div-interval a a))
(percent (div-interval a b))
;;0.00019999999800004474
;;0.0002999999940000342