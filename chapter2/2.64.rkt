#lang racket
(define (make-tree entry left right)
  (list entry left right))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

;;(partial-tree elts n)
;; 如果n = 0，结束递归，返回空树和剩余结果。
;; 否则，(n/2)的那个位置是entry，划分成左右两半，
;; 左边进行partial-tree elts (n-leftsize-1)
;; 得到结果树后，树之后紧跟着的那个元素就是entry了。
;; 然后递归处理右子树，得到的结果的car就是最终的右子树，剩下的cdr就是最终剩下的尾巴。
;; 最后，把entry， 左子树，右子树组成tree， 跟尾巴cons一下。

(list->tree '(1 3 5 7 9 11))
;; 按照我的简单分析，这玩意儿依然是logn的增长速度。暂时不看答案，对错不管.继续了。