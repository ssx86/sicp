#lang racket

(define (circle x)
  (let ([point-list null])
    (define (helper lst)
      (cond [(not (pair? lst)) #f]
            [(memq lst point-list) #t]
            [else
             (begin
               (set! point-list (cons lst point-list))
               (or (helper (car lst))
                   (helper (cdr lst))))]))
    (helper x)))

(define x (cons 'a 'a))
(define y (cons 'b 'b))
(define z (cons x y))

(display (circle z))

(define z2 (cons x x))
(display (circle z2))
