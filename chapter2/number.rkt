#lang racket

;; 首先是备用的公共函数
(define (square x) (* x x))
;;get and put
(define global-array '())
(define (make-entry k v) (list k v))
(define (key entry) (car entry))
(define (value entry) (cadr entry))
(define (put op type item)
  (define (put-helper k array)
    (cond ((null? array) (list(make-entry k item)))
          ((equal? (key (car array)) k) array)
          (else (cons (car array) (put-helper k (cdr array))))))
  (set! global-array (put-helper (list op type) global-array)))
(define (get op type)
  (define (get-helper k array)
    (cond ((null? array) #f)
          ((equal? (key (car array)) k) (value (car array)))
          (else (get-helper k (cdr array)))))
  (get-helper (list op type) global-array))
;; gcd
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;; 数据导向代码整理

;; 在建立复数描述之前，先抽象建立了使用的方法
(define (add-complex z1 z2)
  (make-from-real-imag (+ (real-part z1) (real-part z2))
                       (+ (imag-part z1) (imag-part z2))))
(define (sub-complex z1 z2)
  (make-from-real-imag (- (real-part z1) (real-part z2))
                       (- (imag-part z1) (imag-part z2))))
(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                     (+ (angle z1) (angle z2))))
(define (div-complex z1 z2)
  (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                     (- (angle z1) (angle z2))))

;;;复数的表示方法：
;;; Ben 建立了直角坐标表示形式
;(define (real-part z) (car z))
;(define (imag-part z) (cdr z))
;(define (magnitude z)
;  (sqrt (+ (square (real-part z)) (square (imag-part z)))))
;(define (angle z)
;  (atan (imag-part z) (real-part z)))
;(define (make-from-real-imag x y) (cons x y))
;(define (make-from-mag-ang r a)
;  (cons (* r (cos a)) (* r (sin a))))
;
;;;Alyssa 建立了极坐标形式
;(define (real-part z)
;  (* (magnitude z) (cos (angle z))))
;(define (imag-part z)
;  (* (magnitude z) (sin (angle z))))
;(define (magnitude z) (car z))
;(define (angle z) (cdr z))
;(define (make-from-real-imag x y)
;  (cons (sqrt (+ (square x) (square y)))
;        (atan y x)))
;(define (make-from-mag-ang r a) (cons r a))

;; 带标识数据
;; 标识相关函数
(define (attach-tag type-tag contents)
  (cons type-tag contents))
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "bad tagged datum -- TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "bad tagged datum -- CONTENTS" datum)))

;; 创造两个数据标识
(define (rectangular? z)
  (eq? (type-tag z) 'rectangular))
(define (polar? z)
  (eq? (type-tag z) 'polar))
;
;;; 重写之后的两套complex表示法为：
;;; 直角坐标系
;(define (real-part-rectangular z) (car z))
;(define (imag-part-rectangular z) (cdr z))
;(define (magnitude-rectangular z)
;  (sqrt (+ (square (real-part-rectangular z)) (square (imag-part-rectangular z)))))
;(define (angle-rectangular z)
;  (atan (imag-part-rectangular z) (real-part-rectangular z)))
;(define (make-from-real-imag-rectangular x y) (attach-tag 'rectangular (cons x y)))
;(define (make-from-mag-ang-rectangular r a)
;  (attach-tag 'rectangular (cons (* r (cos a)) (* r (sin a)))))
;
;; 极坐标系
;(define (real-part-polar z)
;  (* (magnitude-polar z) (cos (angle-polar z))))
;(define (imag-part-polar z)
;  (* (magnitude-polar z) (sin (angle-polar z))))
;(define (magnitude-polar z) (car z))
;(define (angle-polar z) (cdr z))
;(define (make-from-real-imag-polar x y)
;  (attach-tag 'polar (cons (sqrt (+ (square x) (square y)))
;                           (atan y x))))
;(define (make-from-mag-ang-polar r a) (attach-tag 'polar (cons r a)))
;
;;; 这样一来，根据数据上的tag，就可以去选择对应的complex表示法解析这个数据
;(define (real-part z)
;  (cond ((rectangular? z)
;         (real-part-rectangular (contents z)))
;        ((polar? z)
;         (real-part-polar (contents z)))
;        (else (error "Unknown type -- REAL-PART" z))))
;(define (imag-part z)
;  (cond ((rectangular? z)
;         (imag-part-rectangular (contents z)))
;        ((polar? z)
;         (imag-part-polar (contents z)))
;        (else (error "Unknown type -- IMAG-PART" z))))
;(define (magnitude z)
;  (cond ((rectangular? z)
;         (magnitude-rectangular (contents z)))
;        ((polar? z)
;         (magnitude-polar (contents z)))
;        (else (error "Unknown type -- MAGNITUDE" z))))
;(define (angle z)
;  (cond ((rectangular? z)
;         (angle-rectangular (contents z)))
;        ((polar? z)
;         (angle-polar (contents z)))
;        (else (error "Unknown type -- ANGLE" z))))
;
;;; 这时候所有的加减乘除运算完全不用改变，内部的各种函数可以根据数据来选择对应的解析方法了。
;;; 但是要把构造函数进行明确的指定
;(define (make-from-real-imag x y)
;  (make-from-real-imag-rectangular x y))
;(define (make-from-mag-ang r a)
;  (make-from-mag-ang-polar r a))

;; 现在引入table
;;复数的表示方法:
;; Ben 建立了直角坐标表示形式
(define (install-rectangular-package)
  ;;internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (magnitude z)
    (sqrt (+ (square (real-part z)) (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-real-imag x y) (cons x y))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
  
  ;;interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  (put 'make-from-real-imag 'rectangular
       (λ (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (λ (r a) (tag (make-from-mag-ang r a))))
  'done)


;;Alyssa 建立了极坐标形式
(define (install-polar-package)
  ;;internal procedures
(define (real-part z)
  (* (magnitude z) (cos (angle z))))
(define (imag-part z)
  (* (magnitude z) (sin (angle z))))
(define (magnitude z) (car z))
(define (angle z) (cdr z))
(define (make-from-real-imag x y)
  (cons (sqrt (+ (square x) (square y)))
        (atan y x)))
(define (make-from-mag-ang r a) (cons r a))

  ;;interface to the rest of the system
(define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  (put 'make-from-real-imag 'polar
       (λ (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'polar
       (λ (r a) (tag (make-from-mag-ang r a))))
  'done)

;;至此，所有的特定数据类型的处理函数都被移动到了package中。全局空间中没有可用的函数了。
;;现在定义一些函数，用来提取这些特定数据类型使用的函数
;;apply-generic 根据操作类型和参数数据类型，选取合适的操作作用在数据类容上
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No method for these types -- APPLY-GENERIC"
           (list op type-tags))))))

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))


(define (make-from-real-imag x y)
  ((get 'make-from-real-imag 'rectangular) x y))
(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang 'polar) r a))

;; 带有通用型操作的系统

;; 通用型算数过程定义：
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

;;常规数包
(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number)
       (λ (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (λ (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (λ (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (λ (x y) (tag (/ x y))))
  (put 'make 'scheme-number
       (λ (x) (tag x)))
  'done)
;;常规数构造函数
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

;;有理数
(define (install-rational-package)
  ;;internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))

  ;;interface to rest of the system
(define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (λ (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (λ (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (λ (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (λ (x y) (tag (div-rat x y))))

  (put 'make 'rational
       (λ (n d) (tag (make-rat n d))))
  'done)
  ;;有理数构造函数
(define (make-rational n d)
  ((get 'make 'rational) n d))

;;构造整个复数的大包。内部包含两个具体实现包在上面提到(rectangular, polar)
(define (install-complex-package)
  ;;imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  ;;internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (real-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))

  ;;interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (λ (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (λ (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (λ (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (λ (z1 z2) (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
       (λ (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (λ (r a) (tag (make-from-mag-ang r a))))

  (put 'magnitude '(complex) magnitude)
  (put 'angle '(complex) angle)
  (put 'real-part '(complex) real-part)
  (put 'imag-part '(complex) imag-part)
  'done)
;;复数构造函数
(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))



  
;; test cases
(install-rectangular-package)
(install-polar-package)
(add-complex (make-from-real-imag 4 3)
             (make-from-mag-ang 2 4))

(install-scheme-number-package)
(add (make-scheme-number 9)
     (make-scheme-number 12))

(install-rational-package)
(sub (make-rational 3 4)
     (make-rational 5 4))

(install-complex-package)
(mul (make-complex-from-real-imag 3 4)
     (make-complex-from-mag-ang 5 6))

(magnitude (make-complex-from-real-imag 3 4))