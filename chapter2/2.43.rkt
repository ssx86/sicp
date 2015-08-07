#lang racket



;;补全常用函数
(define (enumerate-interval begin end)
  (if (> begin end)
      '()
      (cons begin (enumerate-interval (+ begin 1) end))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (accumulate op init seq)
  (if (null? seq)
      init
      (op (car seq)
          (accumulate op init (cdr seq)))))

;;现在理解了。flat是把列表展开收集结果
;;(flatmap (λ (x) (map (λ (i) (* i 4)) x)) '((1 2 3) (4 5 6)))



;;TODO:
;empty-board
;adjoin-postion
;safe?



(define (accumulate-cols op init seq)
  (if (null? (car seq))
      '()
      (cons (accumulate op init (map (λ (lst) (car lst)) seq))
            (accumulate-cols op init (map (λ (lst) (cdr lst)) seq)))))

(accumulate-cols + 0 '((1 2 3) (4 5 6) (7 8 9)))
;      
;               


(define (queens board-size)
  ;;empty-board
  (define empty-board '())
  ;;safe
  (define (safe? k positions)
    (= 0 (length (filter (λ (x) (> x 1))
                         (accumulate-cols + 0 positions)))))
  ;;adjoin
  (define (adjoin-position new-row k rest-of-queens)
    (define (gen-col row current result)
      (if (= current 0)
          result
          (gen-col row (- current 1) (cons (if (= current row) 1 0)
                                           result))))
    (append rest-of-queens (list (gen-col new-row board-size '()))))
  ;;queen-cols
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (λ (positions) (safe? k positions))
         (flatmap
          (λ (new-row)
            (map (λ (rest-of-queens)
                   (adjoin-position new-row k rest-of-queens))
                 (queen-cols (- k 1))))
          (enumerate-interval 1 board-size)))))
  (queen-cols board-size))

(define (display-beauty lst)
  (map (λ (resolution)
         (map (λ (item) (printf "~a\n" item))
              resolution)
         (newline))
       lst)
  #t)

(display-beauty (queens 7))

;;对比发现，的确比42慢很多。虽然我42的写法也不对，但是这里可以看到
;; queen-cols 6被调用了7次,
;; queen-cols 5被调用了6次
;; 。。。
;; 所以应该是比2.42慢，倍数是(n-1)*G(n-1), G(x)为棋盘大小=x时的时间
;;具体答案实在不会算。。