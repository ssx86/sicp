#lang r5rs
#|
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
|#
(define (make-table same-key?)
  (define (find-value x lst)
    (cond ((null? lst) #f)
          ((same-key? (caar lst) x) (car lst))
          (else (find-value x (cdr lst)))))
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (find-value key-1 (cdr local-table))))
        (if subtable
            (let ((record (find-value key-2 (cdr subtable))))
              (if record (cdr record)
                  #f))
            #f)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (display "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table (lambda (x y)
                                      (< (abs (- x y)) 0.01))))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))
(put 4 4 4)
(put 5 6 5)
(display (+ (get 4 4) (get 5 6)))
