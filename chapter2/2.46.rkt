#lang racket

(define (make-vect x y)
  (list x y))
(define (xcor-vect v)
  (car v))
(define (ycor-vect v)
  (cadr v))

(define (add-vec x y)
  (make-vect (+ (xcor-vect x)
                (xcor-vect y))
             (+ (ycor-vect x)
                (ycor-vect y))))

(define (sub-vec x y)
  (make-vect (- (xcor-vect x)
                (xcor-vect y))
             (- (ycor-vect x)
                (ycor-vect y))))

(define (scale-vect v n)
  (make-vect (* n (xcor-vect v))
             (* n (ycor-vect v))))
