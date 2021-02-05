;; Mustafa Tokgöz 171044077 / Homework 0 / Part 2

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
;;This function is calculating modulo of paramters
(defun modula (a b)
  (mod a b)
)

;;This function is calculating flag for if the number is prime or not
;;If modulo of numbers is equal to 0 then icreasing flag
;;Returning the flag
;;The parameter num is number
;;This function is using loop
(defun to-find-prime (num)
  (setq flag 0)
  (dotimes (i num)
      (if   (= (modula num (+ i 2)) 0)
        (setf flag (+ flag 1))
      )
    )
  (setq rt flag)
 )

 ;;This function is finding semi prime numbers
 ;;This function firstly looking prime numbers then if it actually approprite then icreasing
 ;;the flag two
 ;;This function returning the flagtwo
 ;;This function is using loop
 (defun to-find-semi-prime (num)
   (setq flagtwo 0)
   (dotimes (k num)
       (if   (= (modula num (+ k 2)) 0)
         (cond ((= (to-find-prime (+ k 2)) 1)
            (setf flagtwo (+ flagtwo 1))
            ;;checking same prime is squared of the number or not then icreasing
            (if (= (* (+ k 2) (+ k 2)) num)
                (setf flagtwo (+ flagtwo 1))
              )
            )
            (())
            (())
          )
       )
     )
   (setq rt flagtwo)
  )

;;This assignment for reading filename
(setq given (read-file "boundries.txt"))

;;This function is to parse list to string
;;The parameter lst is list
;;This function returns string of given list
(defun list-to-string (lst)
    (format nil "~{~A~}" lst))

;;This assignment for creating string with the list-to-string function
(setq mystr (list-to-string given))

;;This assignment for creating list of numbr with the to-numbers function
(setq nums (to-numbers mystr))

;;This is for boundries
;;This assigning the first number
(setq first (nth 0 nums))

;;This assigning the second number
(setq second (nth 1 nums))

;;If the second boundrie is less than first then is swaps
(if (< second first)
    (progn (setq temp second)
      (setf second first)
      (setf first temp)
      )
  )

;;This is for writing elements with loop to file
(with-open-file (my-file "primedistribution.txt" :direction :output
                                              :if-exists :supersede
                                              :if-does-not-exist :create)

;;This loop for writing prime and semiprime numbers
;;If the flag is 1 then it is prime number
;;Else if flag is 2 or 3 then it looks that is semi-prime or not with function
;; Then writing the file
;;loops from i to second-first + 1
(dotimes (i (+ (- second first) 1))
    (setq rest (to-find-prime ( + i first)))
    (cond ( (= rest 1)
          (format my-file "~D : is prime number ~%" (+ i first) )
          )
          ( (or (= rest 2) (= rest 3))
            (if (= (to-find-semi-prime (+ i first)) 2)
                (format my-file "~D : is semi-prime number ~%" (+ i first))
            )
          )
          (())
      )
  )
)
(print "Successful")
