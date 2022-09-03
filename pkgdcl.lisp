;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: CL-USER -*-
;;; Copyright (c) 2021-2022 Symbolics Pte. Ltd. All rights reserved.

(uiop:define-package :alexandria+
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
	   #:multf))
