(when (load "flymake" t)
    (defun flymake-pyflakes-init ()
            (let* ((temp-file (flymake-init-create-temp-buffer-copy
                    'flymake-create-temp-inplace))
                (local-file (file-relative-name temp-file
                        (file-name-directory buffer-file-name))))
        (list "pyflakes"  (list local-file))))
    (add-to-list 'flymake-allowed-file-name-masks 
                 '("\\.py\\'" flymake-pyflakes-init)))


(add-to-list 'load-path "~/.emacs.d/vendor/flymake-python-pyflakes")

(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

