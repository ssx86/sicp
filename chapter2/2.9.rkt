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

;(interval-width (add-interval x y))
(interval-width (/ (- (+ (upper-bound x) (upper-bound y))
                      (+ (lower-bound x) (upper-bound y))) 2))
(interval-width (/ (+ (- (upper-bound x) (lower-bound x))
                      (- (upper-bound y) (lower-bound y))) 2))
(interval-width  (+ (interval-width x) (interval-width y)))
;;代换得到，width(x + y) = width(x) + width(y)

;(interval-width (sub-interval x y))
(interval-width (/ (- (- (upper-bound x) (lower-bound y))
                      (- (lower-bound x) (upper-bound y))) 2))
(interval-width (/ (+ (- (upper-bound x) (lower-bound y))
                      (- (upper-bound y) (lower-bound x))) 2))
(interval-width (/ (+ (- (upper-bound x) (lower-bound x))
                      (- (upper-bound y) (lower-bound y))) 2))
(interval-width (+ (interval-width x) (interval-width y)))
;;代换得到，width(x - y) = width(x) - width(y)