#lang racket

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (mul-interval-new x y)
  (cond ((> (lower-bound x) 0)
         ;;>>x
          (cond ((> (lower-bound y) 0)
                 ;;>>y
                 (make-interval (* (lower-bound x) (lower-bound y))
                                (* (upper-bound x) (upper-bound y)))
                 )
                ((and (< (lower-bound y) 0)
                      (> (upper-bound y) 0))
                 ;;<>y
                   (make-interval (* (upper-bound x) (lower-bound y))
                                (* (upper-bound x) (upper-bound y)))
                 )
                ((< (upper-bound y) 0)
                 ;;<<y
                   (make-interval (* (upper-bound x) (lower-bound y))
                                (* (lower-bound x) (upper-bound y)))
                 ))
          )
        ((and (< (lower-bound x) 0)
               (> (upper-bound x) 0))
          ;;<>x
         (cond ((> (lower-bound y) 0)
                 ;;>>y
                  (make-interval (* (lower-bound x) (upper-bound y))
                                (* (upper-bound x) (upper-bound y)))
                 )
                ((and (< (lower-bound y) 0)
                      (> (upper-bound y) 0))
                 ;;<>y
                 ;;x和y都跨越了0点，这种情况下貌似不可能用2次乘法解决这个问题
                   (make-interval (min (* (lower-bound x) (upper-bound y))
                                       (* (upper-bound x) (lower-bound y)))
                                  (max (* (lower-bound x) (lower-bound y))
                                       (* (upper-bound x) (upper-bound y))))
                 )
                ((< (upper-bound y) 0)
                 ;;<<y
                   (make-interval (* (upper-bound x) (lower-bound y))
                                (* (lower-bound x) (lower-bound y)))
                 ))
          )
        ((< (upper-bound x) 0)
         ;;<<x
         (cond ((> (lower-bound y) 0)
                 ;;>>y
                  (make-interval (* (lower-bound x) (upper-bound y))
                                (* (upper-bound x) (lower-bound y)))
                 )
                ((and (< (lower-bound y) 0)
                      (> (upper-bound y) 0))
                 ;;<>y
                  (make-interval (* (lower-bound x) (upper-bound y))
                                (* (lower-bound x) (lower-bound y)))
                 )
                ((< (upper-bound y) 0)
                 ;;<<y
                  (make-interval (* (upper-bound x) (upper-bound y))
                                (* (lower-bound x) (lower-bound y)))
                 ))
         )))
          
(define (eq-interval? x y)
  (and (= (lower-bound x) (lower-bound y))
       (= (upper-bound x) (upper-bound y))))

(define (make-interval a b) (cons a b))

(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))

;;验证
(define (test a1 b1 a2 b2)
  (newline)
  (printf "~a, ~a, ~a, ~a\t" a1 b1 a2 b2)
  (let ((x (make-interval a1 b1))
        (y (make-interval a2 b2)))
    (if (eq-interval? (mul-interval x y) (mul-interval-new x y))
        (display "success")
        (display "failed"))))

(test 3 4 5 6)
(test -2 4 5 6)
(test -4 -2 5 6)
(test 3 4 -5 6)
(test -2 4 -5 6)
(test -4 -2 -5 6)
(test 3 4 -5 -1)
(test -2 4 -5 -3)
(test -4 -2 -5 -5)


