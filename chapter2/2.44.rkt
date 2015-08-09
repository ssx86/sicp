#lang racket
 ( require ( planet "sicp.ss" ( "soegaard" "sicp.plt" 2 1)))


(define wave einstein)

;(paint (flip-horiz wave))
;(paint (beside wave (flip-horiz wave)))
(define wave2 (beside wave (flip-vert wave)))
;(define wave4 (below wave2 wave2))
(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

(define wave4 (flipped-pairs wave))

;(paint wave4)

(define (right-split painter n )
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1))))
        ;(below (beside up up) painter))))
        (below painter (beside up up)))))
;(paint (right-split wave 4))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(paint (corner-split wave 4))




