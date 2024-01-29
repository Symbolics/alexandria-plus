;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: ALEXANDRIA+/TESTS -*-
;;; Copyright (c) 2021-2024 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL
(in-package #:alexandria+/tests)

(defsuite alexandria+ ())

(defsuite lists (alexandria+))



(defsuite alist (lists))

(deftest alistp (alist)
  (assert-true (alistp '()))
  (assert-true (alistp '(("foo" . "bar"))))
  (assert-true (alistp '(("foo" . "bar") ("baz" . "qux"))))
  (assert-false (alistp '(:foo)))
  (assert-false (alistp 5))
  (assert-false (alistp (cons "foo" "bar"))))

#+nil
(define-test cdr-assoc
  :parent alist
  (fail (cdr-assoc nil 1))
  (is equal nil (cdr-assoc :foo ()))
  (is equal nil (cdr-assoc nil '(("foo" . "bar"))))
  (is equal "bar" (cdr-assoc "foo" '(("foo" . "bar")))))

(deftest keys (alist)
  (assert-equal '("foo" "baz") (alist-keys '(("foo" . "bar") ("baz" . "qux")))))

(deftest values (alist)
  (assert-equal '("bar" "qux") (alist-values '(("foo" . "bar") ("baz" . "qux")))))



(defsuite plist (lists))

(deftest plistp (plist)
  (assert-true (plistp '(:foo :bar)))
  (assert-true (plistp '(:foo "bar")))
  (assert-false (plistp ()))
  (assert-false (plistp '("foo" "bar")))
  (assert-false (plistp '(foo bar)))
  (assert-true (plistp '(foo bar) :allow-symbol-keys t)))

(deftest defprop (plist)
  (let (test-prop)
    (declare (ignore test-prop))
    (defprop test-prop hk pistol)
    (assert-equal 'hk (get 'test-prop 'pistol))))

(deftest keys (plist)
  (let ((result (plist-keys '(:a 1 :b 2 :c 3))))
    (assert-true (and (subsetp '(:a :b :c) result)
		      (subsetp result '(:a :b :c))))))

(deftest values (plist)
  (let ((result (plist-values '(:a 1 :b 2 :c 3))))
    (assert-true (and (subsetp '(1 2 3) result)
		      (subsetp result '(1 2 3))))))




(defsuite types (alexandria+))

(deftest probability (types)
  (assert-true (typep 0.1 'probability))
  (assert-true (typep 0 'probability))
  (assert-true (typep 1 'probability))
  (assert-false (typep 1.1 'probability))
  (assert-false (typep -1 'probability)))

(deftest percentage (types)
  (assert-true (typep 97 'percentage))
  (assert-true (typep 0 'percentage))
  (assert-true (typep 100 'percentage))
  (assert-false (typep 101 'percentage))
  (assert-false (typep -1 'percentage)))



(defsuite control-flow (alexandria+))

(deftest unlessf (control-flow)
  (let (val)
    (assert-equal 'bar (unlessf val 'bar))
    (assert-false (unlessf val 'baz))))



(defsuite numbers (alexandria+))

(deftest multf (numbers)
  (let ((val 12))
    (assert-equal 24 (multf val 2))	;test return
    (assert-equal 24 val 2)))		;test setf

(deftest divf (numbers)
  (let ((val 12))
    (assert-equal 6 (divf val 2))
    (assert-equal 6 val)))



(defsuite sets (alexandria+))

(defsuite difference (sets))

(deftest list (difference)
  (let ((seq1 '(1 2 3 4 5 6))
	(seq2 '(6 7 8 9 10)))
    (assert-equal '(1 2 3 4 5) (set-difference* seq1 seq2))))

(deftest vector (difference)
  (let ((seq1 #(1 2 3 4 5 6))
	(seq2 #(6 7 8 9 10)))
    (assert-equalp #(1 2 3 4 5) (set-difference* seq1 seq2))))

