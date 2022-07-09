;; Moises .emacs

(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)

;; don't let Customize mess with my .emacs
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

;;(toggle-frame-maximized)
;;(toggle-frame-fullscreen)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
(package-initialize)

(setq user-full-name "$NAME"
      user-mail-address "$EMAIL")

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(add-hook 'dired-load-hook (function (lambda () (load "dired-x"))))

;; org
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
(setq org-log-done t)

;; beamer

(require 'ox-beamer)
(require 'ox-latex)
(setq org-export-allow-bind-keywords t)
;; (setq org-latex-listings 'minted)
;; (add-to-list 'org-latex-packages-alist '("" "minted"))
;; (setq org-latex-pdf-process
;;       '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

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

;;Startup things

;; (add-hook 'emacs-startup-hook
;; 	  (lambda ()
;; 	    (let ((w (split-window-below)))
;; 	      (select-window w)
;; 	      (shell))
;; 	    (switch-to-buffer "*shell*")))

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
(add-hook 'go-mode-hook (function compile-guess-command))

;;(global-linum-mode 1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(defun nuke-all-buffers ()
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))
(global-set-key (kbd "C-x K") 'nuke-all-buffers)
(put 'erase-buffer 'disabled nil)

;;(add-hook 'text-mode-hook 'turn-on-auto-fill)


;;custom for buffers open

;; Makes *scratch* empty.
;;(setq initial-scratch-message "")

;; Removes *scratch* from buffer after the mode has been set.
;;(defun remove-scratch-buffer ()
;;  (if (get-buffer "*scratch*")
;;      (kill-buffer "*scratch*")))
;;(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

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
			  (save-buffers-kill-emacs))))))

;; autocompletion
(global-set-key (kbd "ESC ESC") 'dabbrev-expand)
(global-set-key (kbd "C-.") 'pop-global-mark)

(yas-global-mode t) 

;; ;; Web dev
;; (require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php[345]?\\'\\|\\.inc\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))

;; (setq c-default-style "linux"
;;       c-basic-offset 4)

(setq c-default-style "gnu"
      c-basic-offset 2)

;; Sky color clock
(load "~/.emacs.d/sky-color-clock.el")
(require 'sky-color-clock)
(sky-color-clock-initialize 35)
(setq sky-color-clock-format "%H:%M")
(push '(:eval (sky-color-clock)) (default-value 'mode-line-format))


;; ;; org minted
;; (setq org-latex-listings 'minted
;;       org-latex-packages-alist '(("" "minted"))
;;       org-latex-pdf-process
;;       '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;; backup files move elsewhere
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;; Web mode snippets
(setq web-mode-extra-snippets
      '("html" (("script" "<script src="""" type=""text/javascript""></script>")
		   (("stylesheet" "<link rel=""stylesheet"" type=""text/css"" href="""">"))
		   (("div" "<div class="""" id=""""></div>")))
	))

;; Show indentation lines on python mode
;; (add-hook 'python-mode-hook
;; 	  'highlight-indent-guides-mode)

;; ;; Show indentation lines on python mode
;; (add-hook 'yaml-mode-hook
;; 	  'highlight-indent-guides-mode)

;; Plantuml
(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t))) ; this line activates dot

(defun my-org-confirm-babel-evaluate (lang body)
  (not (member lang '("plantuml"))))

(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)

;; Kill buffer without confirmation unless it had been modified
(global-set-key [(control x) (k)] 'kill-this-buffer)


; setup files ending in “.vs, .fs, .gs” to open in glsl-mode
(add-to-list 'auto-mode-alist '("\\.vs\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.fs\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.gs\\'" . glsl-mode))


;; irony mode
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))


;; I had also a bad experience with company at the beginning, but in my setup I just put these lines.

(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)

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
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)
(exec-path-from-shell-copy-env "SSH_AGENT_PID")
(exec-path-from-shell-copy-env "SSH_AUTH_SOCK")


;; Magit
(defun mu-magit-kill-buffers ()
  "Restore window configuration and kill all Magit buffers."
  (interactive)
  (let ((buffers (magit-mode-get-buffers)))
    (magit-restore-window-configuration)
    (mapc #'kill-buffer buffers)))

;;(bind-key "q" #'mu-magit-kill-buffers magit-status-mode-map)

(with-eval-after-load 'magit-mode
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))

(setq frame-title-format
      (list '(buffer-file-name "%f" "%b")
            '(:eval (format " - GNU Emacs %s" emacs-version))))

;;(org-agenda-list)
(elpy-enable)

;; Ripgrep
(global-set-key (kbd "<f5>") #'deadgrep)

;; Imenu minor mode
(global-set-key (kbd "C-'") #'imenu-list-smart-toggle)

;; org-protocol
;;(server-start)
(require 'org-protocol)

(defun occur-at-point ()
  "Run occur using the `word-at-point'."
  (interactive)
  (occur (thing-at-point 'word t)))
(global-set-key (kbd "<f6>") #'helm-occur)
(put 'dired-find-alternate-file 'disabled nil)

;; multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Jump next item same indentation
(defun jump-to-next-same-indent ()
  (interactive)
  (let ((start-indent (current-indentation)))
    (while
      (and (not (bobp))
           (zerop (forward-line 1))
           (> (current-indentation) start-indent))))
  (back-to-indentation))

(global-set-key [?\M-p] #'jump-to-next-same-indent)


;; jenkinsfile mode
(add-hook 'groovy-mode-hook
	  'rainbow-delimiters-mode)
(add-hook 'groovy-mode-hook
	  'aggressive-indent-mode)

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

;; elgantt
(add-to-list 'load-path (concat user-emacs-directory "lisp/elgantt/")) ;; Or wherever it is located
(require 'elgantt)

;; org auto save
(add-hook 'auto-save-hook 'org-save-all-org-buffers)


;; (defun help/magit-kill-buffers ()
;;   "Restore window configuration and kill all Magit buffers.
;; Attribution: URL `https://manuel-uberti.github.io/emacs/2018/02/17/magit-bury-buffer/'"
;;   (interactive)
;;   (let ((buffers (magit-mode-get-buffers)))
;;     (magit-restore-window-configuration)
;;     (mapc #'kill-buffer buffers)))
;; (bind-key "q" #'help/magit-kill-buffers magit-status-mode-map)
;; (bind-key "q" #'deadgrep-kill-all-buffers deadgrep-mode-map)

;;; LSP
(require 'lsp-mode)

;; Terraform IDE
;; (add-to-list 'lsp-language-id-configuration '(terraform-mode . "terraform"))

;; (lsp-register-client
;;  (make-lsp-client :new-connection (lsp-stdio-connection '("/usr/local/bin/terraform-lsp" "-enable-log-file"))
;;                   :major-modes '(terraform-mode)
;;                   :server-id 'terraform-ls))

;; (add-hook 'terraform-mode-hook #'lsp)
;; Format the current buffer with terraform-format-buffer. To always
;; format terraform buffers when saving, use:
(add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)

;; GO IDE
(add-hook 'go-mode-hook #'lsp-deferred)

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

;;(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook
	  'rainbow-delimiters-mode)
(add-hook 'go-mode-hook
	  'electric-pair-local-mode)
(add-hook 'terraform-mode-hook
	  'electric-pair-local-mode)

;; YAML IDE
(add-hook 'yaml-mode-hook #'lsp-deferred)
(add-hook 'yaml-mode-hook
	  'highlight-indent-guides-mode)

;; JAVA
(add-hook 'java-mode-hook #'lsp)
(add-hook 'java-mode-hook 'flycheck-mode)

;; Shorcuts
(global-set-key (kbd "C-<f5>") #'lsp-find-references)
(global-set-key (kbd "C-<f6>") #'lsp-find-implementation)
(global-set-key (kbd "<f7>") #'projectile-compile-project)


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


;; ;; smex
;; (global-set-key (kbd "M-x") 'smex)

(global-diff-hl-mode)

;; ################## WSL2 Workaround ###############
;; wsl-copy
(defun wsl-copy (start end)
  (interactive "r")
  (shell-command-on-region start end "clip.exe")
  (deactivate-mark))

;; wsl-paste
(defun wsl-paste ()
  (interactive)
  (let ((clipboard
         (shell-command-to-string "powershell.exe -WindowStyle Hidden -command 'Get-Clipboard' 2> /dev/null")))
    (setq clipboard (replace-regexp-in-string "\r" "" clipboard)) ; Remove Windows ^M characters
    (setq clipboard (substring clipboard 0 -1)) ; Remove newline added by Powershell
    (insert clipboard)))


;; Bind wsl-copy to C-c C-v
(global-set-key
 (kbd "C-c C-c")
 'wsl-copy)

;; Bind wsl-paste to C-c C-v
(global-set-key
 (kbd "C-c C-v")
 'wsl-paste)

;; vertico mode
;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

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

;; tree-sit
(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))

;; Colorize compilation output
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

;; dap
;; (require 'dap-dlv-go)