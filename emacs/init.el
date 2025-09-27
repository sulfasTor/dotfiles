;; Moises .emacs

;; Initial settings
(setq package-enable-at-startup nil
      inhibit-startup-message   t
      frame-resize-pixelwise    t  ; fine resize
      package-native-compile    t ; native compile packages3
      mac-command-modifier 'meta)
(scroll-bar-mode -1)               ; disable scrollbar
(tool-bar-mode -1)                 ; disable toolbar
(tooltip-mode -1)                  ; disable tooltips
(set-fringe-mode 10)               ; give some breathing room
(menu-bar-mode -1)
(blink-cursor-mode 0)

(defun my/disable-scroll-and-menu-bar (frame)
  (with-selected-frame frame
    (scroll-bar-mode -1)
    (tool-bar-mode -1)
    (tooltip-mode -1)
    (set-fringe-mode 10)
    (menu-bar-mode -1)
    (blink-cursor-mode 0)))

(add-hook 'after-make-frame-functions 'my/disable-scroll-and-menu-bar)


;; don't let Customize mess with my .emacs
(setq custom-file (concat user-emacs-directory "custom.el"))
(add-hook 'elpaca-after-init-hook (lambda () (load custom-file 'noerror)))

;; Keep it clean
(defun my-enable-trailing-whitespace ()
  (when (and (derived-mode-p 'prog-mode 'text-mode)
             (not buffer-read-only))
    (setq show-trailing-whitespace t)))

(add-hook 'prog-mode-hook 'my-enable-trailing-whitespace)
(add-hook 'text-mode-hook 'my-enable-trailing-whitespace)

(add-hook 'before-save-hook #'whitespace-cleanup)
(setq-default sentence-end-double-space nil)

(global-subword-mode 1)

(setq user-full-name       "Moises Torres Aguilar"
      user-login-name      "sulfastor"
      user-mail-address    "torresmoisesa@gmail.com")

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(let ((battery-str (battery)))
  (unless (or (equal "Battery Qstatus not available" battery-str)
              (string-match-p (regexp-quote "N/A") battery-str))
    (display-battery-mode 1)))

;; Package definitions

(defvar elpaca-installer-version 0.11)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1 :inherit ignore
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil)) (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
  ;; Enable :elpaca use-package keyword.
  (elpaca-use-package-mode)
  ;; Assume :elpaca t unless otherwise specified.
  (setq elpaca-use-package-by-default t))
;; Block until current queue processed.
(elpaca-wait)



(add-hook 'dired-load-hook (function (lambda () (load "dired-x"))))

;; Emoji support

(use-package no-littering
  :config
  (require 'no-littering)
  (require 'recentf)
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-var-directory))
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-etc-directory)))

;; (use-package emojify
;;   :hook (after-init . global-emojify-mode))

(use-package which-key)

;; org
(require 'org)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(setq org-log-done t)


(require 'org-agenda)
;; This is the expanded view of my code (which is further below):
(setq org-agenda-custom-commands
      `(("A" "Daily agenda and top priority tasks"
         ((tags-todo "*"
                     ((org-agenda-skip-function '(org-agenda-skip-if nil '(timestamp)))
                      (org-agenda-skip-function
                       `(org-agenda-skip-entry-if
                         'notregexp ,(format "\\[#%s\\]" (char-to-string org-priority-highest))))
                      (org-agenda-block-separator nil)
                      (org-agenda-overriding-header "Important tasks without a date\n")))
          (agenda "" ((org-agenda-span 1)
                      (org-deadline-warning-days 0)
                      (org-agenda-block-separator nil)
                      (org-scheduled-past-days 0)
                      ;; We don't need the `org-agenda-date-today'
                      ;; highlight because that only has a practical
                      ;; utility in multi-day views.
                      (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                      (org-agenda-format-date "%A %-e %B %Y")
                      (org-agenda-overriding-header "\nToday's agenda\n")))
          (agenda "" ((org-agenda-start-on-weekday nil)
                      (org-agenda-start-day "+1d")
                      (org-agenda-span 3)
                      (org-deadline-warning-days 0)
                      (org-agenda-block-separator nil)
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "\nNext three days\n")))
          (agenda "" ((org-agenda-time-grid nil)
                      (org-agenda-start-on-weekday nil)
                      ;; We don't want to replicate the previous section's
                      ;; three days, so we start counting from the day after.
                      (org-agenda-start-day "+4d")
                      (org-agenda-span 14)
                      (org-agenda-show-all-dates nil)
                      (org-deadline-warning-days 0)
                      (org-agenda-block-separator nil)
                      (org-agenda-entry-types '(:deadline))
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "\nUpcoming deadlines (+14d)\n")))))))

