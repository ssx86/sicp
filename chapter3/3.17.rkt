#lang racket

(define count-pairs
  (let ([point-list null])
    (lambda (x)
      (if (not (pair? x))
          0
          (if (member x point-list)
              (+ (count-pairs (car x))
                 (count-pairs (cdr x)))
              (begin
                (set! point-list (cons x point-list))
                (+ (count-pairs (car x))
                   (count-pairs (cdr x))
                   1)))))))

(define x (cons 'a 'a))
(define y (cons x x))
(define z (cons y y))

(display (count-pairs z))
