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
  (+ (branch-weight (left-branch x))
     (branch-weight (right-branch x))))

(define test (make-mobile
              (make-branch 10 30)
              (make-branch 30 (make-mobile
                               (make-branch 1 5)
                               (make-branch 5 1)))))
(total-weight test)

;; c)暂时是错的，明天白天继续更新。不要看现在的代码。错错错
(define (balance x)
  (define (torque branch)
    (let ((structure (branch-structure branch)))
    (if (pair? structure)
        (total-weight structure)
        (* (branch-length branch) structure))))
  (= (torque (left-branch x))
     (torque (right-branch x))))

(balance test)