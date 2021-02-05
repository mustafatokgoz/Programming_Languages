;; Mustafa Tokgöz 171044077 / Homework 0 / Part 1

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
;;This assignment for creating a list with the read-file function
;;If you want to change the file , You should change the file name or content of the file
(setq given (read-file "nested_list.txt"))

;;This function is to parse list to string
;;The parameter lst is list
;;This function returns string of given list
(defun list-to-string (lst)
    (format nil "~{~A~}" lst)
    )
;;This assignment for creating string with the list-to-string function
(setq mystr (list-to-string given))
;;You can print the string of list with this function ------- > (print mystr)

;;This function is for controlling that A character is space or not
;;In this function, char function is used to compare the characters
;;This function returns true if they are equal
(defun cspace (i)
  (char= #\Space (char mystr i))
  )
;;This function is for controlling that A character is parantes or not
;;In this function, char function is used to compare the characters
;;This function returns true if they are equal
(defun cparantes (i)
  (or (char= #\) (char mystr i)) (char= #\( (char mystr i)))
  )

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
(setq a (list nil))

;;This function is checking if str string is empty or not
;;If the length of the string is 0 then returns true
;;Else the list is not empty and returns false
;;The parameter is a string
(defun is-empty (str)
  (/= (length str) 0)
 )

;;This function is pushing elemnt str to the list
;;The parameter is a string
;;This function firstly pushing the element to the list a
;;Then setting the string str to empty string
(defun push-to-lis (str)
  ;;If you want to see the elements you can print elements with this ----> (print str)
  (push str (cdr (last a)))
  (setblank)
 )
;;This is loop from i to length of mystr string
;;In this loop controlling the chaarcters If space or parantesis
;;If character is parantes then if the str string is not empty  then push the list a
;;Else if character is spcae then if the str string is not empty  then push the list a
;;Else setstring function is calling
(dotimes (i  (length mystr))
  (cond (
    (cparantes i)
      (if (is-empty str)
          ( push-to-lis str)
        )
      )
    ((cspace i)
      (if (is-empty str)
          ( push-to-lis str)
      )
    )
    ((setstring i))
    )
  )

;; a is a list for single without a nil becouse of defining list
;; cdr is for nil element
(setf a (cdr a))

;;This is for writing list a to file with format function
(with-open-file (my-file "flattened.txt" :direction :output
                                            :if-exists :supersede
                                            :if-does-not-exist :create)
  (format my-file "~A " a)
  )
(print "Your nested list is flattened in flattened.txt")
