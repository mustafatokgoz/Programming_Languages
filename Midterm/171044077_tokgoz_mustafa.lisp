(defun read-file (filename)
(with-open-file (in filename)
  (loop
    :for line := (read-line in nil)
    :while line
    :collect line
      )
    )
)



(setq factlist '())
(setq factlistr '())
(setq predicatelist '())
(setq predicatelistr '())

;; for fact
(defun for-fact (lst)
    (setq temp (nth 0 lst))
    (if (null (nth 1 lst))
        (progn
          (push (nth 0 temp) factlist)
          (push (nth 1 temp) factlistr)
          )
    )
)
;; for predicate
(defun for-predicate(lst)
  (if (null (nth 0 lst))
      ()
      (progn
        (if (null (nth 1 lst))
            ()
            (progn
              (push (nth 0 lst) predicatelist)
              (push (nth 1 lst) predicatelistr)
            )
        )
      )
  )
)

;; checking list equality
(defun check-list-equal(lst1 lst2)
  (and (eq (null (intersection lst1 lst2)) nil)
  (null (set-difference lst1 lst2))
  )

)
;;unification for predicate
(defun unification-for-predicate(lst)

    (dotimes (i (length factlist))

        (if (equal (nth i factlist) (nth 0 lst))
            (progn
                (if (check-list-equal (nth i factlistr) (nth 1 lst))
                    (progn
                          (return-from unification-for-predicate 1)
                        )
                        (return-from unification-for-predicate 0)
                    )
                )

              )
        )
    0
)


;;unification
(defun unification (lst)
  (setq temp (nth 1 lst))

  (if (null (nth 0 lst))
    (progn
      (dotimes (i (length factlist))
          (if (equal (nth i factlist) (nth 0 temp))
              (progn
                  (if (check-list-equal (nth i factlistr) (nth 1 temp))
                      (progn
                            (return-from unification 1)
                          )
                          (return-from unification 0)
                      )
                  )

                )
          )
        (dotimes (i (length predicatelist))
            (setq pred (nth i predicatelist))
            (if (equal (nth 0 pred) (nth 0 temp))
                (progn
                  (setq param (nth 1 pred))
                  (setf ch (nth 0 param))
                  (setf tt 1)
                  (if (= tt 1)
                      (progn
                          (if (equal (nth 1 param) (nth 1 (nth 1 temp)))
                              (progn
                                (setq prtemp3 '())

                                (dotimes (j (length (nth i predicatelistr)))
                                    (setq prtemp '())
                                    (setq prtemp2 '())

                                    (setq ff (nth 1 (nth j (nth i predicatelistr))))
                                    (push  (nth 0 (nth j (nth i predicatelistr))) prtemp2)
                                    (dotimes (k (length ff))

                                            (if (equal (nth k ff) (nth 0 param))
                                                (progn
                                                  (push (nth 0 (nth 1 temp)) prtemp)
                                                  )
                                                  (progn
                                                    (push (nth k ff) prtemp)
                                                    )
                                            )

                                        )
                                    (push prtemp prtemp2)
                                    (setf prtemp2 (reverse prtemp2))
                                    (push prtemp2 prtemp3)

                                )
                                (setq res 0)
                                (dotimes (m (length prtemp3))
                                  (setq res (+ res (unification-for-predicate (nth m prtemp3))))
                                )
                                (if (= res (length prtemp3))
                                  (return-from unification 1)
                                  (return-from unification 0)
                                )
                              )
                            )
                          )

                      (


                        )

                  )

            )

            )
        )
        (return-from unification 0)
      )
    )
  2
)

(setq lastresult '())
;; resolution
(defun resolution (lst)
    (setq i 1)
    (cond ((null (car lst) ))
        (
          (if (= (length lst) i)
              ()
              (progn
                  (setq mystr (concatenate 'string (write-to-string (car lst))))
                  (setq ll (read-from-string mystr))
                  (setq ls (read-from-string ll))
                  (for-fact ls)
                  (for-predicate ls)
                  (setq check (unification ls))
                  (cond   (
                            (= 1 check)
                            (push '("true") lastresult)
                            )
                            (
                              (= 2 check)
                            )
                            (
                              (= 0 check)
                              (push '(()) lastresult)
                              )

                  )
                  (resolution (cdr lst))
                  (setq i (+ i 1))
              )
          )
          )
    )

)

(setq given (read-file "input.txt"))
(resolution (cdr given))
(setf lastresult (reverse lastresult))
;;This is for writing file the contexts
(with-open-file (myfile "output.txt" :direction :output
                                            :if-exists :supersede
                                             :if-does-not-exist :create)
    (format myfile "~A" lastresult)
)
(print lastresult)
