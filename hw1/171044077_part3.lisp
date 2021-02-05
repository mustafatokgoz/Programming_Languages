;; Mustafa Tokgöz 171044077 / Homework 0 / Part 3

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

;;This function is converting str string to numbers
;;Returning list of numbers
;;This function is using read function
(defun to-numbers (str)
  (with-input-from-string (ss str)
    (loop
      :for number :=(read ss nil)
      :while number
      :collect number))
    )

;;This is for opening file and writng elements to file
(with-open-file (my-file "collatz_output.txt" :direction :output
                                    :if-exists :supersede
                                    :if-does-not-exist :create)

;;This recursive function is checking checking and
;;wrting file the collatz numbers
;;with recursively
;;The parameter num is number
;;In function, If number is odd then number is assigned number/2
;; else number is assigned number * 3 + 1
(defun collatz-sequence(num)
  (if (= num 1)
    (progn
      (format my-file "1")
      (return-from collatz-sequence num)
      )
    )
    (if  (= (mod num 2) 0)
        (progn
            (format my-file "~D " num)
            (collatz-sequence (/ num 2))
          )
        (progn
          (format my-file "~D " num)
          (collatz-sequence (+ (* num 3) 1))
          )
      )
  )
;;This assignment for reading filename
(setq given (read-file "integer_inputs.txt"))

;;This function is to parse list to string
;;The parameter lst is list
;;This function returns string of given list
(defun list-to-string (lst)
    (format nil "~{~A~}" lst))

;;This assignment for creating string with the list-to-string function
(setq mystr (list-to-string given))

;;This assignment for creating list of numbr with the to-numbers function
(setq nums (to-numbers mystr))

;;This coerce is converting list to array
(setq arr (coerce nums 'array))

;;This assignment is legth of the array arr
(setq times (length arr))

;;If array legth is bigger than 5 then it assigns 5 to times variable
(if (> (length arr) 5)
  (setf times 5)
  )

;;This loop  for writing elements to file and calling collatz-sequence
(dotimes (i times)
  (format my-file "~D: " (aref arr i))
  (collatz-sequence (aref arr i))
  (format my-file "~%")
  )

) ;; This close parantes for with-open-file function

(print "Successful")
