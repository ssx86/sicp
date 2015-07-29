#lang racket
(define (for-each f l)
  (if (null? l)
      '()
      (begin
        (f (car l))
        (for-each f (cdr l)))))

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

;;在如何连续做两件事情上纠结了半天，然后学会了begin。。。