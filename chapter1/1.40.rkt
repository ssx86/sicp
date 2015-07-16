#lang racket
;;平均阻尼思想
(define (average-damp f)
  (lambda (x) (average x (f x))))
(define (average x y)
  (/ (+ x y) 2))

((average-damp (lambda(x) (* x x))) 4)   ;; (4 + 16) / 2 = 10
((average-damp (lambda(x) (* x x))) 10)   ;; (10 + 100) / 2 = 55

(display "==============")
(newline)

(define (fix-point f x)
  (define (close-enough? x y)
    (< (abs (- x y)) 0.00001))
  (define (iter guess)
    (let ((next-guess (f guess)))
      (if (close-enough? next-guess guess)
          next-guess
          (iter next-guess))))
  (iter x))

(fix-point cos 4)

(define (sqrt x)      ;; y -> x / y的不动点  !!不收敛!
  (fix-point (average-damp (lambda (n) (/ x n))) 3))

(sqrt 100)

(define (cube-root x)
  (fix-point (average-damp (lambda(y) (/ x (* y y)))) 1.0))

(cube-root 9)

(newline)

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))
(define dx 0.00001)

((deriv (lambda(x) (* x x x))) 5)    ;;3*(x^2)
((deriv (lambda(x) (* 3 x x))) 5)    ;;6*x


(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newton-method g guess)
  (fix-point (newton-transform g) guess))

