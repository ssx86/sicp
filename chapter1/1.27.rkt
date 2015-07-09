#lang racket
(define (square x)
  (* x x ))

;; 费马定律需要 得到一个数的幂对另一个数的模
(define (expmod base exp n)
  (cond ((= exp 0) 1)
        ((even? exp) 
         (remainder (square (expmod base (/ exp 2) n)) n))    ;;这里base没有直接平方,而是在取了模之后平方。第一次写错了
        (else 
         (remainder (* base (expmod base (- exp 1) n)) n))))

(define (test-mod a n)
  (= (expmod a n n) (remainder a n)))

(define (check n)
  (define (check-iter n a)
    (cond ((= a n) #t)
          (else (and (test-mod a n) (check-iter n (+ a 1))))))
  (check-iter n 1))

;; 检查Carmichael数：非素数，却能够通过费马检查
(check 561)
(check 1105)
(check 1729)
(check 2465)
(check 2821)
(check 6601)

(check 100) ; #f
(check 101) ; #t
(check 150) ; #f
(check 151) ; #t
