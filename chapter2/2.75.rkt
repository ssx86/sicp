#lang racket

(define (make-from-mag-ang mag ang)
  (define (dispath op)
    (cond ((eq? op 'real-part)
           (* mag (cos ang)))
          ((eq? op 'imag-part)
           (* mag (sin ang))
          ((eq? op 'magnitude) mag)
          ((eq? op 'angle) ang)
          (else
           (error "unknown op -- MAKE-FROM-MAG-ANG" op)))))
  dispacth)
;;照抄，没过脑子。