(custom-set-variables
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(inhibit-startup-message t)
 '(ido-enable-flex-matching t)
 '(ido-mode (quote both) nil (ido)))

;; ------------------------

;; < emacs24

;; (load-file "~/.emacs.d/package.el")

;; marmelade
(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;; color-theme
(require 'color-theme)
(require 'color-theme-sanityinc-solarized)
(load-file "~/.emacs.d/elpa/color-theme-twilight-0.1/color-theme-twilight.el")
(load-file "~/.emacs.d/elpa/color-theme-github-0.0.3/color-theme-github.el")
;;(color-theme-twilight)
;;(color-theme-github)
(color-theme-sanityinc-solarized-light)
;;(color-theme-sanityinc-solarized-dark)

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
(setq ac-auto-show-menu t)
(setq ac-dwim t)
(setq ac-use-menu-map t)
(setq ac-quick-help-delay 1)
(setq ac-quick-help-height 60)

;; ac-slime
(require 'ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

;; slime repl
(defun setup-slime-repl-paredit ()
  (define-key slime-repl-mode-map
    (kbd "DEL") 'paredit-backward-delete)
  (define-key slime-repl-mode-map
    (kbd "{") 'paredit-open-curly)
  (define-key slime-repl-mode-map
    (kbd "}") 'paredit-close-curly)
  (modify-syntax-entry ?\{ "(}")
  (modify-syntax-entry ?\} "){")
  (modify-syntax-entry ?\[ "(]")
  (modify-syntax-entry ?\] ")[")
  (modify-syntax-entry ?~ "'   ")
  (modify-syntax-entry ?, "    ")
  (modify-syntax-entry ?^ "'")
  (modify-syntax-entry ?= "'"))
(add-hook 'slime-repl-mode-hook 'setup-slime-repl-paredit)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)

;; paredit
(require 'paredit)
(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

;; hl-sexp
(require 'hl-sexp)
(global-hl-sexp-mode)

;;show-paren-mode
(show-paren-mode)

;; clojure
(require 'clojure-mode)
(eval-after-load "clojure-mode"
  '(progn
     (defun clojure-paredit-hook () (paredit-mode +1))
     (add-hook 'clojure-mode-hook 'clojure-paredit-hook)
     (defun clojure-indent-hook () 
       (define-clojure-indent (clone-for 1) (at 1)))
     (add-hook 'clojure-mode-hook 'clojure-indent-hook)
     (define-key clojure-mode-map "{" 'paredit-open-curly)
     (define-key clojure-mode-map "}" 'paredit-close-curly)))
(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("(\\(fn\\)[\[[:space:]]"
                     (0 (progn (compose-region (match-beginning 1)
                                               (match-end 1) "λ")
                               nil))))))
(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\)("
		     (0 (progn (compose-region (match-beginning 1)
					       (match-end 1) "ƒ")
			       nil))))))
(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\){"
		     (0 (progn (compose-region (match-beginning 1)
					       (match-end 1) "∈")
			       nil))))))
;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode)

;; IDO
(require 'ido)

;; ------------------------
;; stuff

;; scrolling
(setq scroll-step 1)

;; truncate lines
(set-default 'truncate-lines t)

;; spaces instead of tabs
(setq indent-tabs-mode nil)
(setq tab-width 3)
(setq python-indent 3)
(setq c-basic-offset 3)
(setq c-indent-level 3)
(setq c++-tab-always-indent nil)

;; show time
(setq display-time-24hr-format t)
(setq display-time-load-average t)
(display-time)

;; match parens
(setq blink-matching-paren-distance nil)
