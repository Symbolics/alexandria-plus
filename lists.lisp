;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: ALEXANDRIA+ -*-
;;; Copyright (c) 2021 Symbolics Pte. Ltd. All rights reserved.
(in-package #:alexandria+)

;;; Utilities for working with a/p lists.

;;; See https://github.com/fukamachi/assoc-utils
;;; He duplicates some functions in alexandria, so we'll pull it in piecemeal

;;; alists

(defvar *assoc-test* #'equal "Global equality test for assoc")

(defun alistp (value)
  "Returns T if VALUE is an ALIST."
  (or (null value)
      (and (consp value)
           (mapl (lambda (tree)
                   (unless (and (consp (first tree))
                                (not (consp (first (first tree))))
                                (listp (rest tree)))
                     (return-from alistp nil)))
                 value)
           t)))

(deftype alist ()
  "Type designator for ALIST. Implemented as a SATISFIES type, hence not recommended for performance intensive use. Main usefullness as a type designator of the expected type in a TYPE-ERROR."
  '(satisfies alistp))

(defun cdr-assoc (item alist)		;this is the name LispWorks uses
  "Return the value associated with ITEM in ALIST."
  (cdr (assoc item alist)))

(defun alist-keys (alist)
  "Returns a list of the keys in ALIST."
  (mapcar #'car alist))

(defun alist-values (alist)
  "Returns a list of the values in ALIST."
  (mapcar #'cdr alist))



;;; plists

(defun plistp (value)
  "Returns VALUE if it is a properly formed PLIST, NIL otherwise."
  (when (listp value)
    (loop :for rest :on value :by #'cddr
       :unless (and (keywordp (car rest))
                    (cdr rest))
       :do (return nil)
	  :finally (return value))))

(deftype plist ()
  "Type designator for PLIST. Implemented as a SATISFIES type, hence not recommended for performance intensive use. Main usefullness as a type designator of the expected type in a TYPE-ERROR."
  '(satisfies plistp))

(defmacro defprop (symbol value indicator)
  "Gives SYMBOL an INDICATOR property of VALUE.
After this is done (CL:GET symbol indicator) returns VALUE"
  (when (not (symbolp symbol))
    (error "~S is not a symbol" symbol))
  `(setf (get ',symbol ',indicator) ',value))
