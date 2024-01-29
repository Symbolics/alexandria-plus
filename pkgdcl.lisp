;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: CL-USER -*-
;;; Copyright (c) 2021-2024 Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL

(uiop:define-package #:alexandria+
  (:use :cl :alexandria)
  (:export #:alist
	   #:plist
	   #:alistp
	   #:plistp
	   #:alist-keys
	   #:plist-keys
	   #:alist-values
	   #:plist-values

	   ;; Types
	   #:probability
	   #:percentage

	   ;; Utilities
	   #:defprop

	   ;; Control Flow
	   #:unlessf

	   ;; Numbers
	   #:multf
	   #:divf

           ;; Sets
           #:set-difference*))
