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

(define (make-segment start end)
  (list start end))
  
(define (start-segment segment)
  (car segment))
(define (end-segment segment)
  (cadr segment))

;;这个明显是个投机答案，但是没什么可写的，不知道具体要表示成什么样子
