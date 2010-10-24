(require 'color-theme)
(color-theme-initialize)
(color-theme-comidia)


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-24hr-format t)
 '(display-time-day-and-date t)
 '(display-time-mode t)
 '(global-font-lock-mode t)
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(visible-bell t))
(fset 'yes-or-no-p 'y-or-n-p)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

(setq default-frame-alist
    '((top . 0) 
      (left . 0) 
      (width . 100) 
      (height . 60) 
      (menu-bar-lines . 10) 
      (tool-bar-lines . 0)))



;; ----------------------- Erlang Start ---------------------------------------

(setq load-path (cons  "/usr/local/lib/erlang/lib/tools-2.6.6.1/emacs" load-path))
(setq erlang-root-dir "/usr/local/lib/erlang")
(setq exec-path (cons "/usr/local/lib/erlang" exec-path))
(require 'erlang-start)


;; This is needed for Distel setup
(let ((distel-dir "/home/jason/.emacs.d/distel/elisp"))
  (unless (member distel-dir load-path)
    ;; Add distel-dir to the end of load-path
    (setq load-path (append load-path (list distel-dir)))))

(require 'distel)
(distel-setup)


(add-hook 'erlang-mode-hook
  (lambda ()
    ;; when starting an Erlang shell in Emacs, default in the node name
    (setq inferior-erlang-machine-options '("-sname" "emacs"))
    ;; add Erlang functions to an imenu menu
    (imenu-add-to-menubar "imenu")))
;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
  '(("\C-\M-i"   erl-complete)
    ("\M-?"      erl-complete)
    ("\M-."      erl-find-source-under-point)
    ("\M-,"      erl-find-source-unwind)
    ("\M-*"      erl-find-source-unwind)
    )
  "Additional keys to bind when in Erlang shell.")
(add-hook 'erlang-shell-mode-hook
   (lambda ()
     ;; add some Distel bindings to the Erlang shell
     (dolist (spec distel-shell-keys)
       (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

;; ----------------------- Erlang End -----------------------------------------


;; load slime:
(setq load-path (cons "/home/jason/clbuild/source/slime" load-path))
(setq load-path (cons "/home/jason/clbuild/source/slime/contrib" load-path))
(setq slime-backend "/home/jason/clbuild/.swank-loader.lisp")
(setq inhibit-splash-screen t)
(load "/home/jason/clbuild/source/slime/slime")
(setq inferior-lisp-program "/home/jason/clbuild/clbuild lisp")
(slime-setup '(slime-fancy slime-tramp slime-asdf))
(slime-require :swank-listener-hooks)
(slime)

