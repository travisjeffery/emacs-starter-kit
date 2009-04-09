;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;
;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

;; Load path etc:

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))
(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))

;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session:

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

;; Load up ELPA, the package manager:

(require 'package)
(package-initialize)
;;(require 'starter-kit-elpa)

;; Load up starter kit customizations:

(require 'starter-kit-defuns)
(require 'starter-kit-bindings)
(require 'starter-kit-misc)
(require 'starter-kit-registers)
(require 'starter-kit-eshell)
(require 'starter-kit-lisp)
(require 'starter-kit-ruby)
(require 'starter-kit-js)

(regen-autoloads)
(load custom-file 'noerror)

;; You can keep system- or user-specific customizations here:

(setq system-specific-config (concat dotfiles-dir system-name ".el")
      user-specific-config (concat dotfiles-dir user-login-name ".el"))

(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-config) (load user-specific-config))

;; Begin Travis customizations

(setq vendor-dir (concat dotfiles-dir "vendor/"))

(require 'topfunky)

;;use safari
(setq browse-url-browser-function 'browse-url-safari)
 (defun browse-url-safari (url &optional new-window)
  "Open URL in a new Safari window."
  (interactive (browse-url-interactive-arg "URL: "))
  (unless
      (string= ""
            (shell-command-to-string
             (concat "open -a Safari " url)))
    (message "Starting Safari...")
    (start-process (concat "open -a Safari " url) nil "open -a Safari " url)
    (message "Starting Safari... done")))
 (defun report-emacs-bug-externally-p () t)

(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;; to find all my apps
(setq exec-path (append exec-path '("/usr/local/bin") '("/opt/local/bin")))
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin" ":/opt/local/bin"))

;; sweet color theme
(eval-after-load "color-theme" '(color-theme-midnight))

(add-to-list 'load-path (concat vendor-dir "smex"))
(require 'smex)
(eval-after-load "init.el" '(smex-initialize))
(global-set-key (kbd "C-x C-m") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'smex-update-and-run)

;; need those line numbers
(require 'linum)
(global-linum-mode)

(add-to-list 'load-path (concat vendor-dir "egg/"))
(require 'egg)
(egg-minor-mode)

(add-to-list 'load-path (concat vendor-dir "django-html-mode/"))
(require 'django-html-mode)
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mode))

(require 'auto-install)
(setq auto-install-directory vendor-dir)

(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)

(add-to-list 'load-path (concat vendor-dir "emacs-nav/"))
(require 'nav)

(yas/load-directory (concat vendor-dir "snippets/"))
(yas/minor-mode-on)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(column-number-mode)
(setq user-mail-address "travisjeffery@gmail.com")
(setq user-full-name "Travis Jeffery")

(add-to-list 'insert-pair-alist '(?" ?"))
(global-set-key (kbd "\"") 'insert-pair)

(require 'http-post-simple)
(require 'tumbl)

;; End Travis customizations

(provide 'init)
;;; init.el ends here
