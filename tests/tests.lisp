;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: ALEXANDRIA/TESTS -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.

(in-package :alexandria+/tests)

(defun run-tests (&key (report 'parachute:plain) (test 'all))
    (let ((*package* #.*package*))
      (parachute:test (etypecase test
                        (symbol test)
                        (string (find-symbol test *package*)))
                      :report report)))

(define-test all)

(define-test lists
  :parent all)



;;; alist

(define-test alist
  :parent lists)

(define-test alistp
  :parent alist
  (true (alistp '()))
  (true (alistp '(("foo" . "bar"))))
  (true (alistp '(("foo" . "bar") ("baz" . "qux"))))
  (false (alistp '(:foo)))
  (false (alistp 5))
  (false (alistp (cons "foo" "bar"))))

(define-test cdr-assoc
  :parent alist
  (fail (cdr-assoc nil 1))
  (is equal nil (cdr-assoc :foo ()))
  (is equal nil (cdr-assoc nil '(("foo" . "bar"))))
  (is equal "bar" (cdr-assoc "foo" '(("foo" . "bar")))))

(define-test alist-keys
  :parent alist
  (is equal '("foo" "baz") (alist-keys '(("foo" . "bar") ("baz" . "qux")))))

(define-test alist-values
  :parent alist
  (is equal '("bar" "qux") (alist-values '(("foo" . "bar") ("baz" . "qux")))))




;;; plist

(define-test plist
  :parent lists)

(define-test plistp
  :parent plist
  (true (plistp '(:foo :bar)))
  (true (plistp '(:foo "bar")))
  (false (plistp ()))
  (false (plistp '("foo" "bar"))))

(define-test defprop
  :parent plist
  (let (test-prop)
    (declare (ignore test-prop))
    (defprop test-prop hk pistol)
    (is equal 'hk (get 'test-prop 'pistol))))

(define-test plist-keys
  :parent plist
  (let ((result (plist-keys '(:a 1 :b 2 :c 3))))
    (true (and (subsetp '(:a :b :c) result)
	       (subsetp result '(:a :b :c))))))

(define-test plist-values
  :parent plist
  (let ((result (plist-values '(:a 1 :b 2 :c 3))))
    (true (and (subsetp '(1 2 3) result)
	       (subsetp result '(1 2 3))))))


;;; types

(define-test types
  :parent all)

(define-test probability
  :parent types
  (true (typep 0.1 'probability))
  (true (typep 0 'probability))
  (true (typep 1 'probability))
  (false (typep 1.1 'probability))
  (false (typep -1 'probability)))

(define-test percentage
  :parent types
  (true (typep 97 'percentage))
  (true (typep 0 'percentage))
  (true (typep 100 'percentage))
  (false (typep 101 'percentage))
  (false (typep -1 'percentage)))
