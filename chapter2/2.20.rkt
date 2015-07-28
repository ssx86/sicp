#lang racket
(define (same-parity . l)
  (define (iter rest result first)
    (if (null? rest)
        result
        (if (= (remainder (car rest) 2) (remainder first 2))
            (iter (cdr rest) (append result (list (car rest))) first)
            (iter (cdr rest) result first))))
  (iter l '() (car l)))

(define (same-parity-new first . rest)
  (define (iter l)
    (if (null? l)
        '()
        (if (= (remainder (car l) 2) (remainder first 2))
            (cons (car l) (iter (cdr l)))
            (iter (cdr l)))))
  (iter (cons first rest)))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)
(same-parity-new 1 2 3 4 5 6 7)
(same-parity-new 2 3 4 5 6 7)
            