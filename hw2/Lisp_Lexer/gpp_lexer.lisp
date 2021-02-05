;; Mustafa Tokgöz 171044077 / Homework 1 / Part 2

;;This fucntion is defined for reading file
;;When the file is reading , this function collects lines as a list element
;;This function is using the read-line function to read the file
;;For reading every line , loop is used
;;In loop , this method collecting lines
;;This function returns a list that include lines as a list element
;;The parameter is filename that type of it is string
(defun read-file (filename)
(with-open-file (in filename)
  (loop
    :for line := (read-line in nil)
    :while line
    :collect line
      )
    )
  )


;;This function is for controlling that A character is space or not
;;In this function, char function is used to compare the characters
;;This function returns true if they are equal
(defun cspace (i)
  (char= #\Space (char mystr i))
  )
;;This function is for controlling that A character is close  parantes or not
;;In this function, char function is used to compare the characters
;;This function returns true if they are equal
(defun cparantes (i)
  (char= #\) (char mystr i))
  )
;;This function is for controlling that A character is open  parantes or not
;;In this function, char function is used to compare the characters
;;This function returns true if they are equal
(defun oparantes (i)
  (char= #\( (char mystr i))
  )

;;This is for writing file the contexts
(with-open-file (myfile "parsed_lisp.txt" :direction :output
                                            :if-exists :supersede
                                             :if-does-not-exist :create)



;;This is for assigning blank
(setq str "")

;;This function setting str string for merging characters
;;The parameter i is for finding character of the string
(defun setstring (i)
  (setf str (concatenate 'string str (list (char mystr i))))
  )

;;This function is setting str string to empty string
(defun setblank ()
  (setf str "")
  )

;;This assignment for craating a list that includes a nil element
(setq al (list nil))

;;This function is checking if str string is empty or not
;;If the length of the string is 0 then returns true
;;Else the list is not empty and returns false
;;The parameter is a string
(defun is-empty (str)
  (/= (length str) 0)
 )

;;This is function that returns the equal string with respect to
;;given str
;;If it is not equal anyone then returns "F"
(defun is-keyword-op (str)
    (cond
        ((string-equal str "and") (return-from is-keyword-op "KW_AND"))
        ((string-equal str "or") (return-from is-keyword-op "KW_OR"))
        ((string-equal str "if") (return-from is-keyword-op "KW_IF"))
        ((string-equal str "not") (return-from is-keyword-op "KW_NOT"))
        ((string-equal str "equal") (return-from is-keyword-op "KW_EQUAL"))
        ((string-equal str "less") (return-from is-keyword-op "KW_LESS"))
        ((string-equal str "nil") (return-from is-keyword-op "KW_NIL"))
        ((string-equal str "list") (return-from is-keyword-op "KW_LIST"))
        ((string-equal str "append") (return-from is-keyword-op "KW_APPEND"))
        ((string-equal str "concat") (return-from is-keyword-op "KW_CONCAT"))
        ((string-equal str "set") (return-from is-keyword-op "KW_SET"))
        ((string-equal str "deffun")(return-from is-keyword-op "KW_DEFFUN"))
        ((string-equal str "for") (return-from is-keyword-op "KW_FOR"))
        ((string-equal str "exit") (return-from is-keyword-op "KW_EXIT"))
        ((string-equal str "load") (return-from is-keyword-op "KW_LOAD"))
        ((string-equal str "disp") (return-from is-keyword-op "KW_DISP"))
        ((string-equal str "true") (return-from is-keyword-op "KW_TRUE"))
        ((string-equal str "false") (return-from is-keyword-op "KW_FALSE"))
        ((string-equal str "+") (return-from is-keyword-op "OP_PLUS"))
        ((string-equal str "-") (return-from is-keyword-op "OP_MINUS"))
        ((string-equal str "/") (return-from is-keyword-op "OP_DIV"))
        ((string-equal str "*") (return-from is-keyword-op "OP_MULT"))
        ((string-equal str "**") (return-from is-keyword-op "OP_DBLMULT"))
        ((string-equal str "”") (return-from is-keyword-op "OP_CC"))
        ((string-equal str "“") (return-from is-keyword-op "OP_OC"))
        ((string-equal str ",") (return-from is-keyword-op "OP_COMMA"))
        ((string-equal str ";;") (return-from is-keyword-op "COMMENT"))
        ("F")
        )

  )



 ;;this function takeing a string and pushing to the list al
 ;;and settting string to ""
(defun push-to-lis (str)
  (push str (cdr (last al)))
  (setblank)
 )


;;This function is checking if str is identifier or not
;;If identifier is not fitting the definition of pdf then it returns 1
;;else returns 0
(defun is-id (str)
    (if (= (length str) 1)
        (if (alpha-char-p (char str 0))
            (return-from is-id 0)
        )
    )
    (dotimes (i (length str))
        (cond (
          (= i 0)
          (if (alpha-char-p (char str 0))
              ()
              (return-from is-id 1)
          )
          )
          (
            (if (alphanumericp (char str i))
                ()
                (return-from is-id 1)
              )

          )
        )
      )
    (return-from is-id 0)

)

;;This function is checking if the str is value or Not
;; IF value has leading zero then it returns 1
(defun is-value (str)
  (if (= (length str) 1)
    (if (digit-char-p (char str 0))
        (return-from is-value 0)
    )
    )
    (dotimes (i (length str))
      (cond
          ((= i 0)
           (if (char= #\0 (char str 0))
              (return-from is-value 1)
           )
          )
          ((digit-char-p (char str i))
           ()
          )
          (
            (return-from is-value 1)

          )
        )
      )

      (return-from is-value 0)
    )


;;This is for passing the line when comment
(setq flag 0)

;;This function is controlling str and writing to file
;; checking comment and passing that line
;; checking identifier and value
(defun control (str alist)
  (setf temp (is-keyword-op str))
      (if (string-equal "COMMENT" temp)
          (progn
            (format myfile "~d" temp)
            (format myfile "~%")
            (setblank)
            (setf flag 1)
          )
      )

      (if (string-equal "F" temp)
          (progn
            (cond
              ( (> (length str) 1)
                (if (and (char= #\; (char str 0)) (char= #\; (char str 1)))
                    (progn
                      (format myfile "COMMENT")
                      (format myfile "~%")
                      (setblank)
                      (setf flag 1)
                      )
                  )
                ))

                (cond ((> (length str) 0)

                      (if (and (= (is-id str) 0) (= flag 0))
                      (progn
                        (format myfile "IDENTIFIER")
                        (format myfile "~%")
                        (setblank)
                        (return-from control 0)
                        )

                      )
                      (if (= (is-value str) 0)
                      (progn
                        (format myfile "VALUE")
                        (format myfile "~%")
                        (setblank)
                        (return-from control 0)
                        )
                      )

                    )
                )
                (if (= flag 0)
                (progn
                (format myfile "SYNTAX_ERROR ~d can not be tokenized" str)
                (format myfile "~%")
                (setblank)
                )
                )

            )
          )


        (if (and (= flag 0) (string-not-equal "F" temp))
          (progn
          (format myfile "~d" temp)
          (format myfile "~%")
          (setblank)
        ))


)


;; This function is tokenizing one by one recursively
(defun tokenize (lst)
  (setblank)
  (setf flag 0)
  (cond ((null (car lst)) )
      (
        (setq mystr (concatenate 'string (write-to-string (car lst))))
        (dotimes (i  (length mystr))
          (cond
            ((= i 0))
            ((= i (- (length mystr) 1 )))
            (
            (oparantes i)
              (if (is-empty str)
                  (control str lst)
                )
                (format myfile "OP_OP~%")
              )

            (
            (cparantes i)
              (if (is-empty str)
                  (control str lst)
                )
                (format myfile "OP_CP~%")
              )
            ((cspace i)
              (if (is-empty str)
                  (control str lst)
                )

            )
          ((setstring i))
          )

        )
        (if (is-empty str)
            (control str lst)
        )

        (tokenize (cdr lst))


    )
  )
)

;;This function is gppinterpreter that starts the analysing

(defun gppinterpreter (filename repl)
    (if (= repl 0)
        (progn
          (setq given (read-file filename))
          (tokenize given)
          )
        (progn
              (setq tempp ".")
              (loop while (not (equal tempp ""))
                do
                  (setq tempp (read-line))
                  (push-to-lis tempp)

              )
              (setf al (cdr al))
              (tokenize al)
            )
          )
    )


;;This is initilizing
(if *args*
    (gppinterpreter (car *args*) 0)
    (gppinterpreter " " 1)
)



)
