;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Name: 		Byron Dowling
;;  Course:		CMPS 5113 A.P.L.C
;;  Semester:	Fall, 2022	
;;  Assignment:	Program 1 - LISP Scheme - Perfect Numbers
;;
;;      A perfect number N is a positive integer such that the sum of the proper divisors less than N is
;;      equal to N. If the sum is greater than N, the number is abundant. If the sum is less than N, the
;;      number is deficient.
;;
;;      Examples:
;;
;;      - 6 is a perfect number because 1 + 2 + 3 = 6
;;      - 12 is abundant because 1 + 2 + 3 + 4 + 6 > 12
;;      - 14 is deficient because 1 + 2 + 7 < 14
;;
;;      Write a program that classify a number as perfect, abundant, or deficient following the guidelines
;;      below:
;;
;;          - As with all programs, include your name and explanation of program in comments at
;;            the top of your program as well as in code output.
;;
;;          - Use one or more functions to determine the classification of the number. Use tail
;;            recursion to sum the factors of the given number.
;;
;;      Code can be run from here: https://replit.com/@ByronDowling/Perfect-Numbers-1#main.scm 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Header info for printing purposes
(print "\nByron Dowling")
(print "CMPS 5113 APLC")
(print "Semester: Fall 2022")
(print "Program 1 - Program 1 - LISP Scheme - Perfect Numbers\n\n")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  If improper input is read, this function is called to relay message
;;
;;  User is returned to the main block to try again
;;  This seems to make the proper input mulyiple times, cannot determine 
;;  how to undo this currently. But I wanted to handle improper input
;;  edge cases since zero or any negative number cannot be a perfect number.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (ErrorMessage number)
  (print "\nBy definition, perfect numbers must be positive." )
  (print number " is not positive.\n")
  (MainBlock)   ;; Return to main 
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  This function helps compute the factors of the number in question. After
;;  receiving the floor of the target number / 2, we increment from that
;;  result down to 1 while checking if the target number % factor == 0. 
;;
;;  If the result is zero, this means that the factor is a factor of our 
;;  target number and we need to add the result to the running total. 
;; 
;;  We do this using tail recursion as we add the factor to the chain of the 
;;  next recursive call. If the factor is not a factor of our target, we 
;;  simply recursively call without doing the addition and we decrement the 
;;  factor variable. Once the factor is down to one, we simply return 1 and
;;  then the recrusive call stack process begins were we sum up 1 + the result
;;  of the previous recursive call, so on and so on.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (ModularArithmetic number factor)
  ;; Handle case when factor is reduced to one
  ;; Will result in 1 + *previous recursive call...
  (if (= factor 1)
    1
    
    ;; If our number % factor == 0
    (if (= (mod number factor) 0)

        ;; Chained recursive addition of factors if condition is true
        ;; Recursively call ModArith with factor-- factor + *previous call
        (+ (ModularArithmetic number (- factor 1)) factor)

        ;; No operation if condition is false
        ;; Recursively call ModArith with factor--
        (ModularArithmetic number (- factor 1))
    )
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Main Driver Function
;;
;;  The number read from stdinput is sent here to begin the evaluation process.
;;  To start the evalutaion proess of evaluating the factors of the given number
;;  we need to check up to half the number. 
;;     For example:
;;       28: We only need to check 1-14
;;       21: We need to check 1-10
;;
;;  The reason we are taking the floor of the (number / 2) is that if we just do the
;;  number / 2, Scheme will convert it to floating point and throw off the calculation.
;;  We send the original target number as well as the facgtor threshold number to our
;;  ModularArithmetic function which will calculate our factors and sum them up through
;;  tail recursion. That result is returned here at which point, if the summed number
;;  equals our original number, it is a perfect number. If it is greater than the number
;;  it is abundant, and if its less, its deficient.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (PerfectNumber number)
  (if (= number (ModularArithmetic number (floor (/ number 2))) number)
    (print number " is a Perfect number")
    (if (< number (ModularArithmetic number (floor (/ number 2))))
        (print number " is Abundant")
        (print number " is Deficient")
      )
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Defined a main block so that if improper input is entered, we have a place
;;  to return the user to and be reprompted to enter a number again. This is
;;  mainly for error handling only.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (MainBlock)

  ;; Prompt to start program
  (print "Please enter a positive number greater than 1 to see if it is Perfect, Abundant, or Deficient.")

  ;; Define the number read from stdinput
  (define number (read))

    ;; if the number is zero or less, it can't be perfect
    ;; Send to error message function
    (if (<= number 1)
      (ErrorMessage number)
    )

  ;; If proper input is read, send to main driver function
  (if (> number 1)
    (PerfectNumber number))
)

;; Calling main to start the actual program process
(MainBlock)