(org-clock-persistence-insinuate)

(use-package orderless
  :defer t
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package elegant-agenda-mode
  :elpaca (:host github :repo "justinbarclay/elegant-agenda-mode")
  :hook org-agenda-mode-hook)

(setq org-id-link-to-org-use-id t)
(add-hook 'org-after-todo-state-change-hook 'org-id-get-create)


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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; This makes "M-x compile" smarter by trying to guess what the compilation
;;;; command should be for the C, C++, and Java language modes.
;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; By requiring `compile' at this point, we help to ensure that the global
;; value of compile-command is set properly.  If `compile' is autoloaded when
;; the current buffer has a buffer-local copy of compile-command, then the
;; global value doesn't get set properly.

(require 'compile)

;; This gives the form of the default compilation command for C++, C, and

(defvar compile-guess-command-table
  '((c-mode       . "gcc  -Wall %s -o %s"); Doesn't work for ".h" files.
    (c++-mode     . "g++ -Wall %s -o %s -lm")	; Doesn't work for ".h" files.
    (java-mode . "javac %s")
    (python-mode . "python %s")
    (go-mode . "go build %s")
    )
  "*Association list of major modes to compilation command descriptions, used
by the function `compile-guess-command'.  For each major mode, the compilation
command may be described by either:

  + A string, which is used as a format string.  The format string must accept
    two arguments: the simple (non-directory) name of the file to be compiled,
    and the name of the program to be produced.

  + A function.  In this case, the function is called with the two arguments
    described above and must return the compilation command.")


;; This code guesses the right compilation command when Emacs is asked
;; to compile the contents of a buffer.  It bases this guess upon the
;; filename extension of the file in the buffer.

(defun compile-guess-command ()

  (let ((command-for-mode (cdr (assq major-mode
                                     compile-guess-command-table))))
    (if (and command-for-mode
             (stringp buffer-file-name))
        (let* ((file-name (file-name-nondirectory buffer-file-name))
               (file-name-sans-suffix (if (and (string-match "\\.[^.]*\\'"
                                                             file-name)
                                               (> (match-beginning 0) 0))
                                          (substring file-name
                                                     0 (match-beginning 0))
                                        nil)))
          (if file-name-sans-suffix
              (progn
                (make-local-variable 'compile-command)
                (setq compile-command
                      (if (stringp command-for-mode)
                          ;; Optimize the common case.
                          (format command-for-mode
                                  file-name file-name-sans-suffix)
                        (funcall command-for-mode
                                 file-name file-name-sans-suffix)))
                compile-command)
            nil))
      nil)))


;; Add the appropriate mode hooks.

(add-hook 'c-mode-hook       (function compile-guess-command))
(add-hook 'c++-mode-hook     (function compile-guess-command))
(add-hook 'java-mode-hook (function compile-guess-command))
(add-hook 'python-mode-hook (function compile-guess-command))

(use-package go-mode
  :config
  (add-hook 'go-mode-hook (function compile-guess-command)))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(defun nuke-all-buffers ()
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))
(global-set-key (kbd "C-x K") 'nuke-all-buffers)
(put 'erase-buffer 'disabled nil)

;;custom for buffers open

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;; Ask before killing `emacs --daemon`.
(global-set-key (kbd "C-x C-c")
                (function
                 (lambda () (interactive)
                   (cond ((y-or-n-p "Quit? ")
                          (save-buffers-kill-terminal))))))

;; autocompletion
(global-set-key (kbd "ESC ESC") 'dabbrev-expand)
(global-set-key (kbd "C-.") 'pop-global-mark)

;; yasnippet
(use-package yasnippet
  :config
  (yas-global-mode t))

(use-package yasnippet-snippets)

;; Typescript
(use-package typescript-mode
  :config
  (add-hook 'typescript-mode-hook #'lsp-deferred))

;; ;; Web dev
(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.php[345]?\\'\\|\\.inc\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
  ;; Web mode snippets
  (setq web-mode-extra-snippets
        '("html" (("script" "<script src="""" type=""text/javascript""></script>")
                  (("stylesheet" "<link rel=""stylesheet"" type=""text/css"" href="""">"))
                  (("div" "<div class="""" id=""""></div>")))
          )))

(setq c-default-style "gnu"
      c-basic-offset 2)

;; backup files move elsewhere
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

(use-package highlight-indentation
  :config
  (add-hook 'prog-mode-hook 'highlight-indentation-mode))

;; Plantuml
(use-package plantuml-mode)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t))) ; this line activates dot

(defun my-org-confirm-babel-evaluate (lang body)
  (not (member lang '("plantuml"))))

(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

;; Kill buffer without confirmation unless it had been modified
(global-set-key [(control x) (k)] 'kill-current-buffer)

;; company mode
(use-package company
  :init (global-company-mode)
  :config
  (setq company-dabbrev-downcase 0)
  (setq company-idle-delay 0))

;; The first variable is used to skip the downcase that company does to the variables I autocomplete, the second one I think you already have.

(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas-minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))

(global-set-key [backtab] 'tab-indent-or-complete)

;; SSH things
(use-package exec-path-from-shell
  :init (exec-path-from-shell-initialize)
  :config
  (exec-path-from-shell-copy-env "SSH_AGENT_PID")
  (exec-path-from-shell-copy-env "SSH_AUTH_SOCK"))

(use-package transient)

;; Magit
(use-package magit
  :hook (after-save . magit-after-save-refresh-status))

;; forge
(use-package forge
  :after magit)

(defun mu-magit-kill-buffers ()
  "Restore window configuration and kill all Magit buffers."
  (interactive)
  (let ((buffers (magit-mode-get-buffers)))
    (magit-restore-window-configuration)
    (mapc #'kill-buffer buffers)))

(setq frame-title-format
      (list '(buffer-file-name "%f" "%b")
            '(:eval (format " - GNU Emacs %s" emacs-version))))

;; ;; elpy
;; (use-package elpy
;;   :init (elpy-enable))

(use-package lsp-pyright
  :config
  (setq lsp-pyright-langserver-command "basedpyright")
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))

;; Ripgrep
(use-package ripgrep
  :if (executable-find "rg")
  :defer t)

(use-package deadgrep
  :bind (("<f5>" . deadgrep)))

(use-package helm
  :bind (("<f6>" . helm-occur)))

;; vertico
(use-package vertico
  :init (vertico-mode))

;; consult
(use-package consult
  :bind (("M-y" . consult-yank-pop)
         ("C-x b" . consult-buffer)
         ("C-x r b" . consult-bookmark)
         ("C-x p b" . consult-project-buffer)))

;; embark
(use-package embark
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings`
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command))

