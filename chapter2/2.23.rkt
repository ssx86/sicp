#lang racket
(define (for-each f l)
  (if (null? l)
      #t
      (and (f (car l))
           (for-each f (cdr l)))))

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))
