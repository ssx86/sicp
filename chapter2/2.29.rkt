#lang racket

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;; a) 四个selector
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (car (cdr  branch)))
;;for test:
;;(branch-structure (make-branch 34 50))

;; b) weight
(define (total-weight x)
  (define (branch-weight branch)
    (let ((structure (branch-structure branch)))
    (if (pair? structure)
        (total-weight structure)
        structure)))
  (if (pair? x)
      (+ (branch-weight (left-branch x))
         (branch-weight (right-branch x)))
      x))
  
(define test (make-mobile
              (make-branch 10 40)
              (make-branch 100 (make-mobile
                               (make-branch 2 2)
                               (make-branch 2 2)))))
(total-weight test)

;; c)这两天经理不集中，写了好几次才写对这个东西。回头重构一下吧，下次。
(define (balance x)
  (define (torque branch)
    (* (branch-length branch)
       (total-weight (branch-structure branch))))
  (if (not (pair? x))
      #t
      (and 
       (= (torque (left-branch x))
          (torque (right-branch x)))
       (balance (branch-structure (left-branch x)))
       (balance (branch-structure (right-branch x))))))

(balance test)