#lang racket

(define (inc x)
  (cond ((= x 0) 1)
        ((= x 1) 2)
        ((= x 2) 3)
        ((= x 3) 4)
        ((= x 4) 5)
        ((= x 5) 6)
        ((= x 6) 7)
        ((= x 7) 8)
        ((= x 8) 9)
        ((= x 9) 10)))

(define (dec x)
  (cond ((= x 10) 9)
        ((= x 9) 8)
        ((= x 8) 7)
        ((= x 7) 6)
        ((= x 6) 5)
        ((= x 5) 4)
        ((= x 4) 3)
        ((= x 3) 2)
        ((= x 2) 1)
        ((= x 1) 0)))

;
;(define (+ a b)
;	(if (= a 0)
;		b
;		(inc (+ (dec a) b))))

(+ 4 5)
(inc (+ 3 5))
(inc (inc (+ 2 5) ))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9

;
;(define (+ a b)
;	(if (= a 0)
;		b
;		(+ (dec a) (inc b))))

(+ 4 5)
(+ 3 6)
(+ 2 7)
(+ 1 8)
(+ 0 9)
9


