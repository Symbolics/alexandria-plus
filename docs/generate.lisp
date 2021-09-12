;;;
;;;

;;; Note: The next version of declt will output Markdown formatted
;;; text.

(defconstant +copyright-years+ "2021")
(setf *default-pathname-defaults* #P"s:/src/alexandria+/docs/") ;TODO: take path from system location
(asdf:load-system :net.didierverna.declt)
(net.didierverna.declt:nickname-package)

(declt:declt :alexandria+
	     :library-name "Alexandria+"
	     :copyright-years +copyright-years+
	     ;; :license :boost
	     :declt-notice nil
	     ;; :introduction +introduction+
	     ;; :conclusion +change-log+
	     ;; :texi-file "select.texi"
	     :hyperlinks t)
(uiop:quit)
