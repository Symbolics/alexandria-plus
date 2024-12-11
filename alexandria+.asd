;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: ASDF -*-
;;; Copyright (c) 2021-2024 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL

(defsystem "alexandria+"
  :description "A conservative set of extensions to Alexandria utilities."
  :long-description "Utilities not in Alexandria, UIOP or OSICAT."
  :author "Steven Nunez <steve@symbolics.tech>"
  :homepage "https://github.com/symbolics/alexandria+"
  :license :MS-PL
  :version "1.2.1"
  :depends-on ("alexandria")
  :components ((:file "pkgdcl")
	       (:file "lists")
	       (:file "types")
	       (:file "numbers")
	       (:file "control-flow")
	       (:file "sets"))
  :in-order-to ((test-op (test-op :alexandria+/tests))))

(defsystem "alexandria+/tests"
  :description "Unit tests for the ALEXANDRIA+ library."
  :license :MS-PL
  :depends-on ("alexandria+" "clunit2")
  :pathname "tests/"
  :components ((:file "pkgdcl")
	       (:file "tests"))
  :perform (test-op (o s)
		    (let ((*print-pretty* t)) ;work around clunit issue #9
		      (symbol-call :clunit :run-suite
				   (find-symbol* :alexandria+ ;test suite
						 :alexandria+/tests) ;package
				   :use-debugger nil))))
