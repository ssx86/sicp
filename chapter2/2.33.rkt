#lang racket

(define (accumulate f init seq)
  (if (null? seq)
      init
      (f (car seq)
         (accumulate f init (cdr seq)))))

;; (map)
(define (map p sequence)
  (accumulate (λ (x y) (cons (p x) y)) '() sequence))

(map (λ (x) (* x 2)) (list 2 3 4 5))
(map (λ (x) (* x x)) (list 2 3 4 5))

;; (append)
(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(append (list 3 4 5) (list 6 7 8))

;; (length)
(define (length sequence)
  (accumulate (λ (x y) (+ y 1)) 0 sequence))

(length (list 3 4 4 3 3 4 4 3)) ; 8

;;这个题很有意思。mark
