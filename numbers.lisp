;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: ALEXANDRIA+ -*-
;;; Copyright (c) 2022 by Symbolics Pte. Ltd. All rights reserved.
(in-package #:alexandria+)

(define-modify-macro multf (coefficient) *
  "Multiply place by COEFFICIENT.")

