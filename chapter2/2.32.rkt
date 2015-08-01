#lang racket

;;子集
(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x)
                            (append x (list (car s)))
                            ) rest)))))

(subsets (list 1 2 3 ))

;;去掉第一个元素，对剩下的进行求子集运算，然后把子集的每一项都加上第一个元素，组成新的集合。append子集和新子集，即得到了全部子集。