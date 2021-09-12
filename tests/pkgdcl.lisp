;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: CL-USER -*-
;;; Copyright (c) 2021 by Symbolics Pte. Ltd. All rights reserved.

(uiop:define-package :alexandria+/tests
    (:use :cl :alexandria+ :parachute)
  (:export #:run-tests))
