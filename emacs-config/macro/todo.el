(defvar user-todo-global-file "~/.todo"
  "Path to the todo file used by `user-todo-quick-jump' and friends.")

(defun user-todo-quick-enter ()
  "Prompts for a new todo item to be inserted into the global todo file."
  (interactive)
  (let ((item (read-string "TODO: ")))
    (if (string= "" item)
        (user-todo-quick-jump)
      (user-todo-add-global-item item))))

(defun user-todo-quick-jump ()
  "Visits the global todo file."
  (interactive)
  (find-file user-todo-global-file))

(defun user-todo-add-global-item (item)
  "Adds an item to the global todo file."
  (save-excursion
    (set-buffer (find-file-noselect user-todo-global-file))
    (when (not (= (point-min) (point-max)))
      (goto-char (point-max))
      (insert "\n"))
    (insert item)
    (user-todo-toggle))
  (message "TODO: Item added."))

(defun user-todo-toggle ()
  "Toggles the todo state if it's active, otherwise activates it. "
  (interactive)
  (save-excursion
    (move-beginning-of-line 1)
    (if (string= (char-to-string (char-after)) "[")
        (user-todo-toggle-status)
      (insert "[ ] "))
    (save-buffer)))

(defun user-todo-done? ()
  "Is this line a done todo item?"
  (save-excursion
    (move-beginning-of-line 1)
    (search-forward "[ ]" (+ 3 (point)) t)))

(defun user-todo-toggle-status ()
  "Toggle the todo state."
  (interactive)
  (save-excursion
    (if (user-todo-done?)
        (user-todo-set-done)
      (user-todo-set-begun))))

(defun user-todo-set-begun ()
  "Set a todo item as begun."
  (user-todo-set-status " "))

(defun user-todo-set-done ()
  "Set a todo item as done."
  (user-todo-set-status "X"))

(defun user-todo-set-status (status)
  "Give the current todo item to an arbitrary status."
  (save-excursion
    (move-beginning-of-line 1)
    (forward-char 1)
    (delete-char 1)
    (insert status)))

(defun user-todo-move-item-up ()
  "Moves the focused todo item down a line."  
  (interactive)
  (save-excursion
    (beginning-of-line 1)
    (when (not (= (point-min) (point)))
      (let ((word (delete-and-extract-region (point) (point-at-eol))))
        (delete-char 1)
        (forward-line -1)
        (insert (concat word "\n")))
      (save-buffer)))
  (when (not (= (point-min) (point)))
    (forward-line -2)))

(defun user-todo-move-item-down ()
  "Moves the focused todo item up a line."    
  (interactive)
  (let (eof chars)
    (setq chars (- (point) (point-at-bol)))
    (save-excursion
      (end-of-line 1)
      (setq eof (= (point-max) (point)))
      (when (not eof)
        (let ((word (delete-and-extract-region (point-at-bol) (point))))
          (delete-char 1)
          (forward-line 1)
          (insert (concat word "\n")))
        (save-buffer)))
    (when (not eof)
      (forward-line 1)
      
)))
