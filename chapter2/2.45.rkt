#lang racket
 ( require ( planet "sicp.ss" ( "soegaard" "sicp.plt" 2 1)))


(define wave einstein)

;(paint (flip-horiz wave))
;(paint (beside wave (flip-horiz wave)))
;(define wave2 (beside wave (flip-vert wave)))
;(define wave4 (below wave2 wave2))
;(define (flipped-pairs painter)
;  (let ((painter2 (beside painter (flip-vert painter))))
;    (below painter2 painter2)))

;(define wave4 (flipped-pairs wave))

(define (split m1 m2)
  (define (iter painter n)
    (if (= n 0)
        painter
        (let ((smaller (iter painter (- n 1))))
          (m1 painter (m2 smaller smaller)))))
  iter)
(define right-split (split beside below))
(define up-split (split below beside))

(paint (right-split wave 9))

(paint (up-split wave 9))