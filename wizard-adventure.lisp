; wizard adventure game - explore (trespass?) a wizard's home

; association list (alist): associates expressions with a given symbol
(defparameter *nodes* '((living-room (you are in the living room. a wizard is snoring loudly on the couch.))
                        (garden (you are in a beautiful garden. there is a well in front of you.))
                        (attic (you are in the attic. there is a giant welding torch in the corner))))

(defparameter *edges* '((living-room (garden west door)
                                     (attic upstairs ladder))
                        (garden (living-room east door))
                        (attic (living-room downstairs ladder))))

; we can _assoc_ the alist and cadr, etc. the resulting association
(defun describe-location (location nodes)
    (cadr (assoc location nodes)))

(print (describe-location 'living-room *nodes*))

; quasi-quoting: indicated by backtick, "flopped" out of by a comma'd expression
; allows for dynamic list construction
(defun describe-path (edge)
    `(there is a ,(caddr edge) going ,(cadr edge) from here.))

; 1. find edges, 2. convert to descriptions, 3. join descriptions
; 1. (cdr (assoc 'living-room *edges*)) would give us the edges for 'living-room
; 2. _mapcar_ takes a function and a list, and applies the function to every list member (edges from step 1)
; 3. _apply_ takes two parameters, a function and _a list_ of parameters, which is supplied (applied) to _append_
(defun describe-paths (location edges)
    (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))

; _mapcar_, as a function that takes another function as a parameter, is a _higher-order_ function
; the #' is shorthand for the function operator [(function _f_)], which denotes a name as a function
; this is because clisp maintains multiple namespaces, including one for variables and one for functions
; constrasted to scheme, which does not

; since _append_ joins its parameters into a list, we need to pass the list of path descriptions as its
; consitutent items. enter _apply_, which provides the members of a list as parameters to a function.
; caution - some lisp implementations have a limit to the number of arguments that can be passed to a function

; above is a typical lisp pattern - taking complicated data and manipulating it through several steps, usually
; with higher-order functions.
