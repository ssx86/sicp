#lang r5rs

(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))
(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define x (list 'a 'b))
(define y (list 'c 'd))

(define z (append x y))
(display z)

(display (cdr x))
; (b)

(define w (append! x y))

(display w)

(display (cdr x))
;; (b c d)
