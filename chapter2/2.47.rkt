#lang racket
;
;(define (make-frame origin edge1 edge2)
;  (list origin edge1 edge2))
;(define (origin-frame frame)
;  (car frame))
;(define (edge1-frame frame)
;  (cadr frame))
;(define (edge2-frame frame)
;  (caddr frame))
;


(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
(define (origin-frame frame)
  (car frame))
(define (edge1-frame frame)
  (cadr frame))
(define (edge2-frame frame)
  (cddr frame))

;test

(origin-frame (make-frame 3 4 5))
(edge1-frame (make-frame 3 4 5))
(edge2-frame (make-frame 3 4 5))