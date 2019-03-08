;; User pack init file
;;
;; Use this file to initiate the pack configuration.
;; See README for more information.

;; Load bindings config
(live-load-config-file "bindings.el")

;;(set-frame-height (selected-frame) 90)
;;(set-frame-width (selected-frame) 350)
;;(set-frame-position (selected-frame) 10 35)
(set-default 'truncate-lines t)  ;; turn off word-wrap
(setq truncate-partial-width-windows nil)  ;; turn off word-wrap in vertical split windows
(setq split-height-threshold 1200)  ;; do not automatically split vertically
(setq split-width-threshold 2000)   ;; do not automatically split horizontally

;;(require 'dirtree)
(live-add-pack-lib "scss-mode")
(require 'scss-mode)
(live-add-pack-lib "web-mode")
(require 'web-mode)
(live-add-pack-lib "coffee-mode")
(require 'coffee-mode)
;; (live-add-pack-lib "use-package")
;; (require 'use-package)
(live-add-pack-lib "x-copypaste")
(require 'x-copypaste)

;; (require 'package)
;; (add-to-list
;;  'package-archives
;;  '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
;;  ;; '("melpa" . "http://melpa.milkbox.net/packages/")
;;  t)

;; (when (not package-archive-contents)
;;   (package-refresh-contents))

;; (use-package treemacs
;;   :ensure t
;;   :defer t
;;   :init
;;   (with-eval-after-load 'winum
;;     (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
;;   :config
;;   (progn
;;     (setq treemacs-collapse-dirs              (if (executable-find "python") 3 0)
;;           treemacs-deferred-git-apply-delay   0.5
;;           treemacs-display-in-side-window     t
;;           treemacs-file-event-delay           5000
;;           treemacs-file-follow-delay          0.2
;;           treemacs-follow-after-init          t
;;           treemacs-follow-recenter-distance   0.1
;;           treemacs-goto-tag-strategy          'refetch-index
;;           treemacs-indentation                2
;;           treemacs-indentation-string         " "
;;           treemacs-is-never-other-window      nil
;;           treemacs-no-png-images              nil
;;           treemacs-project-follow-cleanup     nil
;;           treemacs-persist-file               (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
;;           treemacs-recenter-after-file-follow nil
;;           treemacs-recenter-after-tag-follow  nil
;;           treemacs-show-hidden-files          t
;;           treemacs-silent-filewatch           nil
;;           treemacs-silent-refresh             nil
;;           treemacs-sorting                    'alphabetic-desc
;;           treemacs-space-between-root-nodes   t
;;           treemacs-tag-follow-cleanup         t
;;           treemacs-tag-follow-delay           1.5
;;           treemacs-width                      35)

;;     ;; The default width and height of the icons is 22 pixels. If you are
;;     ;; using a Hi-DPI display, uncomment this to double the icon size.
;;     ;;(treemacs-resize-icons 44)

;;     (treemacs-follow-mode t)
;;     (treemacs-filewatch-mode t)
;;     (treemacs-fringe-indicator-mode t)
;;     (pcase (cons (not (null (executable-find "git")))
;;                  (not (null (executable-find "python3"))))
;;       (`(t . t)
;;        (treemacs-git-mode 'extended))
;;       (`(t . _)
;;        (treemacs-git-mode 'simple))))
;;   :bind
;;   (:map global-map
;;         ("M-0"       . treemacs-select-window)
;;         ("C-x t 1"   . treemacs-delete-other-windows)
;;         ("C-x t t"   . treemacs)
;;         ("C-x t B"   . treemacs-bookmark)
;;         ("C-x t C-t" . treemacs-find-file)
;;         ("C-x t M-t" . treemacs-find-tag)))

;; (use-package treemacs-projectile
;;   :after treemacs projectile
;;   :ensure t)

(live-add-pack-lib "neotree")
(require 'neotree)
(setq neo-window-width 50)
(setq neo-autorefresh nil)
(setq neo-show-hidden-files t)

(setq scss-compile-at-save false)
(setq css-indent-offset 2)
(setq js-indent-level 2)
(add-hook 'js2-mode-hook (lambda () (setq js2-basic-offset 2)))
(add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))
(global-set-key (kbd  "C-]") 'enlarge-window-horizontally)
;;(global-set-key (kbd  "C-[") 'shrink-window-horizontally)

(add-hook 'python-mode-hook 'electric-pair-mode)
(add-hook 'python-mode-hook 'paredit-mode)
;; prevent paredit from adding a space before opening paren in certain modes
(defun mode-space-delimiter-p (endp delimiter)
  "Don't insert a space before delimiters in certain modes"
  (or
   (bound-and-true-p python-mode)
   (bound-and-true-p js2-mode)
   (bound-and-true-p js-mode)
   (bound-and-true-p javascript-mode)))
(add-to-list 'paredit-space-for-delimiter-predicates #'mode-space-delimiter-p)
;; disable C-z that sends emacs to the background
(global-unset-key (kbd "C-z"))

;; next 2 lines to make windows split horizontally by default
(setq split-height-threshold nil)
(setq split-width-threshold 0)

(load-file (concat (live-pack-lib-dir) "monochromatic-green.el"))
(color-theme-monochromatic-green)
(add-hook 'find-file-hook 'color-theme-monochromatic-green)

(setq live-disable-zone t)

(when (eq system-type 'darwin)
  ;; terminal clipboard while inside tmux
  (unless (display-graphic-p)
    (when (and (> (length (getenv "TMUX")) 0) (executable-find "reattach-to-user-namespace"))

    (defun paste-from-osx ()
      (shell-command-to-string "reattach-to-user-namespace pbpaste") )

    (defun cut-to-osx (text &optional push)
      (let ((process-connection-type nil))
        (let ((proc (start-process "pbcopy" "*Messages*" "reattach-to-user-namespace" "pbcopy") ))
          (process-send-string proc text)
          (process-send-eof proc))))

      (setq interprogram-cut-function 'cut-to-osx)
      (setq interprogram-paste-function 'paste-from-osx)
      )
    )
  )

;; use alt key for meta on mac
;;(setq mac-option-modifier 'alt)

;; handle tmux's xterm-keys
;; put the following line in your ~/.tmux.conf:
;;   setw -g xterm-keys on
(if (getenv "TMUX")
    (progn
      (let ((x 2) (tkey ""))
	(while (<= x 8)
	  ;; shift
	  (if (= x 2)
	      (setq tkey "S-"))
	  ;; alt
	  (if (= x 3)
	      (setq tkey "M-"))
	  ;; alt + shift
	  (if (= x 4)
	      (setq tkey "M-S-"))
	  ;; ctrl
	  (if (= x 5)
	      (setq tkey "C-"))
	  ;; ctrl + shift
	  (if (= x 6)
	      (setq tkey "C-S-"))
	  ;; ctrl + alt
	  (if (= x 7)
	      (setq tkey "C-M-"))
	  ;; ctrl + alt + shift
	  (if (= x 8)
	      (setq tkey "C-M-S-"))

	  ;; arrows
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d A" x)) (kbd (format "%s<up>" tkey)))
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d B" x)) (kbd (format "%s<down>" tkey)))
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d C" x)) (kbd (format "%s<right>" tkey)))
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d D" x)) (kbd (format "%s<left>" tkey)))
	  ;; home
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d H" x)) (kbd (format "%s<home>" tkey)))
	  ;; end
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d F" x)) (kbd (format "%s<end>" tkey)))
	  ;; page up
	  (define-key key-translation-map (kbd (format "M-[ 5 ; %d ~" x)) (kbd (format "%s<prior>" tkey)))
	  ;; page down
	  (define-key key-translation-map (kbd (format "M-[ 6 ; %d ~" x)) (kbd (format "%s<next>" tkey)))
	  ;; insert
	  (define-key key-translation-map (kbd (format "M-[ 2 ; %d ~" x)) (kbd (format "%s<delete>" tkey)))
	  ;; delete
	  (define-key key-translation-map (kbd (format "M-[ 3 ; %d ~" x)) (kbd (format "%s<delete>" tkey)))
	  ;; f1
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d P" x)) (kbd (format "%s<f1>" tkey)))
	  ;; f2
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d Q" x)) (kbd (format "%s<f2>" tkey)))
	  ;; f3
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d R" x)) (kbd (format "%s<f3>" tkey)))
	  ;; f4
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d S" x)) (kbd (format "%s<f4>" tkey)))
	  ;; f5
	  (define-key key-translation-map (kbd (format "M-[ 15 ; %d ~" x)) (kbd (format "%s<f5>" tkey)))
	  ;; f6
	  (define-key key-translation-map (kbd (format "M-[ 17 ; %d ~" x)) (kbd (format "%s<f6>" tkey)))
	  ;; f7
	  (define-key key-translation-map (kbd (format "M-[ 18 ; %d ~" x)) (kbd (format "%s<f7>" tkey)))
	  ;; f8
	  (define-key key-translation-map (kbd (format "M-[ 19 ; %d ~" x)) (kbd (format "%s<f8>" tkey)))
	  ;; f9
	  (define-key key-translation-map (kbd (format "M-[ 20 ; %d ~" x)) (kbd (format "%s<f9>" tkey)))
	  ;; f10
	  (define-key key-translation-map (kbd (format "M-[ 21 ; %d ~" x)) (kbd (format "%s<f10>" tkey)))
	  ;; f11
	  (define-key key-translation-map (kbd (format "M-[ 23 ; %d ~" x)) (kbd (format "%s<f11>" tkey)))
	  ;; f12
	  (define-key key-translation-map (kbd (format "M-[ 24 ; %d ~" x)) (kbd (format "%s<f12>" tkey)))
	  ;; f13
	  (define-key key-translation-map (kbd (format "M-[ 25 ; %d ~" x)) (kbd (format "%s<f13>" tkey)))
	  ;; f14
	  (define-key key-translation-map (kbd (format "M-[ 26 ; %d ~" x)) (kbd (format "%s<f14>" tkey)))
	  ;; f15
	  (define-key key-translation-map (kbd (format "M-[ 28 ; %d ~" x)) (kbd (format "%s<f15>" tkey)))
	  ;; f16
	  (define-key key-translation-map (kbd (format "M-[ 29 ; %d ~" x)) (kbd (format "%s<f16>" tkey)))
	  ;; f17
	  (define-key key-translation-map (kbd (format "M-[ 31 ; %d ~" x)) (kbd (format "%s<f17>" tkey)))
	  ;; f18
	  (define-key key-translation-map (kbd (format "M-[ 32 ; %d ~" x)) (kbd (format "%s<f18>" tkey)))
	  ;; f19
	  (define-key key-translation-map (kbd (format "M-[ 33 ; %d ~" x)) (kbd (format "%s<f19>" tkey)))
	  ;; f20
	  (define-key key-translation-map (kbd (format "M-[ 34 ; %d ~" x)) (kbd (format "%s<f20>" tkey)))

	  (setq x (+ x 1))
	  ))
      )
  )

(setq live-ascii-art-logo "")
