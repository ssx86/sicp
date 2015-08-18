#lang racket

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit"))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))
;; encode

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))
(define (encode-symbol char tree)
  (cond ((and (leaf? tree) (equal? char (symbol-leaf tree)))
         '())
        ((element-of-set? char (symbols (left-branch tree)))
         (cons '0 (encode-symbol char (left-branch tree))))
        ((element-of-set? char (symbols (right-branch tree)))
         (cons '1 (encode-symbol char (right-branch tree))))
        (else (error "error char"))))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))


;;2.69 生成Huffman编码树
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge set)
  (if (null? (cdr set))
      (car set)
      (successive-merge (cons (make-code-tree (car set)
                                              (cadr set))
                              (cddr set)))))


(define tree (generate-huffman-tree '((NA 16) (YIP 9) (SHA 3) (A 2) (GET 2) (JOB 2)
                                              (BOOM 1) (WAH 1))))

(define case '(GET A JOB
              SHA NA NA NA NA NA NA NA NA
              GET A JOB
              SHA NA NA NA NA NA NA NA NA
              WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
              SHA BOOM))
(length case) ;; 36, 8种情况最少用3位定长表示，3*36 = 108位。
(length (encode case tree)) ;; 一共使用了87位。
