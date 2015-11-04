#lang racket

(define (make-monitored fun)
  (let ([count 0])
    (λ (param)
      (cond [(eq? param 'how-many-calls?)
             count]
            [(eq? param 'reset-count)
             (set! count 0)]
            [else
             (begin
               (set! count (+ count 1))
               (fun param))]))))

(define s (make-monitored sqrt))
(s 100)
(s 'how-many-calls?)
(s 9)
