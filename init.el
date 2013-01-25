(custom-set-variables
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(menu-bar-mode t)
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
;; melpa
(add-to-list 'package-archives
	     '("melpa" .
	       "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; Window management / undo stuff
;; C-c right/left
(winner-mode)

;; WindMove
;; move with C-c C-arrow keys
(global-set-key (kbd "C-c <C-left>")  'windmove-left)
(global-set-key (kbd "C-c <C-right>") 'windmove-right)
(global-set-key (kbd "C-c <C-up>")    'windmove-up)
(global-set-key (kbd "C-c <C-down>")  'windmove-down)

;; Cut and Paste
;; C-c C-v
(cua-mode)

;; server
(load "server")
(unless (server-running-p) (server-start))

;; undo-tree
(require 'undo-tree)
(global-undo-tree-mode)

;; Magit key binding
(global-set-key (kbd "C-c C-g") 'magit-status)
(global-set-key (kbd "C-c C-b") 'magit-blame-mode)

;; rgrep key binding
(global-set-key (kbd "C-c C-f") 'rgrep)

;; IDO
(require 'ido)

(global-set-key "\M-x"
		(lambda ()
		  (interactive)
		  (call-interactively
		   (intern
		    (ido-completing-read "M-x "
					 (all-completions "" obarray 'commandp))))))

;; ace jump mode
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; expand region
(require 'expand-region)
(global-set-key (kbd "C-'") 'er/expand-region)

;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; color-theme
(require 'color-theme)
(require 'color-theme-sanityinc-solarized)
(color-theme-sanityinc-solarized-light)
;;(color-theme-sanityinc-solarized-dark)
(require 'color-theme-zenburn)
;;(color-theme-zenburn)

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
(setq ac-auto-show-menu t)
(setq ac-dwim t)
(setq ac-use-menu-map t)
(setq ac-quick-help-delay 1)
(setq ac-quick-help-height 60)

;; ac-nrepl
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))
(define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)

;; paredit
(require 'paredit)
(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'scheme-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'enable-paredit-mode)

;; hl-sexp
(require 'hl-sexp)
(add-hook 'clojure-mode-hook 'hl-sexp-mode)
(add-hook 'lisp-mode-hook 'hl-sexp-mode)
(add-hook 'scheme-mode-hook 'hl-sexp-mode)
(add-hook 'emacs-lisp-mode-hook 'hl-sexp-mode)

;; idle-highlight-mode
(require 'idle-highlight-mode)
(add-hook 'clojure-mode-hook 'idle-highlight-mode)
(add-hook 'lisp-mode-hook 'idle-highlight-mode)
(add-hook 'scheme-mode-hook 'idle-highlight-mode)
(add-hook 'emacs-lisp-mode-hook 'idle-highlight-mode)

;; show-paren-mode
(show-paren-mode)

;; xcscope
(require 'xcscope)
(setq cscope-do-not-update-database t)

;; semantc
(semantic-mode)

;; Scheme; gambit / chicken / petite
;;(setq scheme-program-name "gsi -:s,d-")
(setq scheme-program-name "csi")
;;(setq scheme-program-name "petite")

(setq nrepl-history-file "~/.emacs.d/nrepl-history")

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

(eval-after-load 'clojure-mode
  '(font-lock-add-keywords
    'clojure-mode `(("\\(#\\)_"
		     (0 (progn (compose-region (match-beginning 1)
					       (match-end 1) "#")
			       nil))))))

(setq auto-mode-alist (cons '("\\.cljs$" . clojure-mode) auto-mode-alist))

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name "places" user-emacs-directory))

;; ------------------------
;; stuff

;; frame title
(setq frame-title-format "%b")

;; Auto revert
(global-auto-revert-mode t)

;; scrolling
(setq scroll-step 1)

;; truncate lines
(set-default 'truncate-lines t)

;; remove trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

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

;; ERC
(setq erc-hide-list '("JOIN" "PART" "QUIT"))

;; XML pretty print
(defun pretty-print-xml-region (begin end)
  (interactive "r")
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    (while (search-forward-regexp "\>[ \\t]*\<" nil t)
      (backward-char) (insert "\n"))
    (indent-region begin end))
  (message "Ah, much better!"))
