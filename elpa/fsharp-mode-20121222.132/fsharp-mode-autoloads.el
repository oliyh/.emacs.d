;;; fsharp-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (fsharp-mode) "fsharp-mode" "fsharp-mode.el" (20730
;;;;;;  54525))
;;; Generated autoloads from fsharp-mode.el

(add-to-list 'auto-mode-alist '("\\.fs[iylx]?$" . fsharp-mode))

(autoload 'fsharp-mode "fsharp-mode" "\
Major mode for editing fsharp code.

\\{fsharp-mode-map}

\(fn)" t nil)

;;;***

;;;### (autoloads (run-fsharp) "inf-fsharp-mode" "inf-fsharp-mode.el"
;;;;;;  (20730 54525))
;;; Generated autoloads from inf-fsharp-mode.el

(autoload 'run-fsharp "inf-fsharp-mode" "\
Run an inferior fsharp process.
Input and output via buffer `*inferior-fsharp*'.

\(fn &optional CMD)" t nil)

;;;***

;;;### (autoloads nil nil ("fsharp-mode-font.el" "fsharp-mode-indent.el"
;;;;;;  "fsharp-mode-pkg.el") (20730 54525 279361))

;;;***

(provide 'fsharp-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; fsharp-mode-autoloads.el ends here
