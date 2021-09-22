;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: ALEXANDRIA+ -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.

(in-package #:alexandria+)

;;;; Types and functions that extend those of Alexandria, commonly
;;;; used in statistics and probability

(deftype probability ()
  "A number between 0 and 1"
  `(real 0 1))

(deftype percentage ()
  "A number between 0 and 100"
  `(real 0 100))
