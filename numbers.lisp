;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: ALEXANDRIA+ -*-
;;; Copyright (c) 2022-2024 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL
(in-package #:alexandria+)

(define-modify-macro multf (coefficient) *
  "Multiply place by COEFFICIENT.")

(defmacro divf-internal (value divisor)
  (if divisor
      `(let ((e-val ,value)
             (e-div ,divisor))
         (if e-div
             (/ e-val e-div)
             (/ 1 e-val)))
      `(/ 1 ,value)))

(define-modify-macro divf (&optional divisor) divf-internal
  "Divide place by DIVISOR.  If DIVISOR is not given, divide by 1.")

