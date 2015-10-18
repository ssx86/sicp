#lang racket

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

(define (get-record organization name)
  (get organization name))

;; a)必须提供机构名和雇员名字
(put 'dongchang 'zhangxiaoming '((salary 500)))
(get-record 'dongchang 'zhangxiaoming)

;; b)每一个机构要把自己的获得salary的方法抽象出来。

(define (get-key item)
  (car item))
(define (get-value item)
    (cadr item))

(define (dongchang-install)
  ;;东厂的get-salary函数
  (define (get-salary name)
    (let ((record (get-record 'dongchang name)))
      (define (find-iter rest)
        (cond ((null? rest) '())
              ((eq? (get-key (car rest)) 'salary) (get-value (car rest)))
              (else find-iter (cdr rest))))
      (find-iter record)))
  ;;安装到'dongchang 'get-salary坐标下
  (put 'dongchang 'get-salary get-salary))

(dongchang-install)
((get 'dongchang 'get-salary) 'zhangxiaoming)

;; c)
(define (find-employee-record name all-organ-name)
  (if (null? all-organ-name)
      '()
      (let ((record (get-record (car all-organ-name) name)))
        (if (null? record)
            '()
            record))))

(find-employee-record 'xiaohong '(dongchang xichang))
(find-employee-record 'zhangxiaoming '(dongchang xichang))

;; d)需要按照b的要求把每一项数据的具体函数注册到机构名下，并且修改find-employee-record，第三个参数要增加这个新机构的名字
     
