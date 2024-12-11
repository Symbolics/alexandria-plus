;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: ALEXANDRIA+ -*-
;;; Copyright (c) 2024 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL
(in-package #:alexandria+)

;;; Implement set operations on both lists and sequences

;;; See: https://www.reddit.com/r/Common_Lisp/comments/s4rql2/modern_sequence_abstractions/

;;; Adapted from CCL's set functions.


;;; CCL note:
;;; Use this with the following keyword args to your set function:
;;;  (&key (key #'identity) (test #'eql testp) (test-not nil notp))

(eval-when (eval compile #-bccl load)
 (defmacro with-set-keys (funcall)
   `(cond (notp ,(append funcall '(:key key :test-not test-not)))
          (t ,(append funcall '(:key key :test test))))))

;;; Comment from CCL:lib;lists.lisp
;;; Works with the above keylist.  We do three clauses so that if only
;;; test-not is supplied, then we don't test eql.  In each case, the
;;; args should be multiply evaluable.
;;; In CCL, this macro is defined but never used.

(defmacro elements-match-p (elt1 elt2)
  `(or (and testp
	    (funcall test (funcall key ,elt1) (funcall key ,elt2)))
       (and notp
	    (not (funcall test-not (funcall key ,elt1) (funcall key ,elt2))))
       (eql (funcall key ,elt1) (funcall key ,elt2))))


;;; Helper macros
;;; This allows us to use the same iteration construct over lists and vectors.
;;; From https://github.com/Lovesan/lvsn-utils/blob/34505203c953c8418272708c13ddf1d494cdbe26/src/macros.lisp
;;; Not exported

(defmacro doseq ((var sequence &optional return-form) &body body)
  (with-gensyms (i length tag seq)
    `(prog* ((,seq ,sequence)
             (,length (length ,seq))
             (,i 0))
        (declare (type array-index ,i ,length))
        ,tag
        (unless (< ,i ,length)
          (return ,return-form))
        (let ((,var (elt ,seq ,i)))
          ,@body)
        (incf ,i)
        (go ,tag))))

(defmacro doseq* ((var sequence) &body body)
  (with-gensyms (seq)
    `(let ((,seq ,sequence))
       (map (type-of ,seq) (lambda (,var) ,@body) ,seq))))



(defun set-difference* (seq1 seq2 &key key
                             (test #'eql testp) (test-not nil notp))
  "Return the elements of SEQ1 which are not in SEQ2.

Returns:
    If sequences are lists, then a list is returned.  If vectors, a vector is returned."
  ;; Do they really need to be of the same type?
  (unless (equalp (class-of seq1) (class-of seq2)) ;type-of is too specific
    (error "SEQ1 and SEQ2 must both be of the same type."))
  (when (and testp notp)
    #+ccl (ccl::test-not-error test test-not)
    #-ccl (error ":TEST and :TEST-NOT were both supplied."))
  (unless key (setq key #'identity))

  (let ((res (make-array (max (length seq1)
			      (length seq2))
			 :fill-pointer 0)))
    (doseq (value seq1 res)
      (if (not (with-set-keys (position (funcall key value) seq2)))
          (vector-push value res)))
    (typecase seq1
      (vector res)
      (cons (coerce res 'list)))))


;;; This doesn't require the doseq macro.  CCL doesn't have a
;;; dosequence macro, and if one cannot be added, this is an
;;; alternative.
#+nil
(etypecase seq1
  (list (dolist (elt seq1 res)
	  (if (not (with-set-keys (position (funcall key elt) seq2)))
	      (push elt res))))
  (sequence (do* ((x 0 (1+ x))
		  (elt (aref seq1 x) (aref seq1 x) ))
		 ((= x (1- (length seq1)))
		  (coerce res 'vector)) ;make vector default return
	      (if (not (with-set-keys (position (funcall key elt) seq2)))
		  (push elt res)))))
