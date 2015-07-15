#lang racket
;;;证明硬伤。瞎写咯
;; 黄金分割： x^2 = x + 1, 两边/x得到 x = 1 + 1/x 证毕。呵呵呵

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(exact->inexact (fixed-point (lambda(x) (+ 1 (/ 1 x))) 1))