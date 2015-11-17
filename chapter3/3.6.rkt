#lang racket

(define rand
  (let ([value 0])
    (λ (symb)
      (cond [(eq? symb 'generate)
             (let ([random-value (remainder (+ (* value 31) 23)
                                            100)])
               (begin
                 (set! value random-value)
                 random-value))]
            [(eq? symb 'reset)
             (λ [new-value]
               (set! value new-value))]))))

(rand 'generate)
(rand 'generate)
(rand 'generate)
(rand 'generate)
(rand 'generate)
((rand 'reset) 9)
(rand 'generate)
(rand 'generate)
(rand 'generate)
(rand 'generate)
(rand 'generate)
