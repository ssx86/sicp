#lang r5rs

(define (make-table)
  (list '*table*))
(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        #f)))
(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table
                  (cons (cons key value) (cdr table))))))

(define t (make-table))
(insert! 'a 3 t)
(insert! 'b 4 t)
(insert! 'b 5 t)
(display (lookup 'a t))
(display (lookup 'b t))
