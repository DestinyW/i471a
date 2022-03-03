#!/usr/bin/env racket

#lang racket
(require rackunit)

;;Exercise 1
;;Given a proper-list list of proper-lists, return the sum of the
;;lengths of all the top-level contained lists.
(define (sum-lengths ls)
  0)

(check-eq? (sum-lengths '()) 0)
(check-eq? (sum-lengths '(() ())) 0)
(check-eq? (sum-lengths '((1 2) (2 1))) 4)
(check-eq? (sum-lengths '((1 ((2)) 3) ((2 1)))) 4)

;;Repeat previous exercise where all recursion is tail-recursive
(define (sum-lengths-tr ls)
  0)

(check-eq? (sum-lengths-tr '()) 0)
(check-eq? (sum-lengths-tr '(() ())) 0)
(check-eq? (sum-lengths-tr '((1 2) (2 1))) 4)
(check-eq? (sum-lengths-tr '((1 ((2)) 3) ((2 1)))) 4)

;;Evaluate polynomial given by list coeffs at x; i.e. return
;; coeffs[0] + coeffs[1]*x + coeffs[2]*x^2 + ...
;; all recursion should be tail-recursive
(define (poly-eval x coeffs)
  0)

(check-eq? (poly-eval 2 '()) 0)
(check-eq? (poly-eval 2 '(5)) 5)
(check-eq? (poly-eval 2 '(5 3)) 11)
(check-eq? (poly-eval 2 '(5 3 -3)) -1)
(check-eq? (poly-eval -1 '(5 3 -3)) -1)
(check-eq? (poly-eval -1 '(5 3 -3 5)) -6)

;;Exercise 2

;;from lab 4:
;;map elements of ls to #t or #f depending on whether or not
;;the element is > v or not > v
(define greater-than
  (lambda (ls (v 0))
    (if (null? ls)
	'()
	(cons (> (car ls) v)
	      (greater-than (cdr ls) v)))))

(check-equal? (greater-than '(-1 3 6 -3 1 8) 2)
	      '(#f #t #t #f #f #t))
(check-equal? (greater-than '(-1 3 6 -3 1 8))
	      '(#f #t #t #f #t #t))
(check-equal? (greater-than '()) '())

;; return those elements in list ls which are greater than v
(define (get-greater-than ls (v 0))
  '())

(check-equal? (get-greater-than '() 3) '())
(check-equal? (get-greater-than '(3 2 -2) 1) '(3 2))
(check-equal? (get-greater-than '(1 2 -2)) '(1 2))
(check-equal? (get-greater-than '(-1 3 6 -3 1 8) 2) '(3 6 8))
(check-equal? (get-greater-than '(-1 3 6 -3 1 8)) '(3 6 1 8))

;;map elements of ls to #t or #f depending on whether or not
;;the element is > v or not > v
(define (less-than ls (v 0))
  '())

(check-equal? (less-than '(-1 3 6 -3 1 8) 2)
	      '(#t #f #f #t #t #f))
(check-equal? (less-than '(-1 3 6 -3 1 8))
	      '(#t #f #f #t #f #f))
(check-equal? (less-than '()) '())

;; return those elements in list ls which are less than v
(define (get-less-than ls (v 0))
  '())

(check-equal? (get-less-than '() 3) '())
(check-equal? (get-less-than '(3 2 -2) 1) '(-2))
(check-equal? (get-less-than '(1 2 -2)) '(-2))
(check-equal? (get-less-than '(-1 3 6 -3 1 8) 2) '(-1 -3 1))
(check-equal? (get-less-than '(-1 3 6 -3 1 8)) '(-1 -3))

