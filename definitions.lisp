;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: ALEXANDRIA+ -*-
;;; Copyright (c) 2026 Symbolics Pte. Ltd. All rights reserved.
(in-package #:alexandria+)

(defmacro defprop (symbol value indicator)
  "Gives SYMBOL an INDICATOR property of VALUE.
After this is done (CL:GET symbol indicator) returns VALUE"
  (when (not (symbolp symbol))
    (error "~S is not a symbol" symbol))
  `(setf (get ',symbol ',indicator) ',value))

(defmacro defalias (new-name old-name &optional docstring)
  "Defines NEW-NAME as an alias for the function OLD-NAME.
Both NEW-NAME and OLD-NAME can be symbols or (SETF symbol) lists.
The optional DOCSTRING is assigned to NEW-NAME."
  `(progn
     (setf (fdefinition ',new-name) (fdefinition ',old-name))
     ,@(when docstring
         `((setf (documentation ',new-name 'function) ,docstring)))
     ',new-name))
