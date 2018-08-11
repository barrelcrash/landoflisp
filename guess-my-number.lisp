;; the computer guesses your number between 1 and 100 (binary search)

;; written with global variables
(defparameter *small* 1)

(defparameter *big* 100)

(defun guess-my-number()
  (ash (+ *small* *big*) -1))

(defun smaller()
  (setf *big* (1- (guess-my-number)))
  (guess-my-number))

(defun bigger()
  (setf *small* (1+ (guess-my-number)))
  (guess-my-number))

(defun start-over()
  (defparameter *small* 1)
  (defparameter *big* 100)
  (guess-my-number))

;; local variables

