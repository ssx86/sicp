#lang racket
;; 重写一次smallest-divisor

(define (smallest-divisor x)
  (find-divisor x 2))

(define (find-divisor x n)
  (cond ((> (square n) x) x)
        ((= (remainder x n) 0) n)
        (else (find-divisor x (+ n 1)))))

(define (prime? x)
  (= x (smallest-divisor x)))


;; TODO: 第二遍时重新默写一次expmod

(define (square x)
  (* x x))

(define (even? x)
  (= (remainder x 2) 0))

;; TODO: 有一个疑问。if必须写else，那么我如果只需要在成立的时候做某个事情，如何才能不写空的else？
;; http://stackoverflow.com/questions/5751052/how-does-if-statement-work-in-scheme
;; http://stackoverflow.com/questions/10863192/why-is-one-armed-if-missing-from-racket
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-milliseconds)))

(define (start-prime-test n start-time)
  (when (prime? n)
      (report-prime (- (current-milliseconds) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (find-3-prime from)
  (find-3-prime-iter from 3))

(define (find-3-prime-iter from n)
  (cond ((= n 0) #t)
        ((timed-prime-test from) (find-3-prime-iter (+ from 1) (- n 1)))
        (else (find-3-prime-iter (+ from 1) n))))

(find-3-prime 1000)
(find-3-prime 10000)
(find-3-prime 100000)
(find-3-prime 1000000)

;;貌似精度不足。留下问题下面再处理了


;; 费马定律需要 得到一个数的幂对另一个数的模
(define (expmod base exp n)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) n)) n))    ;;这里base没有直接平方，而是在取了模之后平方。第一次写错了
        (else
         (remainder (* base (expmod base (- exp 1) n)) n))))
