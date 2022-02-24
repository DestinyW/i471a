(define (quadratic-roots a b c)
  (if (= a 0)
    'error
    (let ((discriminant (sqrt (- (expt b 2) (* 4 a c)))))
      (list (/ (+ (- b) discriminant) (* 2 a)) (/ (- (- b) discriminant) (* 2 a))))))

