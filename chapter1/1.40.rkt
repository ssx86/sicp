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

(define (fixed-point f x)
  (define (close-enough? x y)
    (< (abs (- x y)) 0.00001))
  (define (iter guess)
    (let ((next-guess (f guess)))
      (if (close-enough? next-guess guess)
          next-guess
          (iter next-guess))))
  (iter x))

(fixed-point cos 4)

;;(define (sqrt x)      ;; y -> x / y的不动点  !!不收敛!
;;  (fix-point (average-damp (lambda (n) (/ x n))) 3))

;;(sqrt 100)

(define (cube-root x)
  (fixed-point (average-damp (lambda(y) (/ x (* y y)))) 1.0))

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

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

;;用牛顿法重写平方根
;(define (sqrt x)
;  (define (square x)
;    (* x x))
;  (newtons-method (lambda (y) (- (square y) x))
;                  1.0))
;
;(sqrt 180)

;;把newton-transform提取成一个参数
(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (sqrt x)
  (define (square x)
    (* x x ))
  (fixed-point-of-transform (lambda (y) (- (square y) x))
                            newton-transform
                            1.0))

(sqrt 180)

;;1.40 请定义一个过程cubic， 它和newtons-method过程一起使用在下面形式的表达式里
;;  (newtons-method (cubic a b c) 1)
;;能逼近三次方程x^3 + ax^2 + bx + c的零点

(define (cubic a b c)
  (define (cube x)
    (* x x x))
  (define (square x)
    (* x x))
  (lambda (x)
    (+ (cube x) (* a (square x)) (* b x) c)))

(define (resolv a b c)
  (newtons-method (cubic a b c) 1))

(resolv 1 1 -2)
             
;;这里未必是重点，主要是理解返回函数的函数 高阶函数。下次也不看这里了吧。。




                    