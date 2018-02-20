; general
(global-set-key "\C-x\C-b" 'buffer-menu)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
;(global-set-key "\C-c\C-g" 'gist-buffer-confirm)
(global-set-key "\C-xg" 'magit-status)
(global-set-key "\M-i" 'insert-soft-tab)
(global-set-key "\M-z" 'user-zap-to-char)
(global-set-key "\C-xp" 'user-ido-find-project)
(global-set-key "\C-cp" 'user-ido-find-config)
(global-set-key "\C-cP" 'user-goto-config)
(global-set-key [C-return] 'user-duplicate-line)
(global-set-key "\C-x\C-g" 'github-ido-find-file)
(global-set-key "\C-R" 'replace-string)
(global-set-key (kbd "C-S-N") 'word-count)
(global-set-key (kbd "A-F") 'ack)

; todo
(global-set-key [M-return] 'user-todo-toggle)
(global-set-key "\C-xt" 'user-todo-quick-enter)
(global-set-key [M-down] 'user-todo-move-item-down)
(global-set-key [M-up] 'user-todo-move-item-up)

; vim emulation
(global-set-key [C-tab] 'other-window)
;; (global-set-key [M-up] 'user-inc-num-at-point)
;; (global-set-key [M-down] 'user-dec-num-at-point)
(global-set-key (kbd "C-*") 'isearch-forward-at-point)
(global-set-key [remap kill-word] 'user-kill-word)
(global-set-key (kbd "C-S-k") 'user-backward-kill-line)
(global-set-key [remap backward-kill-word] 'user-backward-kill-word)
(global-set-key [remap aquamacs-backward-kill-word] 'user-backward-kill-word)

;; no printing!
;; no changing meta key!!
(when (boundp 'osx-key-mode-map)
  ;; Option is my meta key.
  (define-key osx-key-mode-map (kbd "A-;")
    '(lambda () (interactive) (message "noop")))

  ;; What's paper?
  (define-key osx-key-mode-map (kbd "A-p")
    '(lambda () (interactive) (message "noop"))))

; no mailing!
(global-unset-key (kbd "C-x m"))
(global-unset-key "\C-z")

