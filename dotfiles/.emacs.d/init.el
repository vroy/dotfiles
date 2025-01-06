;; Add melpa.org to package sources
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install packages by default in use-package
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Load $PATH from [fish] shell when in Emacs.app
(use-package exec-path-from-shell
  :config
  (setq exec-path-from-shell-shell-name "/opt/homebrew/bin/fish")
  (exec-path-from-shell-initialize)
  )

;; refresh melpa local refs
;; (package-refresh-contents)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Packages
(use-package zoom-window
  :config
  (setq zoom-window-mode-line-color "#889FB0")
  (global-set-key (kbd "<s-S-return>") 'zoom-window-zoom))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ido

(require 'ido)
(ido-mode 1)
(ido-everywhere 1)

;; limit height of vertical selection
(setq ido-max-prospects 10)

;; disable looking into other dirs (explicit on projectile cmd+p instead)
(setq ido-auto-merge-work-directories-length -1)

;; Turn off pinging / find file at point:
;; https://github.com/technomancy/emacs-starter-kit/issues/39
;; (setq ido-use-filename-at-point nil)

(use-package ido-vertical-mode
  :config
  (ido-vertical-mode 1)
  ;; ctrl+n ctrl+p for vertical buffer selection
  (setq ido-vertical-define-keys 'C-n-and-C-p-only))

;; better fuzzy finder
(use-package flx-ido
  :config
  (setq ido-enable-flex-matching t)
  (flx-ido-mode 1)
  ;; disable ido faces to see flx highlights
  (setq ido-use-faces nil))

(use-package projectile
  :config
  (global-set-key (kbd "s-p") 'projectile-find-file)
  (global-set-key (kbd "s-t") 'projectile-switch-project)
  (global-set-key (kbd "s-f") 'projectile-ag))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Modes and Languages
(use-package go-mode
  :config
  ;; fmt on save
  (setq gofmt-command "/opt/homebrew/bin/gofumpt")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'before-save-hook 'lsp-organize-imports))

(unbind-key "C-q")
(use-package lsp-mode
  :config
  (define-key lsp-mode-map (kbd "C-q") lsp-command-map)
  ;; disable inline `Run` | `Debug` buttions
  (setq lsp-lens-enable nil)
  ;; disable hierarchy header line
  (setq lsp-headerline-breadcrumb-enable nil)
  ;; skip prompt when there are lot's of files in project
  (setq lsp-file-watch-threshold nil)

  ;; hook to enable lsp in go-mode
  (add-hook 'go-mode-hook #'lsp)

  (setq lsp-go-build-flags ["-tags=integration"])

  ;; hook to enable lsp in python-mode
  ;;(add-hook 'python-mode-hook #'lsp)

  ;; hook to enable lsp in typescript-mode
  (add-hook 'typescript-mode-hook #'lsp)

  ;; go install github.com/bufbuild/buf-language-server/cmd/bufls@latest
  ;; new lang is pretty new
  ;; https://github.com/emacs-lsp/lsp-mode/pull/4239
  ;; (add-hook 'protobuf-mode-hook #'lsp)

  (global-set-key (kbd "C-q SPC") 'pop-global-mark)
  (global-set-key (kbd "C-q C-SPC") 'pop-global-mark)
  (global-set-key (kbd "C-q C-f") 'lsp-find-definition)
  (global-set-key (kbd "C-q f") 'lsp-find-definition)
  (global-set-key (kbd "C-q C-r") 'lsp-find-references)
  (global-set-key (kbd "C-q r") 'lsp-find-references)
  (global-set-key (kbd "C-q C-i") 'lsp-find-implementation)
  (global-set-key (kbd "C-q i") 'lsp-find-implementation)

  )

(use-package markdown-mode
  :mode ("\\*scratch\\*\\'" . markdown-mode)
  :init
  (setq markdown-header-scaling t)
  (setq markdown-command "/Users/vincent.roy/.asdf/shims/marked")
  )

(use-package terraform-mode
  :config
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)
  )

(use-package protobuf-mode)
(use-package dockerfile-mode)
(use-package yaml-mode)
(use-package git-modes)

(use-package blacken
  :config
  (add-hook 'python-mode-hook 'blacken-mode)
  )

(use-package typescript-mode
  :config
  (setq typescript-indent-level 2)
  )

(setq javascript-indent-level 2)

(use-package lua-mode
  :config
  (setq lua-indent-level 3)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Theme
(use-package zenburn-theme
  :config
  (load-theme 'zenburn t))

;; Set default font size to 16pt.
(set-face-attribute 'default (selected-frame) :height 160)

;; highlight the current line
(global-hl-line-mode +1)

;; Disable blinking cursor...
(blink-cursor-mode -1)

;; no toolbar/scrollbar in GUI mode
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;; Smaller fringe (left and right side gutters)
(if (fboundp 'fringe-mode)
    (fringe-mode 4))

;; disable word wrap
(auto-fill-mode -1)
(remove-hook 'text-mode-hook #'turn-on-auto-fill)
(turn-off-auto-fill)

;; mode line settings
(line-number-mode t)
(column-number-mode t)

;; Custom mode line colors that helps show which buffer is active
(set-face-attribute 'mode-line nil
                    :foreground "#2e3330" :background "#88b090"
                    :box '(:color "#88b090" :line-width 4))

(set-face-attribute 'mode-line-inactive nil
                    :foreground "#acbc90" :background "#1e2320"
                    :box '(:color "#1e2320" :line-width 2))

(set-face-attribute 'mode-line-buffer-id nil
                    :foreground "#8c5353")

;; https://emacs.stackexchange.com/a/37270
(defun simple-mode-line-render (left right)
  "Return a string of `window-width' length.
Containing LEFT, and RIGHT aligned respectively."
  (let ((available-width
         (- (window-width)
            (+ (length (format-mode-line left))
               (length (format-mode-line right))))))
    (append left
            (list (format (format "%%%ds" available-width) ""))
            right)))

;; Custom mode line
(setq-default mode-line-format
              '((:eval
                 (simple-mode-line-render
                  ;; left
                  (list
                   " "
                   "%* %b"
                   "  "
                   "[%l,%c]")
                  ;; right
                  (list
	                 "[" (vroy-mode-line--mode-name) (vroy-mode-line--minor-modes) "]"
                   "  "
                   (vroy-mode-line--git-status)
                   " ")))))

;; no startup msg
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; Turn off bell completely.
(setq ring-bell-function 'ignore)

;; Disable default tab mode.
(setq-default indent-tabs-mode nil)

;; Set default tab width
(setq-default tab-width 2)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; meaningful names for buffers with the same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; Strip trailing whitespace before saving files.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode t)

;; Move auto-saved files to a temp directory.
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Bindings

;; Default to commenting single line if no selection made already
(global-set-key (kbd "C-c C-k") 'vroy-comment-or-uncomment-region-or-line)
(define-key (current-global-map) (kbd "C-c C-k") 'vroy-comment-or-uncomment-region-or-line)

(global-set-key (kbd "C-x |") 'split-window-horizontally)
(global-set-key (kbd "C-x -") 'split-window-vertically)

(global-set-key [(control return)] 'vroy-next-line)
(global-set-key (kbd "<s-return>") 'vroy-next-line)

(global-set-key (kbd "C-S-k") 'vroy-backward-kill-line)
(global-set-key (kbd "s-k") 'vroy-kill-whole-line)

(global-set-key (kbd "s-w") 'kill-this-buffer)
(global-set-key (kbd "s-s") 'save-buffer)

(global-set-key [(control tab)] 'other-window)
(global-set-key [(control shift tab)] 'previous-multiframe-window)
(global-set-key [(meta tab)] 'other-window)

(global-set-key (kbd "s-[") 'previous-multiframe-window)
(global-set-key (kbd "s-]") 'other-window)

;; C-x C-r => prelude style file rename
(global-set-key (kbd "C-x C-r") 'vroy-rename-file-and-buffer)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Copilot
;; https://robert.kra.hn/posts/2023-02-22-copilot-emacs-setup/
;; https://github.com/copilot-emacs/copilot.el
;; https://github.com/editorconfig/editorconfig-emacs
;; (use-package dash)
;; (use-package s)
;; (use-package editorconfig
;;  :config
;;  (editorconfig-mode 1))
;; (use-package f)

;; (add-to-list 'load-path "/Users/vincent.roy/.emacs.d/copilot.el")
;; (require 'copilot)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Functions
(defun vroy-next-line ()
  "Inserts an indented newline after the current line and moves the point to it."
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun vroy-backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

;; https://github.com/bbatsov/prelude/blob/b9000702b2ac8216a8bfeea645fde6bb0c1fc7bc/core/prelude-core.el#L126
(defun vroy-kill-whole-line (&optional arg)
  "A simple wrapper around command `kill-whole-line' that respects indentation.
Passes ARG to command `kill-whole-line' when provided."
  (interactive "p")
  (kill-whole-line arg)
  (back-to-indentation))

;; https://github.com/bbatsov/crux/blob/3998b753d0eb4fc5a64ed9c9f05a1427ff4be22d/crux.el#L412-L434
(defun vroy-rename-file-and-buffer ()
  "Rename current buffer and if the buffer is visiting a file, rename it too."
  (interactive)
  (when-let* ((filename (buffer-file-name))
              (new-name (or (read-file-name "New name: " (file-name-directory filename) nil 'confirm)))
              (containing-dir (file-name-directory new-name)))
    ;; make sure the current buffer is saved and backed by some file
    (when (or (buffer-modified-p) (not (file-exists-p filename)))
      (if (y-or-n-p "Can't move file before saving it.  Would you like to save it now?")
          (save-buffer)))
    (if (get-file-buffer new-name)
        (message "There already exists a buffer named %s" new-name)
      (progn
        (make-directory containing-dir t)
        (cond
         ((vc-backend filename)
          ;; vc-rename-file seems not able to cope with remote filenames?
          (let ((vc-filename (if (tramp-tramp-file-p filename) (tramp-file-local-name filename) filename))
                (vc-new-name (if (tramp-tramp-file-p new-name) (tramp-file-local-name filename) new-name)))
            (vc-rename-file vc-filename vc-new-name)))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))


;; git status is the name of the branch and changed status
(defun vroy-mode-line--git-status ()
  (if vc-mode
      (let* ((tstr (replace-regexp-in-string " Git" "" vc-mode))
             (vc-status (substring tstr 0 1))
             (branch (substring tstr 1)))
        (cond
         ((string= ":" vc-status) ;;; Modified
          (concat branch " *"))
         ((string= "-" vc-status) ;; No change
          (concat branch " -"))
         (t branch)
         ))
    "nogit"))

(defun vroy-comment-or-uncomment-region-or-line ()
  (interactive)
  (if mark-active
      (call-interactively 'comment-or-uncomment-region)
    (save-excursion
      (comment-or-uncomment-region (line-beginning-position) (line-end-position)))))

;; downcase and remove cruft from major mode name
(defun vroy-mode-line--mode-name ()
  (downcase
   (if (consp mode-name)
       (car mode-name)
     mode-name)))

;; custom minor modes rendering
(defun vroy-mode-line--minor-modes ()
  (if (bound-and-true-p lsp-mode)
      " (lsp)"
    ""
  ))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lua-mode editorconfig javascript-mode git-modes yaml-mode typescript-mode zoom-window zenburn-theme terraform-mode spaceline smart-mode-line-powerline-theme protobuf-mode projectile lsp-mode ido-vertical-mode ido-completing-read+ go-mode go-errcheck flx-ido exec-path-from-shell dockerfile-mode company blacken airline-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
