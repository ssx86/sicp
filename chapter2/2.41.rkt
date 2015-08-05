#lang racket

;;生成序列
(define (enumerate-interval begin end)
  (if (> begin end)
      null
      (cons begin (enumerate-interval (+ begin 1) end))))
(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))

;;resolver
(define (gen-three-number max)
  (flatmap
   (λ (i)
     (flatmap 
      (λ (j)
        (map 
         (λ (k)
           (list k j i))
         (enumerate-interval 1 (- j 1))))
      (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 (- max 1))))

(gen-three-number 7)
(define (gen-sum n)
  (filter
   (λ (lst)
     (= (accumulate + 0 lst) n))
   (gen-three-number n)))
(gen-sum 9)