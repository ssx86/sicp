#lang racket

;; make-tree
(define (make-tree entry left right)
  (list entry left right))
(define (entry tree)
  (car tree))
(define (left-branch tree)
  (cadr tree))
(define (right-branch tree)
  (caddr tree))

;; list->tree
(define (list->tree elements)
  (car (partial-tree elements (length elements))))
(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))



(define (key record)
  (car record))
(define (value record)
  (cadr record))
(define (make-record k v)
  (list k v))

;;教科书
(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((equal? given-key (key (car set-of-records)))
         (car set-of-records))
        (else (lookup given-key (cdr set-of-records)))))

;;二叉树版本
(define (lookup-bin given-key records)
  (cond ((null? records) false)
        ((equal? given-key (key (entry records)))
         (entry records))
        ((< given-key (key (entry records)))
         (lookup-bin given-key (left-branch records)))
        ((> given-key (key (entry records)))
         (lookup-bin given-key (right-branch records)))))
;;test
(define test  (list (make-record 1 "yi" )
                               (make-record 2 "er" )
                               (make-record 3 "san" )
                               (make-record 4 "si" )
                               (make-record 5 "wu" )))
test
(lookup 3 test)
(lookup-bin 3 (list->tree test))