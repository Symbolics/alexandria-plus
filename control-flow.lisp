;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: ALEXANDRIA+ -*-
;;; Copyright (c) 2025 Symbolics Pte. Ltd. All rights reserved.
(in-package #:alexandria+)

;; Alias alexandria's line-up-first to thread-first -- line-up-first is a macro and SBCL doesn't like this
;; (setf (fdefinition #'alexandria-2:line-up-first) 'thread-first)
;; (setf (fdefinition 'thread-first) (fdefinition 'alexandria-2:line-up-first))
;; (setf (fdefinition 'thread-first) (symbol-function 'alexandria-2:line-up-first))

(defmacro unlessf (place value-form &environment environment)
  "When PLACE is NIL, evaluate VALUE-FORM and save it there.

  PLACE is a generalized reference where the result will be stored.
  VALUE-FORM is the form to be evaluated and stored in PLACE if PLACE is NIL.

  Example usage:
    (let ((x nil))
      (unlessf x 42)
      x) ; => 42"
  (multiple-value-bind (vars vals store-vars writer-form reader-form)
      (get-setf-expansion place environment)
    `(let* ,(mapcar #'list vars vals)
       (unless ,reader-form
         (let ((,(car store-vars) ,value-form))
           ,writer-form)))))

