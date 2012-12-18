(add-to-list 'load-path "~/.emacs.d/vendor")

; custom place to save customizations
(setq custom-file "~/.emacs.d/custom/macro.el")
(when (file-exists-p custom-file) (load custom-file))

(when (file-exists-p ".passwords") (load ".passwords"))

(load "macro/lisp")
(load "macro/global")
(load "macro/defuns")
(load "macro/bindings")
(load "macro/modes")
;(load "macro/theme")
(load "macro/temp_files")
(load "macro/github")
(load "macro/git")
(load "macro/todo")
(load "macro/flymake-python-pyflakes")
(load "macro/erlang")
(load "macro/solarized")

;; evil > viper
;;(load "macro/viper")

(when (file-exists-p "macro/private")
  (load "macro/private"))

;;(vendor 'gist)
;;(vendor 'growl)
(vendor 'twittering-mode)
(vendor 'textile-mode)
(vendor 'yaml-mode)
(vendor 'open-file-in-github)
(vendor 'coffee-mode)
(vendor 'lua-mode)
(vendor 'any-ini-mode)
(vendor 'mustache-mode)
(vendor 'flymake-python-pyflakes)
(vendor 'python)
(vendor 'evil)
(vendor 'el-get)

;; xemacs sticky modifier keys
;; (setq modifier-keys-are-sticky t)

;; inhibit startup messages
(setq inhibit-startup-message t)

;; make the last line end in a carriage return
(setq require-final-newline t)

;; allow just "y" instead of "yes" when you exit
(fset 'yes-or-no-p 'y-or-n-p)

;; highlight matching parentheses
(require 'paren) (show-paren-mode t)

;; spaces instead of tabs by default
(setq-default indent-tabs-mode nil)

;; trucate lines if they are too long
(setq-default truncate-lines t)


;;; C-c as general purpose escape key sequence.
;;;
(defun my-esc (prompt)
  "Functionality for escaping generally.  Includes exiting Evil insert state and C-g binding. "
  (cond
   ((or (evil-insert-state-p) (evil-normal-state-p) (evil-replace-state-p) (evil-visual-state-p)) [escape])
   (t (kbd "C-g"))))
(define-key key-translation-map (kbd "C-c") 'my-esc)
(define-key evil-operator-state-map (kbd "C-c") 'keyboard-quit)
;(set-quit-char "C-c")
