;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: ALEXANDRIA+ -*-
;;; Copyright (c) 2022-2024 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL
(in-package #:alexandria+)

(define-modify-macro multf (coefficient) *
  "Multiply place by COEFFICIENT.")

(define-modify-macro divf (&optional divisor)
  (lambda (value divisor)
    (if (null divisor)
      (/ 1 value)
      (/ value divisor)))
  "Divide place by DIVISOR.  If DIVISOR is not given, divide by 1.")
