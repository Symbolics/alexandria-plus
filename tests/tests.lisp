;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: ALEXANDRIA+/TESTS -*-
;;; Copyright (c) 2021-2024, 2026 by Symbolics Pte. Ltd. All rights reserved.
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


(defsuite definitions (alexandria+))

(deftest defprop (definitions)
  (let (test-prop)
    (declare (ignore test-prop))
    (defprop test-prop hk pistol)
    (assert-equal 'hk (get 'test-prop 'pistol))))

;; Define some functions to alias
(declaim (ftype function new-add new-greet alias-add alias-temp))
(defun original-add (a b) (+ a b))
(defun original-greet () "Hello")

(deftest test-basic-alias (definitions)
  "Verify that the alias calls the correct function."
  (defalias new-add original-add)
  (assert-equal 5 (new-add 2 3))
  (assert-equal "Hello" (let () (defalias new-greet original-greet) (new-greet))))

(deftest test-function-identity (definitions)
  "Verify the alias points to the exact same function object."
  (defalias alias-add original-add)
  (assert-true (eq (symbol-function 'alias-add)
                   (symbol-function 'original-add))))

(deftest test-redefinition-behavior (definitions)
  "Verify that if the original is redefined, the alias still points to the OLD version."
  (defun temp-func () :old)
  (defalias alias-temp temp-func)
  (defun temp-func () :new) ; Redefine original
  (assert-equal :old (alias-temp)) ; Alias remains linked to the old function object
  (assert-equal :new (temp-func)))



(defsuite sequences (alexandria+))

(defsuite delete-nth (sequences))


;;; delete-nth

(deftest delete-nth-list-middle (delete-nth)
  "Remove an element from the middle of a list."
  (assert-equal '(a c d) (delete-nth '(a b c d) 1)))

(deftest delete-nth-list-first (delete-nth)
  "Remove the first element of a list."
  (assert-equal '(b c d) (delete-nth '(a b c d) 0)))

(deftest delete-nth-list-last (delete-nth)
  "Remove the last element of a list."
  (assert-equal '(a b c) (delete-nth '(a b c d) 3)))

(deftest delete-nth-list-singleton (delete-nth)
  "Removing the only element of a list yields NIL."
  (assert-equal '() (delete-nth '(x) 0)))

(deftest delete-nth-vector-middle (delete-nth)
  "Remove an element from the middle of a vector."
  (assert-equalp #(a c d) (delete-nth #(a b c d) 1)))

(deftest delete-nth-vector-first (delete-nth)
  "Remove the first element of a vector."
  (assert-equalp #(b c d) (delete-nth #(a b c d) 0)))

(deftest delete-nth-vector-last (delete-nth)
  "Remove the last element of a vector."
  (assert-equalp #(a b c) (delete-nth #(a b c d) 3)))

(deftest delete-nth-vector-singleton (delete-nth)
  "Removing the only element of a vector yields an empty vector."
  (assert-equalp #() (delete-nth #(x) 0)))

(deftest delete-nth-returns-sequence (delete-nth)
  "Return value is always a sequence."
  (assert-true (typep (delete-nth '(1 2 3) 0) 'sequence))
  (assert-true (typep (delete-nth #(1 2 3) 0) 'sequence)))

(deftest delete-nth-type-error (delete-nth)
  "Non-sequence argument signals a type error."
  (assert-condition type-error (delete-nth 42 0)))


;;; delete-nth* (modify macro — test both return value and place mutation)

(deftest delete-nth*-list-return (delete-nth)
  "delete-nth* returns the modified list."
  (let ((v (list 'a 'b 'c 'd)))
    (assert-equal '(a c d) (delete-nth* v 1))))

(deftest delete-nth*-list-mutates (delete-nth)
  "delete-nth* updates the binding via SETF."
  (let ((v (list 'a 'b 'c 'd)))
    (delete-nth* v 1)
    (assert-equal '(a c d) v)))

(deftest delete-nth*-vector-return (delete-nth)
  "delete-nth* returns the modified vector."
  (let ((v (vector 'a 'b 'c 'd)))
    (assert-equalp #(a c d) (delete-nth* v 1))))

(deftest delete-nth*-vector-mutates (delete-nth)
  "delete-nth* updates the binding via SETF."
  (let ((v (vector 'a 'b 'c 'd)))
    (delete-nth* v 1)
    (assert-equalp #(a c d) v)))

(deftest delete-nth*-first (delete-nth)
  "delete-nth* correctly removes the first element."
  (let ((v (list 'a 'b 'c)))
    (delete-nth* v 0)
    (assert-equal '(b c) v)))

(deftest delete-nth*-last (delete-nth)
  "delete-nth* correctly removes the last element."
  (let ((v (list 'a 'b 'c)))
    (delete-nth* v 2)
    (assert-equal '(a b) v)))

(deftest delete-nth*-singleton (delete-nth)
  "delete-nth* on a single-element list yields NIL."
  (let ((v (list 'x)))
    (delete-nth* v 0)
    (assert-equal '() v)))
