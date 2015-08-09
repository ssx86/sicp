#lang racket
( require ( planet "sicp.ss" ( "soegaard" "sicp.plt" 2 1)))
;(paint einstein)

;a 给定框架边框的画家
(define painter-a (segments->painter (list (make-segment (make-vect 0 0)
                                                         (make-vect 0 1))
                                           (make-segment (make-vect 0 1)
                                                         (make-vect 1 1))
                                           (make-segment (make-vect 1 1)
                                                         (make-vect 1 0))
                                           (make-segment (make-vect 1 0)
                                                         (make-vect 0 0)))))

(paint painter-a)

;;b 对角线
(define painter-b (segments->painter (list (make-segment (make-vect 0 0)
                                                         (make-vect 1 1))
                                           (make-segment (make-vect 1 0)
                                                         (make-vect 0 1)))))
(paint painter-b)

;;c 菱形
(define painter-c (segments->painter (list (make-segment (make-vect 0.5 0)
                                                         (make-vect 1 0.5))
                                           (make-segment (make-vect 1 0.5)
                                                         (make-vect 0.5 1))
                                           (make-segment (make-vect 0.5 1)
                                                         (make-vect 0 0.5))
                                           (make-segment (make-vect 0 0.5)
                                                         (make-vect 0.5 0)))))
(paint painter-c)

;;d wave.
;;略。。就是那个简笔画小人。。。用了这个sicp的包之后我特么以为wave真的是爱因斯坦呢，，，