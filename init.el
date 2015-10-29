;; User pack init file
;;
;; Use this file to initiate the pack configuration.
;; See README for more information.

;; Load bindings config
(live-load-config-file "bindings.el")

(set-frame-height (selected-frame) 90)
(set-frame-width (selected-frame) 350)
(set-frame-position (selected-frame) 10 35)
(set-default 'truncate-lines t)  ;; turn off word-wrap
(setq truncate-partial-width-windows nil)  ;; turn off word-wrap in vertical split windows
(setq split-height-threshold 1200)  ;; do not automatically split vertically
(setq split-width-threshold 2000)   ;; do not automatically split horizontally

(require 'dirtree)
(live-add-pack-lib "scss-mode")
(require 'scss-mode)
(live-add-pack-lib "web-mode")
(require 'web-mode)

(setq css-indent-offset 2)

(add-hook 'python-mode-hook 'electric-pair-mode)

(defun stop-using-minibuffer ()
  "kill the minibuffer"
  (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
    (abort-recursive-edit)))
(add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)
