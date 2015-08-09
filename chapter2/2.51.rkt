#lang racket
( require ( planet "sicp.ss" ( "soegaard" "sicp.plt" 2 1)))

(define (below-new p1 p2)
  (let ((bottom
         ((transform-painter (make-vect 0.0 0.0)
                             (make-vect 1.0 0.0)
                             (make-vect 0.0 0.5)) p1))
        (top
         ((transform-painter (make-vect 0.0 0.5)
                             (make-vect 1.0 0.5)
                             (make-vect 0.0 1.0)) p2)))
    (λ (frame)
      (bottom frame)
      (top frame))))

;;顺时针 90 度
(define (skew-left-90 painter)
  ((transform-painter (make-vect 0.0 1.0)
                      (make-vect 0.0 0.0)
                      (make-vect 1.0 1.0)) painter))
(define (skew-right-90 painter)
  ((transform-painter (make-vect 1.0 0.0)
                      (make-vect 1.0 1.0)
                      (make-vect 0.0 0.0)) painter))
                       
(define (below-new-2 p1 p2)
  (skew-right-90 (beside (skew-left-90 p1)
                         (skew-left-90 p2))))

(paint (below-new einstein einstein))
(paint (below-new-2 einstein einstein))
