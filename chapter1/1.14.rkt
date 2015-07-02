#lang racket

;;; 1, 5, 10, 25, 50 => 11
;;; code:

(define (count-charge amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (= kinds-of-coins 0) (< amount 0)) 0)
        (else (+ (cc (- amount
                        (first-denomination kinds-of-coins)) kinds-of-coins)
                 (cc amount
                     (- kinds-of-coins 1))))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-charge 100)

(count-charge 11)
;; 1+5+10+25+50 => 11
;; (1+5+10+25)=>11 + (1+5+10+25+50)=>-39
;; (1+5+10)=>11 + (1+5+10+25)=>-14
;; (1+5)=>11 + (1+5+10)=>1
;; (1)=>11 + (1+5)=>6  +  (1+5)=>1 + (1+5+10)=>-9
;; ()=>11 + (1)=> 10 + (1)=>6 + (1+5)=>1 + (1)=>1 + (1+5)=>-4
;; (1)=>9 + (1)=>5 + (1)=>1 + (1+5)=>-4 + (1)=>0
;; (1)=>8 + (1)=>4 + (1)=>0 + 1
;; (1)=>7 + (1)=>3 + 1 + 1
;; (1)=>6 + (1)=>2 + 1 + 1
;; (1)=>5 + (1)=>1 + 1 + 1
;; (1)=>4 + (1)=>0 + 1 + 1
;; (1)=>3 + 1 + 1 + 1
;; (1)=>2 + 1 + 1 + 1
;; (1)=>1 + 1 + 1 + 1
;; (1)=>0 + 1 + 1 + 1
;; 1 + 1 + 1 + 1
;; 4

;; 空间增长：栈的深度，最深就是1分的深度，= n
;; 步数增长：不大会算
