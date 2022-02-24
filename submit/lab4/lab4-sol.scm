(define (quadratic-roots a b c)
  (if (= a 0)
    'error
    (let ((discriminant (sqrt (- (expt b 2) (* 4 a c)))))
      (list (/ (+ (- b) discriminant) (* 2 a)) (/ (- (- b) discriminant) (* 2 a))))))

(define my-sqrt
  (lambda (n (guess 1))
    (let ((val (/ (abs (- (* guess guess) n)) n)))
      (if (<= val 0.0001)
	guess
	(my-sqrt n (/ (+ guess (/ n guess)) 2))))))
