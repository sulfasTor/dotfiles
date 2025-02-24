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
;; (require 'package)
;; (setq package-archives '(("melpa" . "https://melpa.org/packages/")
;;                          ("gnu" . "https://elpa.gnu.org/packages/")))
;; (package-initialize)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

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
  (forward-line 1)
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

;;(use-package forge)

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

(use-package transpose-frame
  :ensure t)

;; ;; Sky Color Clock
;; (use-package sky-color-clock
;;   :config
;;   (sky-color-clock-initialize 35)
;;   (setq sky-color-clock-format "%H:%M")
;;   (push '(:eval (sky-color-clock)) (default-value 'mode-line-format)))

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
;;(global-set-key (kbd "M-p") #'jump-to-next-same-indent)

;; Enable Auto-save for Org-mode buffers
(add-hook 'auto-save-hook 'org-save-all-org-buffers)

(setq-default message-log-max nil)
(kill-buffer "*Messages*")

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
(require 'lsp)
(global-set-key (kbd "C-<f5>") #'lsp-find-references)
(global-set-key (kbd "C-<f6>") #'lsp-find-implementation)
(global-set-key (kbd "<f7>") #'projectile-compile-project)
;; Ripgrep
(global-set-key (kbd "<f5>") #'deadgrep)
(global-set-key (kbd "<f6>") #'swiper)

(defun org-agenda-note ()
  "Open or create a note for the current Org agenda task.
If a note already exists, open it immediately. Otherwise, prompt for a filename,
create the note, fill it with a template, and turn the task title into a clickable link."
  (interactive)
  (unless (org-agenda-check-type nil 'agenda)
    (user-error "This command must be run from an agenda view"))

  (let* ((marker (or (org-get-at-bol 'org-hd-marker)
                     (org-get-at-bol 'org-marker)))
         (task-buffer (when marker (marker-buffer marker)))
         (task-pos (when marker (marker-position marker)))
         (task-title (when task-buffer
                       (with-current-buffer task-buffer
                         (goto-char task-pos)
                         (org-get-heading t t))))
         (default-filename (concat (replace-regexp-in-string "[^a-zA-Z0-9_-]" "_" task-title) ".org"))
         (default-path (expand-file-name default-filename "~/Documents/notes/"))
         (existing-note (when task-buffer
                          (with-current-buffer task-buffer
                            (goto-char task-pos)
                            (when (re-search-forward "\\[\\[file:\\([^]]+\\)\\]\\[" nil t)
                              (match-string 1)))))
         (note-path (if existing-note
                        existing-note
                      (read-file-name "Note file: " "~/Documents/notes/" nil nil default-filename)))
         (note-link (format "[[file:%s][%s]]" note-path task-title)))

    (unless task-title
      (user-error "No task found at point"))

    ;; If the note already exists, open it immediately
    (if (file-exists-p note-path)
        (find-file note-path)
      ;; Otherwise, create the note with a template
      (with-current-buffer (find-file-noselect note-path)
        (insert "#+TITLE: " task-title "\n"
                "#+DATE: " (format-time-string "[%Y-%m-%d %a]") "\n"
                "* Task: " task-title "\n"
                "** Context\n\n"
                "** Implementation\n\n"
                "** Testing\n\n"
                "** Caveats\n\n")
        (save-buffer))

      ;; Turn the task title into a link to the note
      (with-current-buffer task-buffer
        (goto-char task-pos)
        (beginning-of-line)
        (re-search-forward (regexp-quote task-title) (line-end-position) t)
        (replace-match note-link t t)
        (save-buffer)))

    ;; Open the note
    (find-file note-path)
    (org-agenda-redo)))

;; Bind to "C-c n" inside org-agenda
(with-eval-after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "C-c n") 'org-agenda-note))



(defun assoc-pr-to-note ()
  "Associate the current Magit Forge PR or commit with an existing TODO note.
Prompts the user to select a note file and inserts a reference to the PR/commit."
  (interactive)
  (unless (derived-mode-p 'magit-mode)
    (user-error "This command must be run from Magit"))

  (let* ((pr-or-commit (or (forge-get-url (forge-current-topic))
                           (magit-commit-at-point)))
         (notes-dir "~/Documents/notes/")
         (note-file (read-file-name "Select note file: " notes-dir nil t)))

    (unless pr-or-commit
      (user-error "No PR or commit found at point"))

    ;; Insert reference into the chosen note
    (with-current-buffer (find-file-noselect note-file)
      (goto-char (point-max))
      (unless (re-search-backward "^\\*\\* References" nil t)
        (insert "\n** References\n"))
      (goto-char (point-max))
      (insert (format "- [[%s][PR/Commit]]\n" pr-or-commit))
      (save-buffer))

    (message "Associated %s with %s" pr-or-commit (file-name-nondirectory note-file))))



(exec-path-from-shell-initialize)