;; embark-consult
(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; marginalia
(use-package marginalia
  :init
  (marginalia-mode))

;; projectile
(use-package projectile
  :diminish projectile-mode
  :custom ((projectile-completition-system 'vertico))
  :init
  (setq projectile-switch-project-action #'projectile-dired)
  :config
  (projectile-mode)
  :bind (("<f7>" . projectile-compile-project)))

;; Imenu minor mode
(use-package imenu-list
  :config
  :bind ("C-'" . imenu-list-smart-toggle))

(put 'dired-find-alternate-file 'disabled nil)

;; multiple cursors

(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . 'mc/edit-lines)
         ("C->" .'mc/mark-next-like-this)
         ("C-<" . 'mc/mark-previous-like-this)
         ("C-c C-<" . 'mc/mark-all-like-this)
         ("C-\"" . 'mc/skip-to-next-like-this)
         ("C-:" . 'mc/skip-to-previous-like-this)))

;; ibuffer
(setq ibuffer-saved-filter-groups
      '(("default"
         ("Magit" (mode . magit-mode))
         ("Processes" (or (mode . comint-mode)
                          (mode . compilation-mode)))
         ("Org" (mode . org-mode))
         ("Go" (mode . go-mode))
         ("Python" (mode . python-mode))
         ("Rust" (mode . rust-mode))
         ("Dired" (mode . dired-mode))
         ("Emacs" (or (name . "^\\*scratch\\*$")
                      (name . "^\\*Messages\\*$")))
         ("Help" (or (name . "^\\*Help\\*$")
                     (name . "^\\*Apropos\\*$")
                     (name . "^\\*info\\*$"))))))

;; Rust
(use-package rust-playground)
(use-package flycheck-rust)
(use-package rustic
  :config
  (add-hook 'rustic-mode-hook #'flycheck-mode))

;; Go
(use-package go-playground)

(use-package gitignore-templates)

(use-package gherkin-mode)

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; rainbow-delimiters
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

;; jenkinsfile mode
(use-package groovy-mode
  :after rainbow-delimiters
  :config
  (add-hook 'groovy-mode-hook
            'rainbow-delimiters-mode)
  (add-hook 'groovy-mode-hook
            'aggressive-indent-mode))

;; org auto save
(add-hook 'auto-save-hook 'org-save-all-org-buffers)

(require 'desktop)
;; (setq desktop-restore-forces-onscreen nil)

(if (not (daemonp))
    (desktop-save-mode 1)
  (defun restore-desktop (frame)
    "Restores desktop and cancels hook after first frame opens.
     So the daemon can run at startup and it'll still work"
    (with-selected-frame frame
      (desktop-save-mode 1)
      (desktop-read)
      (remove-hook 'after-make-frame-functions 'restore-desktop)))
  (add-hook 'after-make-frame-functions 'restore-desktop))

;;; LSP
(use-package lsp-mode)

(use-package lsp-ui
  :after lsp-mode)

(use-package terraform-mode
  :config
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(lsp-register-custom-settings
 '(("gopls.completeUnimported" t t)
   ("gopls.semanticTokens" t t)
   ("gopls.staticcheck" t t)))

;; GO IDE
(add-hook 'go-mode-hook #'lsp-deferred)
(add-hook 'go-mode-hook
          'rainbow-delimiters-mode)
(add-hook 'go-mode-hook
          'electric-pair-local-mode)
(add-hook 'terraform-mode-hook
          'electric-pair-local-mode)

(use-package go-imports)

(use-package go-dlv)
(use-package dap-mode)

(use-package dape
  :config
  ;; Pulse source line (performance hit)
  (add-hook 'dape-display-source-hook 'pulse-momentary-highlight-one-line)

  ;; To not display info and/or buffers on startup
  ;; (remove-hook 'dape-start-hook 'dape-info)
  (remove-hook 'dape-start-hook 'dape-repl))

(use-package go-snippets)

;; YAML IDE
(use-package json-mode)
(use-package yaml-mode
  :config
  (add-hook 'yaml-mode-hook #'lsp-deferred)
  (add-hook 'yaml-mode-hook
            'highlight-indentation-mode))

;; JAVA
(use-package lsp-java
  :config
  (add-hook 'java-mode-hook #'lsp-deferred)
  (add-hook 'java-mode-hook 'flycheck-mode))
(use-package scala-mode)
(use-package scala-repl)

;; Shorcuts
(global-set-key (kbd "C-<f5>") #'lsp-find-references)
(global-set-key (kbd "C-<f6>") #'lsp-find-implementation)

;; Dired Hacks

(use-package dired-rainbow
  :config
  (progn
    (dired-rainbow-define-chmod directory "#6cb2eb" "d.*")
    (dired-rainbow-define html "#eb5286" ("css" "less" "sass" "scss" "htm" "html" "jhtm" "mht" "eml" "mustache" "xhtml"))
    (dired-rainbow-define xml "#f2d024" ("xml" "xsd" "xsl" "xslt" "wsdl" "bib" "json" "msg" "pgn" "rss" "yaml" "yml" "rdata"))
    (dired-rainbow-define document "#9561e2" ("docm" "doc" "docx" "odb" "odt" "pdb" "pdf" "ps" "rtf" "djvu" "epub" "odp" "ppt" "pptx"))
    (dired-rainbow-define markdown "#ffed4a" ("org" "etx" "info" "markdown" "md" "mkd" "nfo" "pod" "rst" "tex" "textfile" "txt"))
    (dired-rainbow-define database "#6574cd" ("xlsx" "xls" "csv" "accdb" "db" "mdb" "sqlite" "nc"))
    (dired-rainbow-define media "#de751f" ("mp3" "mp4" "MP3" "MP4" "avi" "mpeg" "mpg" "flv" "ogg" "mov" "mid" "midi" "wav" "aiff" "flac"))
    (dired-rainbow-define image "#f66d9b" ("tiff" "tif" "cdr" "gif" "ico" "jpeg" "jpg" "png" "psd" "eps" "svg"))
    (dired-rainbow-define log "#c17d11" ("log"))
    (dired-rainbow-define shell "#f6993f" ("awk" "bash" "bat" "sed" "sh" "zsh" "vim"))
    (dired-rainbow-define interpreted "#38c172" ("py" "ipynb" "rb" "pl" "t" "msql" "mysql" "pgsql" "sql" "r" "clj" "cljs" "scala" "js"))
    (dired-rainbow-define compiled "#4dc0b5" ("asm" "cl" "lisp" "el" "c" "h" "c++" "h++" "hpp" "hxx" "m" "cc" "cs" "cp" "cpp" "go" "f" "for" "ftn" "f90" "f95" "f03" "f08" "s" "rs" "hi" "hs" "pyc" ".java"))
    (dired-rainbow-define executable "#8cc4ff" ("exe" "msi"))
    (dired-rainbow-define compressed "#51d88a" ("7z" "zip" "bz2" "tgz" "txz" "gz" "xz" "z" "Z" "jar" "war" "ear" "rar" "sar" "xpi" "apk" "xz" "tar"))
    (dired-rainbow-define packaged "#faad63" ("deb" "rpm" "apk" "jad" "jar" "cab" "pak" "pk3" "vdf" "vpk" "bsp"))
    (dired-rainbow-define encrypted "#ffed4a" ("gpg" "pgp" "asc" "bfe" "enc" "signature" "sig" "p12" "pem"))
    (dired-rainbow-define fonts "#6cb2eb" ("afm" "fon" "fnt" "pfb" "pfm" "ttf" "otf"))
    (dired-rainbow-define partition "#e3342f" ("dmg" "iso" "bin" "nrg" "qcow" "toast" "vcd" "vmdk" "bak"))
    (dired-rainbow-define vc "#0074d9" ("git" "gitignore" "gitattributes" "gitmodules"))
    (dired-rainbow-define-chmod executable-unix "#38c172" "-.*x.*")
    ))

;; diff-hl
(use-package diff-hl
  :init
  (global-diff-hl-mode))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook #'org-summary-todo)

;; magit fix
(setq package-install-upgrade-built-in t)

;; Colorize compilation output
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

;; dap
(use-package dap-mode)

;; Visual
(use-package nyan-mode
  :init
  (nyan-mode))

(use-package ef-themes)
;;(use-package gruber-darker-theme)

;; Sky color clock
(use-package sky-color-clock
  :elpaca
  '(:host github :repo "zk-phi/sky-color-clock")
  :config
  (sky-color-clock-initialize 23)
  (setq sky-color-clock-format "%H:%M")
  (push '(:eval (sky-color-clock)) (default-value 'mode-line-format)))

;; Cucumber
(use-package feature-mode)

;; Restclient
(use-package restclient)
(use-package restclient-jq)

;; org-jira
(use-package org-jira
  :defer t)

(use-package org-present)
(use-package org-alert)

(use-package swiper
  :bind (("C-s" . swiper)  ;; Replace isearch with swiper
         ("C-r" . swiper))) ;; Replace reverse isearch with swiper

(use-package git-link)
(use-package dockerfile-mode)
(use-package smartparens
  :config
  (add-hook 'prog-mode-hook 'smartparens-mode))

(use-package shr-tag-pre-highlight
  :ensure t
  :after shr
  :config
  (add-to-list 'shr-external-rendering-functions
               '(pre . shr-tag-pre-highlight))
  (when (version< emacs-version "26")
    (with-eval-after-load 'eww
      (advice-add 'eww-display-html :around
                  'eww-display-html--override-shr-external-rendering-functions))))

(use-package transpose-frame)
(use-package httpcode)
(use-package dired-auto-readme)
(use-package impostman)
(use-package splunk-mode)
(use-package mexican-holidays)
(use-package darkroom)

;;;;; SCRIPTS
(defun clocktable-by-tag/shift-cell (n)
  (let ((str ""))
    (dotimes (i n)
      (setq str (concat str "| ")))
    str))

(defun clocktable-by-tag/insert-tag (params)
  (let ((tag (plist-get params :tags)))
    (insert "|--\n")
    (insert (format "| %s | *Tag time* |\n" tag))
    (let ((total 0))
      (mapcar
       (lambda (file)
         (let ((clock-data (with-current-buffer (find-file-noselect file)
                             (org-clock-get-table-data (buffer-name) params))))
           (when (> (nth 1 clock-data) 0)
             (setq total (+ total (nth 1 clock-data)))
             (insert (format "| | File *%s* | %.2f |\n"
                             (file-name-nondirectory file)
                             (/ (nth 1 clock-data) 60.0)))
             (dolist (entry (nth 2 clock-data))
               (insert (format "| | . %s%s | %s %.2f |\n"
                               (org-clocktable-indent-string (nth 0 entry))
                               (nth 1 entry)
                               (clocktable-by-tag/shift-cell (nth 0 entry))
                               (/ (nth 3 entry) 60.0)))))))
       (org-agenda-files))
      (save-excursion
        (re-search-backward "*Tag time*")
        (org-table-next-field)
        (org-table-blank-field)
        (insert (format "*%.2f*" (/ total 60.0)))))
    (org-table-align)))

(defun org-dblock-write:clocktable-by-tag (params)
  (insert "| Tag | Headline | Time (h) |\n")
  (insert "|     |          | <r>  |\n")
  (let ((tags (plist-get params :tags)))
    (mapcar (lambda (tag)
              (setq params (plist-put params :tags tag))
              (clocktable-by-tag/insert-tag params))
            tags)))


(require 'projectile)
(defun projectile-compile-other-frame ()
  "Compile project with custom behavior."
  (interactive)
  (let ((compile-command (read-string "Compile command: " (projectile-compilation-command (projectile-compilation-dir)))))
    (projectile-with-default-dir (projectile-project-root)
                                 (let ((compilation-buffer-name-function
                                        (lambda (mode) (projectile-generate-process-name "compilation" t))))
                                   (let ((compilation-buffer (get-buffer-create (funcall compilation-buffer-name-function "compilation"))))
                                     (with-selected-frame (make-frame)
                                       (projectile-run-compilation compile-command)))))))

(global-set-key (kbd "C-<f7>") 'projectile-compile-other-frame)

(defun open-agenda-fullscreen ()
  "Open Org Agenda in another frame, make it fullscreen, and execute command 'A' if another monitor is detected."
  (interactive)
  (when (> (length (display-monitor-attributes-list)) 1)
    (let ((new-frame (make-frame '((fullscreen . fullboth)))))
      (select-frame-set-input-focus new-frame)
      (org-agenda nil "A")
      (delete-other-windows))))

(global-set-key (kbd "<f2> a") 'open-agenda-fullscreen)

(make-variable-buffer-local 'my-compilation-start-time)

(add-hook 'compilation-start-hook #'my-compilation-start-hook)
(defun my-compilation-start-hook (proc)
  (setq my-compilation-start-time (current-time)))

(add-hook 'compilation-finish-functions #'my-compilation-finish-function)
(defun my-compilation-finish-function (buf why)
  (let* ((elapsed  (time-subtract nil my-compilation-start-time))
         (msg (format "Elapsed: %s" (format-time-string "%T.%N" elapsed t))))
    (save-excursion (goto-char (point-max)) (insert msg))
    (message "Compilation %s: %s" (string-trim-right why) msg)))

;; load env
(use-package load-env-vars)
(defun @-set-project-env ()
  "Export all environment variables in the closest .env file."

  (let ((env-file (@-find-env-file)))
    (when env-file
      (load-env-vars env-file)))
  )

(defun @-set-env-vars-hooks ()
  (use-package load-env-vars)
  (add-hook 'projectile-mode-hook #'@-set-project-env)
  (add-hook 'projectile-after-switch-project-hook #'@-set-project-env)
  (add-hook 'comint-exec-hook #'@-set-project-env)
  (add-hook 'lsp-mode-hook #'@-set-project-env)
  (add-hook 'vterm-mode-hook #'@-set-project-env)
  )


(defun org-agenda-note ()
  "Create a new note for the current Org agenda task and link it in the task title."
  (interactive)
  (unless (derived-mode-p 'org-agenda-mode)
    (user-error "This command must be run from an Org agenda buffer"))

  (let* ((marker (or (org-get-at-bol 'org-hd-marker)
                     (org-get-at-bol 'org-marker)))
         (task-buffer (marker-buffer marker))
         (task-pos (marker-position marker))
         (task-title (with-current-buffer task-buffer
                       (goto-char task-pos)
                       (org-get-heading t t)))
         (filename (concat (replace-regexp-in-string "[^a-zA-Z0-9_-]" "_" task-title) ".org"))
         (note-path (read-file-name "Path to create note: " (expand-file-name filename "~/Documents/notes/Banktech")))
         (note-link (format "[[file:%s][%s]]" note-path task-title)))

    (unless task-title
      (user-error "No task found at point"))

    ;; Create a new note file
    (with-current-buffer (find-file-noselect note-path)
      (insert "#+setupfile: ~/.emacs.d/org-templates/simple_inline/simple_inline.theme\n"
              "#+options: h:1 num:2 toc:nil broken-links:t html-postamble:nil ^:nil timestamp:nil\n"
              "#+TITLE: " task-title "\n"
              "#+DATE: " (format-time-string "[%Y-%m-%d %a]") "\n"
              "* Task: " task-title "\n"
              "** Context\n\n"
              "** Implementation\n\n"
              "** Testing\n\n"
              "** Caveats\n\n")
      (save-buffer))

    ;; Update the task title in Org Agenda to be a link
    (with-current-buffer task-buffer
      (goto-char task-pos)
      (beginning-of-line)
      (when (re-search-forward (regexp-quote task-title) (line-end-position) t)
        (replace-match note-link t t))
      (save-buffer))

    ;; Open the note
    (find-file note-path)
    (org-agenda-redo)))

(define-key org-agenda-mode-map (kbd "C-c n") 'org-agenda-note)

;;; Agentic AI try out
(use-package claude-code-ide
  :elpaca (:host github :repo "manzaltu/claude-code-ide.el")
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools

(use-package notmuch)

;; From https://www.reddit.com/r/emacs/comments/a3rajh/chrome_bookmarks_sync_to_org/
(defvar chrome-bookmarks-file
  (cl-find-if
   #'file-exists-p
   ;; Base on `helm-chrome-file'
   (list
    "~/Library/Application Support/Google/Chrome/Profile 1/Bookmarks"
    "~/Library/Application Support/Google/Chrome/Default/Bookmarks"
    "~/AppData/Local/Google/Chrome/User Data/Default/Bookmarks"
    "~/.config/google-chrome/Default/Bookmarks"
    "~/.config/chromium/Default/Bookmarks"
    (substitute-in-file-name
     "$LOCALAPPDATA/Google/Chrome/User Data/Default/Bookmarks")
    (substitute-in-file-name
     "$USERPROFILE/Local Settings/Application Data/Google/Chrome/User Data/Default/Bookmarks")))
  "Path to Google Chrome Bookmarks file (it's JSON).")

(defun chrome-bookmarks-insert-as-org ()
  "Insert Chrome Bookmarks as org-mode headings."
  (interactive)
  (require 'json)
  (require 'org)
  (let ((data (let ((json-object-type 'alist)
                    (json-array-type  'list)
                    (json-key-type    'symbol)
                    (json-false       nil)
                    (json-null        nil))
                (json-read-file chrome-bookmarks-file)))
        level)
    (cl-labels ((fn
                  (al)
                  (pcase (alist-get 'type al)
                    ("folder"
                     (insert
                      (format "%s %s\n"
                              (make-string level ?*)
                              (alist-get 'name al)))
                     (cl-incf level)
                     (mapc #'fn (alist-get 'children al))
                     (cl-decf level))
                    ("url"
                     (insert
                      (format "%s LINK %s\n"
                              (make-string level ?*)
                              (org-make-link-string
                               (alist-get 'url al)
                               (alist-get 'name al))))))))
      (setq level 1)
      (fn (alist-get 'bookmark_bar (alist-get 'roots data)))
      (setq level 1)
      (fn (alist-get 'other (alist-get 'roots data))))))

;; LLM
(use-package gptel
  :config
  (gptel-make-ollama "Ollama"
    :host "localhost:11434"
    :stream t
    :models '(codegemma:7b-instruct phi3:mini))
  (setf (alist-get 'org-mode gptel-prompt-prefix-alist) "@user\n")
  (setf (alist-get 'org-mode gptel-response-prefix-alist) "@assistant\n"))

(setenv "OLlama_NUM_GPU" "1")
(setenv "OLlama_KV_CACHE" "fp16")
(setenv "OLlama_NUM_PARALLEL" "1")
(setenv "OLlama_MAX_LOADED_MODELS" "1")


(use-package consult-gh)


(defun my-notmuch-show-view-as-patch ()
  "View the the current message as a patch."
  (interactive)
  (let* ((id (notmuch-show-get-message-id))
         (msg (notmuch-show-get-message-properties))
         (part (notmuch-show-get-part-properties))
         (subject (concat "Subject: " (notmuch-show-get-subject) "\n"))
         (diff-default-read-only t)
         (buf (get-buffer-create (concat "*notmuch-patch-" id "*")))
         (map (make-sparse-keymap)))
    (define-key map "q" 'notmuch-bury-or-kill-this-buffer)
    (switch-to-buffer buf)
    (let ((inhibit-read-only t))
      (erase-buffer)
      (insert subject)
      (insert (notmuch-get-bodypart-text msg part nil)))
    (set-buffer-modified-p nil)
    (diff-mode)
    (lexical-let ((new-ro-bind (cons 'buffer-read-only map)))
                 (add-to-list 'minor-mode-overriding-map-alist new-ro-bind))
    (goto-char (point-min))))
>>>>>>> main

(use-package notmuch
  :config
  (setq notmuch-saved-searches
        '((:name "Inbox"   :query "tag:inbox AND NOT tag:list" :key "i")
          (:name "Unread"  :query "tag:unread AND NOT tag:list" :key "u")
          (:name "Lists"   :query "tag:list" :key "l")
          (:name "Git ML"  :query "tag:git" :key "g")
          (:name "Flagged" :query "tag:flagged" :key "f")
          (:name "Finance" :query "tag:Bank/Finance" :key "b")
          (:name "Sent"    :query "tag:sent" :key "s")
          (:name "All Mail" :query "*" :key "a"))))

(define-key 'notmuch-show-part-map "d" 'my-notmuch-show-view-as-patch)
(use-package notmuch-maildir)




;;;; LAST
(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame (load-theme 'gruber-darker t))))
  (load-theme 'gruber-darker t))