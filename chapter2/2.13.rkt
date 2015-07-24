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

;;验证
(define test (make-center-percent 100 0.01))
(lower-bound test)
(upper-bound test)
(center test)
(percent test)

(define c1 100)
(define p1 0.01)
(define c2 200)
(define p2 0.12)
(interval-width (mul-interval (make-center-percent c1 p1)
                              (make-center-percent c2 p2)))
(interval-width (mul-interval (make-interval (- c1 (* c1 p1)) (+ c1 (* c1 p1)))
                              (make-interval (- c2 (* c2 p2)) (+ c2 (* c2 p2)))))
(interval-width (make-interval (* (- c1 (* c1 p1)) (- c2 (* c2 p2)))
                               (* (+ c1 (* c1 p1)) (+ c2 (* c2 p2)))))
(interval-width (make-interval (* (* c1 (- 1 p1)) (* c2 (- 1 p2)))
                               (* (* c1 (+ 1 p1)) (* c2 (+ 1 p2)))))
(interval-width (make-interval (* c1 c2 (- 1 p1) (- 1 p2))
                               (* c1 c2 (+ 1 p1) (+ 1 p2))))
(interval-width (make-interval (* c1 c2 (+ 1 (- p1) (- p2) (* p1 p2)))
                               (* c1 c2 (+ 1 p1 p2 (* p1 p2)))))
(interval-width (make-center-percent (* c1 c2 (+ 1 (* p1 p2)))
                                     (/ (+ p1 p2) (+ 1 (* p1 p2)))))
;;so p(x*y) = ( (p(x)+p(y) ) / (1 + p(x) * p(y))

