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
