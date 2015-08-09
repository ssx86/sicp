#lang racket
( require ( planet "sicp.ss" ( "soegaard" "sicp.plt" 2 1)))

;;在这个实现中，经过尝试，参数只有3个，返回值是一个函数，这个函数接受的参数才是painter。调用如下
;(paint ((transform-painter (make-vect 0 0)
;                          (make-vect 0 1)
;                          (make-vect 1 0)) einstein))

;;开始题目解答：水平方向上翻转画家。

(define (flip-horiz-new painter)
  ((transform-painter (make-vect 1.0 0.0)
                      (make-vect 0.0 0.0)
                      (make-vect 1.0 1.0)) painter))

(paint einstein)
(paint (flip-horiz-new einstein))

;;逆时针 180 度
(define (skew-180 painter)
  ((transform-painter (make-vect 1.0 1.0)
                      (make-vect 0.0 1.0)
                      (make-vect 1.0 0.0)) painter))
;;逆时针 270 度
(define (skew-270 painter)
  ((transform-painter (make-vect 0.0 1.0)
                      (make-vect 0.0 0.0)
                      (make-vect 1.0 1.0)) painter))

(paint (skew-180 einstein))
(paint (skew-270 einstein))
