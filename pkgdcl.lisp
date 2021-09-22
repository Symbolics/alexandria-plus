;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: CL-USER -*-
;;; Copyright (c) 2021 Symbolics Pte. Ltd. All rights reserved.

(uiop:define-package :alexandria+
  (:use :cl)
  (:export #:alist
	   #:plist
	   #:alistp
	   #:plistp
	   #:alist-keys
	   #:alist-values
	   #:cdr-assoc

	   ;; Types
	   #:probability
	   #:percentage

	   ;; Utilities
	   #:defprop))
