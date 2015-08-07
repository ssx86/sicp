#lang racket
(define (fold-right op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (fold-right op init (cdr seq)))))

(define (fold-left op init seq)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter init seq))

(define (reverse-right sequence)
  (fold-right (λ (x y) (append y (list x))) '() sequence))

(define (reverse-left sequence)
  (fold-left (λ (x y) (append (list y) x)) '() sequence))


(reverse-right (list 1 2 3 4 5))
(reverse-left (list 1 2 3 4 5))

