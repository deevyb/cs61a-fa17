(define (find s predicate)
  (cond
    ((null? s) #f)
    ((predicate (car s)) (car s))
    (else (find (cdr-stream s) predicate))
  )
)

(define (scale-stream s k)
  (cond
    ((= k 0) s)
    ((null? s) s)
    (else (cons-stream (* (car s) k) (scale-stream (cdr-stream s) k)))
  )
)

(define (has-cycle s)
  (define (helper1 s1 s2)
    (if (null? s1) #f
      (helper2 (cons s1 s2) (cons s1 s2) s1)
    )
  )
  (define (helper2 original checking-list comparing-item)
    (cond
      ((null? checking-list) (helper1 (cdr-stream comparing-item) original))
      ((eq? (car checking-list) (cdr-stream comparing-item)) #t)
      (else (helper2 original (cdr checking-list) comparing-item))
    )
  )
  (helper1 s nil)
)

(define (has-cycle-constant s)
  'YOUR-CODE-HERE
)

;(cond
;  ((null? s) #f)
;  ((eq? s (cdr-stream s)) #t)
;  (else (has-cycle (cdr-stream s)))
;)
