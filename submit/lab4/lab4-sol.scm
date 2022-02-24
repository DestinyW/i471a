(define quadratic-roots
  (lambda (a b c (func sqrt))
    (if (= a 0)
      'error
      (let ((discriminant (func (- (expt b 2) (* 4 a c)))))
	(list (/ (+ (- b) discriminant) (* 2 a)) (/ (- (- b) discriminant) (* 2 a)))))))

(define my-sqrt
  (lambda (n (guess 1.0))
    (let ((val (/ (abs (- (* guess guess) n)) n)))
      (if (<= val 0.0001)
	guess
	(my-sqrt n (/ (+ guess (/ n guess)) 2))))))

(define (cmp-gt ls1 ls2)
   (if (null? ls1)
       '()
       (cons (> (car ls1) (car ls2))
             (cmp-gt (cdr ls1) (cdr ls2)))))

(define (ls-prod ls1 ls2)
   (if (null? ls1)
       '()
       (cons (* (car ls1) (car ls2))
             (ls-prod (cdr ls1) (cdr ls2)))))

(define ls-f
  (lambda (ls1 ls2 (f (lambda (a b) (+ a b))))
    (if (null? ls1)
      '()
      (cons (f (car ls1) (car ls2))
             (ls-f (cdr ls1) (cdr ls2) f)))))

(define greater-than
  (lambda (ls (v 0))
   (if (null? ls)
       '()
       (cons (> (car ls) v)
             (greater-than (cdr ls) v)))))

