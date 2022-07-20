;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: ASDF -*-
;;; Copyright (c) 2021-2022 by Symbolics Pte. Ltd. All rights reserved.

(defsystem "alexandria+"
  :description "A conservative set of extensions to Alexandria utilities."
  :long-description "Utilities not in Alexandria, UIOP or OSICAT."
  :author "Steven Nunez <steve@symbolics.tech>"
  :homepage "https://github.com/symbolics/alexandria+"
  :license :MS-PL
  :version "1.0.0"
  :depends-on ("alexandria")
  :components ((:file "pkgdcl")
	       (:file "lists")
	       (:file "types")
	       (:file "control-flow"))
  :in-order-to ((test-op (test-op :alexandria+/tests))))

(defsystem "alexandria+/tests"
  :description "Unit tests for the ALEXANDRIA+ library."
  :license :MS-PL
  :depends-on ("alexandria+" "parachute")
  :pathname "tests/"
  :components ((:file "pkgdcl")
	       (:file "tests"))
  :perform (test-op (o c) (symbol-call :alexandria+/tests :run-tests)))
