#lang racket

(define (reverse l)
  (define (append l1 l2)
    (if (null? l1)
        l2
        (cons (car l1) (append (cdr l1) l2))))
  (if (null? (cdr l))
      l
      (append (reverse (cdr l)) (list (car l)))))

;;test case:
(reverse (list 1 4 9 16 25))
;;后记。竟然看了答案才确定自己的思路是对的。实际上写出来的已经可以了。
;;没有把car l(atom)转换成list
;;因为这一步对整个算法产生了怀疑，感觉不应该这么麻烦。实际上的确就是这样而已

;;so 思考的时候多坚持一下