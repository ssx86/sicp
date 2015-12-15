#lang r5rs

(define (make-item data prev next)
  (cons data (cons prev next)))

(define (data item)
  (car item))
(define (pointer item)
  (cdr item))
(define (prev-ptr item)
  (cadr item))
(define (next-ptr item)
  (cddr item))

(define (set-prev-ptr! item ptr)
  (set-car! (pointer item) ptr))
(define (set-next-ptr! item ptr)
  (set-cdr! (pointer item) ptr))

(define (make-queue)
  (cons '() '()))
(define (front-ptr queue)
  (car queue))
(define (rear-ptr queue)
  (cdr queue))
(define (set-front-ptr! queue ptr)
  (set-car! queue ptr))
(define (set-rear-ptr! queue ptr)
  (set-cdr! queue ptr))
(define (empty-queue? queue)
  (null? (front-ptr queue)))

(define (front-insert-queue! queue data)
  (let ((item (make-item data '() '())))
    (if (empty-queue? queue)
        (begin
          (set-front-ptr! queue item)
          (set-rear-ptr! queue item))
        (begin
          (set-next-ptr! item (front-ptr queue))
          (set-prev-ptr! (front-ptr queue) item)
          (set-front-ptr! queue item)))))

(define (rear-insert-queue! queue data)
  ;;图省事，空队列直接调用front-insert-queue!
  (if (empty-queue? queue)
      (front-insert-queue! queue data)
      (let ((item (make-item data '() '())))
        (begin
          (set-next-ptr! (rear-ptr queue) item)
          (set-prev-ptr! item (rear-ptr queue))
          (set-rear-ptr! queue item)))))

(define (front-delete-queue! queue)
  (if (empty-queue? queue)
      (display "ERROR, FRONT-DELETE Empty queue")
      (begin
        (set-front-ptr! queue (next-ptr (front-ptr queue)))
        (if (pair? (front-ptr queue))
            (set-prev-ptr! (front-ptr queue) '())
            (set-rear-ptr! queue '())))))
(define (rear-delete-queue! queue)
  (if (empty-queue? queue)
      (display "ERROR, REAR-DELETE Empty queue")
      (begin
        (set-rear-ptr! queue (prev-ptr (rear-ptr queue)))
        (if (pair? (rear-ptr queue))
            (set-next-ptr! (rear-ptr queue) '())
            (set-front-ptr! queue '())))))

(define (print-queue queue)
  (let ((front (front-ptr queue)))
    (define (print-lst lst)
      (if (null? lst)
          (display ".\n")
          (begin
            (display (data lst))
            (print-lst (next-ptr lst)))))
    (print-lst front)))

(define q1 (make-queue))
(print-queue q1)

(front-insert-queue! q1 'a)
(print-queue q1)

(front-insert-queue! q1 'b)
(print-queue q1)

(front-insert-queue! q1 'c)
(print-queue q1)

(rear-insert-queue! q1 'd)
(print-queue q1)

(rear-insert-queue! q1 'e)
(print-queue q1)

(front-delete-queue! q1)
(print-queue q1)

(front-delete-queue! q1)
(print-queue q1)

(front-delete-queue! q1)
(print-queue q1)


(front-delete-queue! q1)
(print-queue q1)

(rear-delete-queue! q1)
(print-queue q1)

(rear-delete-queue! q1)
(print-queue q1)

(rear-delete-queue! q1)
(print-queue q1)

(rear-delete-queue! q1)
(print-queue q1)
