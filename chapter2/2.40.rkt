#lang racket
;;事儿大了。。竟然发现之前写的prime?函数是个错的。怪不得这个一直结果不对。。顺便修改一下当时的代码。
(define (smallest-divisor x)
  (find-divisor x 2))

(define (square x)
  (* x x))

(define (find-divisor x n)
  (cond ((> (square n) x) x)
        ((= (remainder x n) 0) n)
        (else (find-divisor x (+ n 1)))))

(define (prime? x)
  (= x (smallest-divisor x)))

(define (enumerate-interval begin end)
  (if (> begin end)
      null
      (cons begin (enumerate-interval (+ begin 1) end))))

(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

;(define (prime-sum-pairs n)
;  (map make-pair-sum
;       (filter prime-sum?
;               (flatmap
;                (λ (i)
;                  (map (λ (j) (list i j))
;                       (enumerate-interval 1 (- i 1))))
;                (enumerate-interval 1 n)))))
;
;(prime-sum-pairs 10)

;;思路：判空之后：对每一个S的成员x做如下操作，并把结果收集起来（flatmap收集）
;;  cons x 和 remove x S之后的每一个全排列结果。

;;写错的几次是因为递归之后的结果直接传递给了lambda cons x， 实际上应该用一次map。
;;还沒写对，在下周一之前重写一次。这是抄的书上的代码

(define (permutations s)
  (if (null? s)
      (list '())
      
      (flatmap (λ (x) 
                 (map (λ (p) (cons x p))
                      (permutations (remove x s))))
               s)))

(permutations (list 1 2 3))

(define (unique-pairs n)
  (flatmap 
   (λ (i) 
     (map 
      (λ (j) 
        (list i j)) 
      (enumerate-interval 1 (- i 1)))) 
   (enumerate-interval 1 n)))



(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (unique-pairs n))))
(display "prime-sum-pairs with unique-pairs\n")

(prime-sum-pairs 8)








