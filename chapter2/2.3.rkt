#lang racket

;;线段
(define (make-segment start end)
  (cons start end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

;;点
(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

;;打印点
(define (print-point p)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")")
  (newline))

;;先写好周长和面积计算
(define (len rect)
  (* 2 (+ (height rect) (width rect))))

(define (area rect)
  (* (height rect) (width rect)))

;;第一种系统
(define (make-rect1 height width)
  (cons height width))

(define (height rect)
  (car rect))

(define (width rect)
  (cdr rect))

(define (make-rect2 lt rb)
  (cons (- (x-point rb) (x-point lt))
        (- (y-point rb) (y-point lt))))


(len (make-rect1 10 40))
(area (make-rect1 10 40))

(len (make-rect2 (make-point 10 40) (make-point 50 90)))
(area (make-rect2 (make-point 10 40) (make-point 50 90)))


