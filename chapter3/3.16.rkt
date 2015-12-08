#lang r5rs

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(define x (cons 'a 'a))
(define y (cons 'b 'b))
(define z (cons x y))
(display (count-pairs z))
(newline)
(set-car! y x)
(display (count-pairs z))
(newline)

(define x2 (cons 'a 'a))
(define y2 (cons x2 x2))
(define z2 (cons y2 y2))
(display (count-pairs z2))
(set-car! z z)
;;(display (count-pairs z)) ;; never return
(newline)
