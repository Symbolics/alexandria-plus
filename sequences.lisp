;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: ALEXANDRIA+ -*-
;;; Copyright (c) 2026 Symbolics Pte. Ltd. All rights reserved.
(in-package #:alexandria+)

(defun delete-nth (sequence n)
  "Return SEQUENCE with the Nth item removed.
Note: DELETE-IF makes no guarantee of being destructive, so you cannot rely on this side-effect.  You must SETF the original sequence to the values returned from this function, or use the modify-macro DELETE-NTH*"
  (check-type sequence sequence)
  (delete-if (constantly t) sequence :start n :count 1))

(define-modify-macro delete-nth* (n)
  delete-nth
  "Destructively modifies N, a SEQUENCE by removing the Nth item.
Example:
    LS-USER> (defparameter *v* #(a b c d))
    *V*
    LS-USER> (delete-nth* *v* 1)
    #(A C D)
    LS-USER> *v*
    #(A C D)")
