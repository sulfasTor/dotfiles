﻿;; Moises .emacs - Refactored with use-package

;; Minimal UI
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)

;; don't let Customize mess with my .emacs
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

;; Enable UTF-8
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(setq user-full-name "$NAME"
      user-mail-address "$EMAIl")

(add-hook 'dired-load-hook (function (lambda () (load "dired-x"))))

;; Initialize package management and use-package
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Emoji support
(add-hook 'after-init-hook #'global-emojify-mode)

;;Copy current line in next line
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))
(global-set-key (kbd "\C-cd") 'duplicate-line)


;;Function to clear the shell
(defun clear-screen ()
  (interactive)
  (erase-buffer)
  (comint-send-input))

(defun my-shell-hook ()
  (local-set-key "\C-cl" 'clear-screen))

(add-hook 'shell-mode-hook  'my-shell-hook)

;; Org-mode
(use-package org
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture))
  :config
  (setq org-log-done t))

;; Vertico - Minimalistic vertical completion UI
(use-package vertico
  :init
  (vertico-mode))

;; Consult - Enhancements for minibuffer and Vertico
(use-package consult
  :after vertico
  :bind (("C-s" . consult-line)
         ("M-y" . consult-yank-pop)
         ("C-x b" . consult-buffer)))

;; Marginalia - Annotations for minibuffer completions
(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

;; Embark - Actions on minibuffer completions
(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)))

;; Orderless - Flexible completion styles
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

;; LSP Mode
(use-package lsp-mode
  :hook ((prog-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp lsp-deferred
  :config
  (setq lsp-headerline-breadcrumb-enable nil
        lsp-enable-snippet t
        lsp-keymap-prefix "C-c l"))

;; LSP UI - Additional UI features for LSP
(use-package lsp-ui
  :commands lsp-ui-mode
  :after lsp-mode
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-position 'top
        lsp-ui-sideline-enable nil))

;; Flycheck - Syntax checking
(use-package flycheck
  :init (global-flycheck-mode))

;; Yasnippet - Snippet expansion
(use-package yasnippet
  :config
  (yas-global-mode 1))

;; Company - Completion framework
(use-package company
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection))
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 1))

;; Magit - Git integration
(use-package magit
  :bind (("C-x g" . magit-status)))

;; Ripgrep - Search tool
(use-package deadgrep
  :bind (("<f5>" . deadgrep)))

;; Imenu List
(use-package imenu-list
  :bind ("C-'" . imenu-list-smart-toggle))

;; Web-mode for HTML, PHP, JS
(use-package web-mode
  :mode ("\\.html\\'" "\\.php\\'" "\\.js\\'")
  :config
  (setq web-mode-enable-auto-indentation t))

;; Highlight Indentation
(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character))

;; Dired Enhancements
(use-package dired-rainbow
  :config
  (dired-rainbow-define html "#eb5286" ("css" "html" "js"))
  (dired-rainbow-define document "#9561e2" ("pdf" "doc" "docx")))

(use-package projectile
  :ensure t)

(use-package gruber-darker-mode
  :ensure t)

;; Sky Color Clock
(use-package sky-color-clock
  :config
  (sky-color-clock-initialize 35)
  (setq sky-color-clock-format "%H:%M")
  (push '(:eval (sky-color-clock)) (default-value 'mode-line-format)))

;; Transparent Frame Toggle
(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter nil 'alpha
                         (if (or (not alpha) (= (cadr alpha) 100))
                             '(85 . 50)
                           '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

;; Backup Configuration
(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 5)

;; Additional Programming Hooks
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'electric-pair-mode)
(add-hook 'python-mode-hook 'flycheck-mode)

;; Custom Keybindings
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "M-p") #'jump-to-next-same-indent)

;; Enable Auto-save for Org-mode buffers
(add-hook 'auto-save-hook 'org-save-all-org-buffers)

;; Removes *messages* from the buffer.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

;; Removes *Completions* from buffer after you've opened a file.
(add-hook 'minibuffer-exit-hook
	  '(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))))

;; No more typing the whole yes or no. Just y or n will do.
(fset 'yes-or-no-p 'y-or-n-p)

(put 'downcase-region 'disabled nil)

(put 'upcase-region 'disabled nil)

(put 'dired-find-alternate-file 'disabled nil)


(defun nuke-all-buffers ()
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))
(global-set-key (kbd "C-x K") 'nuke-all-buffers)

(put 'erase-buffer 'disabled nil)


(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(85 . 50) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)


;; autocompletion
(global-set-key (kbd "ESC ESC") 'dabbrev-expand)
(global-set-key (kbd "C-.") 'pop-global-mark)

;; Shorcuts
(global-set-key (kbd "C-<f5>") #'lsp-find-references)
(global-set-key (kbd "C-<f6>") #'lsp-find-implementation)
(global-set-key (kbd "<f7>") #'projectile-compile-project)
;; Ripgrep
(global-set-key (kbd "<f5>") #'deadgrep)
(global-set-key (kbd "<f6>") #'swiper)


(exec-path-from-shell-initialize)