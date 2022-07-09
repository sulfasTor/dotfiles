(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(auth-sources '("~/.authinfo"))
 '(auto-compile-on-save-mode t)
 '(column-number-mode t)
 '(company-dabbrev-downcase 0 t)
 '(company-idle-delay 0.6 t)
 '(company-minimum-prefix-length 2)
 '(company-tooltip-limit 7)
 '(compilation-auto-jump-to-first-error 'first-known)
 '(compilation-disable-input t)
 '(compilation-message-face 'default)
 '(compilation-scroll-output t)
 '(csv-separators '("," "\11"))
 '(cua-global-mark-cursor-color "#93E0E3")
 '(cua-normal-cursor-color "#DCDCCC")
 '(cua-overwrite-cursor-color "#F0DFAF")
 '(cua-read-only-cursor-color "#7F9F7F")
 '(cursor-type 'box)
 '(custom-enabled-themes '(ef-elea-dark))
 '(deadgrep-extra-arguments '("--no-config"))
 '(default-frame-alist '((top . 30) (left . 1) (width . 189) (height . 50)))
 '(delete-selection-mode t)
 '(desktop-save-mode t)
 '(diff-hl-global-modes '(not image-mode prog-mode))
 '(dired-dwim-target 'dired-dwim-target-next-visible)
 '(dired-listing-switches "-alh")
 '(display-battery-mode t)
 '(display-line-numbers-current-absolute t)
 '(display-line-numbers-grow-only t)
 '(display-line-numbers-type 'relative)
 '(display-line-numbers-widen t)
 '(display-line-numbers-width-start t)
 '(docker-command "docker")
 '(elfeed-feeds
   '("http://science.sciencemag.org/rss/current.xml" "http://rss.cnn.com/rss/edition.rss" "https://news.ycombinator.com/rss"
     ("https://news.ycombinator.com/rss" HN)) t)
 '(elgantt-header-type 'category)
 '(elpy-mode-hook
   '(highlight-indent-guides-mode diff-hl-mode smartparens-mode))
 '(elpy-modules
   '(elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-highlight-indentation elpy-module-yasnippet elpy-module-django elpy-module-sane-defaults))
 '(elpy-test-pytest-runner-command '("py.test" "--no-header" "--tb=native" "-s"))
 '(elpy-test-runner 'elpy-test-pytest-runner)
 '(ensime-sem-high-faces
   '((var :foreground "#9876aa" :underline
          (:style wave :color "yellow"))
     (val :foreground "#9876aa")
     (varField :slant italic)
     (valField :foreground "#9876aa" :slant italic)
     (functionCall :foreground "#a9b7c6")
     (implicitConversion :underline
                         (:color "#808080"))
     (implicitParams :underline
                     (:color "#808080"))
     (operator :foreground "#cc7832")
     (param :foreground "#a9b7c6")
     (class :foreground "#4e807d")
     (trait :foreground "#4e807d" :slant italic)
     (object :foreground "#6897bb" :slant italic)
     (package :foreground "#cc7832")
     (deprecated :strike-through "#a9b7c6")))
 '(exec-path-from-shell-variables
   '("PATH" "MANPATH" "GOPATH" "GOROOT" "HTTP_PROXY" "HTTPS_PROXY" "NO_PROXY"))
 '(explicit-shell-file-name "/bin/bash")
 '(fci-rule-color "#49483E")
 '(flycheck-flake8rc "setup.cfg")
 '(forge-buffer-draft-p t)
 '(forge-topic-list-limit '(20 . 0))
 '(frame-brackground-mode 'dark)
 '(gc-cons-threshold 100000000)
 '(global-auto-revert-mode t)
 '(go-command "go")
 '(grep-command "grep --color -n -Re \"\" .")
 '(helm-swoop-split-with-multiple-windows t)
 '(highlight-changes-colors '("#FD5FF0" "#AE81FF"))
 '(highlight-indent-guides-method 'column)
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    '("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2")))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   '(("#49483E" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#49483E" . 100)))
 '(hl-bg-colors
   '("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00"))
 '(hl-fg-colors
   '("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36"))
 '(hl-paren-colors '("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900"))
 '(hl-sexp-background-color "#1c1f26")
 '(ibuffer-default-sorting-mode 'recency)
 '(ibuffer-saved-filter-groups
   '(("perfspect"
      (""
       (filename . "perfspect"))
      (""
       (name . "perfspect")))
     ("lucene"
      ("lucene"
       (directory . "lucene")))))
 '(ibuffer-saved-filters
   '(("Jenkinsfile"
      (name . "Jenkinsfile"))
     ("Jenkinsfiles"
      (name . "Jenkinsfile"))
     ("programming"
      (or
       (derived-mode . prog-mode)
       (mode . ess-mode)
       (mode . compilation-mode)))
     ("text document"
      (and
       (derived-mode . text-mode)
       (not
        (starred-name))))
     ("TeX"
      (or
       (derived-mode . tex-mode)
       (mode . latex-mode)
       (mode . context-mode)
       (mode . ams-tex-mode)
       (mode . bibtex-mode)))
     ("web"
      (or
       (derived-mode . sgml-mode)
       (derived-mode . css-mode)
       (mode . javascript-mode)
       (mode . js2-mode)
       (mode . scss-mode)
       (derived-mode . haml-mode)
       (mode . sass-mode)))
     ("gnus"
      (or
       (mode . message-mode)
       (mode . mail-mode)
       (mode . gnus-group-mode)
       (mode . gnus-summary-mode)
       (mode . gnus-article-mode)))))
 '(image-use-external-converter nil)
 '(imenu-list-idle-update-delay 0.2)
 '(imenu-list-minor-mode nil)
 '(imenu-list-size 0.15)
 '(imenu-sort-function nil)
 '(indent-tabs-mode nil)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(initial-frame-alist '((top . 30) (left . 1) (width . 189) (height . 50)))
 '(isearch-allow-scroll t)
 '(logview-guess-lines 100)
 '(logview-max-promising-lines 2)
 '(lsp-enable-file-watchers nil)
 '(lsp-http-proxyStrictSSL t)
 '(lsp-idle-delay 1)
 '(lsp-log-io nil)
 '(lsp-response-timeout 40)
 '(lsp-semantic-tokens-enable t)
 '(lsp-server-trace "messages")
 '(lsp-terraform-ls-enable-show-reference t)
 '(lsp-terraform-ls-prefill-required-fields t)
 '(magit-diff-refine-hunk 'all)
 '(magit-diff-use-overlays nil)
 '(magit-git-executable "/usr/bin/git")
 '(magit-pull-or-fetch nil)
 '(message-log-max 1000)
 '(mode-require-final-newline nil)
 '(neo-click-changes-root t)
 '(neo-window-fixed-size nil)
 '(neo-window-width 14)
 '(nrepl-message-colors
   '("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4"))
 '(nyan-mode t)
 '(org-agenda-files
   '("~/organizer.org"))
 '(org-agenda-prefix-format
   '((agenda . " %i %-12:c%?-12t% s")
     (todo . " %i %-12:c")
     (tags . " %i %-12:c")
     (search . " %i %-12:c")))
 '(org-agenda-start-on-weekday nil)
 '(org-babel-load-languages '((plantuml . t) (emacs-lisp . t) (shell . t)))
 '(org-capture-templates
   '(("t" "todo" entry
      (file org-default-notes-file)
      "* TODO %?\12%U\12%a\12" :clock-in t :clock-resume t)
     ("r" "respond" entry
      (file org-default-notes-file)
      "* NEXT Respond to %:from on %:subject\12SCHEDULED: %t\12%U\12%a\12" :immediate-finish t :clock-in t :clock-resume t)
     ("n" "note" entry
      (file org-default-notes-file)
      "* %? :NOTE:\12%U\12%a\12" :clock-in t :clock-resume t)
     ("j" "Journal" entry
      (file+olp+datetree org-default-notes-file)
      "* %?\12%U\12" :clock-in t :clock-resume t)
     ("w" "org-protocol" entry
      (file org-default-notes-file)
      "* LINK %? [[%:link][%:description]] \\nCaptured On: %U" :immediate-finish t)
     ("m" "Meeting" entry
      (file org-default-notes-file)
      "* MEETING with %? :MEETING:\12%U" :clock-in t :clock-resume t)
     ("p" "Phone call" entry
      (file org-default-notes-file)
      "* PHONE %? :PHONE:\12%U" :clock-in t :clock-resume t)
     ("h" "Habit" entry
      (file org-default-notes-file)
      "* NEXT %?\12%U\12%a\12SCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\12:PROPERTIES:\12:STYLE: habit\12:REPEAT_TO_STATE: NEXT\12:END:\12")))
 '(org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
 '(org-deadline-warning-days 14)
 '(org-default-notes-file "~/organizer.org")
 '(org-emphasis-alist
   '(("*" bold)
     ("/" italic)
     ("_" underline)
     ("=" org-verbatim verbatim)
     ("~" org-code verbatim)
     ("+"
      (:strike-through t))
     ("!"
      (:foreground red))))
 '(org-export-backends '(ascii beamer html icalendar latex md odt confluence))
 '(org-file-apps
   '((auto-mode . emacs)
     (directory . emacs)
     ("\\.mm\\'" . default)
     ("\\.x?html?\\'" . "/mnt/c/Program Files/Mozilla Firefox/firefox.exe -new-tab %s")
     ("\\.pdf\\'" . default)))
 '(org-fontify-done-headline nil)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-todo-headline nil)
 '(org-html-htmlize-output-type 'inline-css)
 '(org-image-actual-width nil)
 '(org-jira-download-comments t)
 '(org-latex-logfiles-extensions
   '("aux" "bcf" "blg" "fdb_latexmk" "fls" "figlist" "idx" "log" "nav" "out" "ptc" "run.xml" "snm" "toc" "vrb" "xdv" "tex"))
 '(org-latex-pdf-process '("latexmk -shell-escape -bibtex -f -pdf %f"))
 '(org-latex-toc-command "\\tableofcontents \\clearpage\12\12")
 '(org-plantuml-args '("-headless -DRELATIVE_INCLUDE=\".\""))
 '(org-plantuml-exec-mode 'jar)
 '(org-plantuml-executable-args '("-headless -DRELATIVE_INCLUDE=\".\""))
 '(org-plantuml-jar-path "~/.emacs.d/plantuml.jar")
 '(org-provide-todo-statistics t)
 '(org-return-follows-link t)
 '(org-safe-remote-resources
   '("\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-bigblow\\.setup\\'" "\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))
 '(org-src-block-faces nil)
 '(org-src-fontify-natively t)
 '(org-src-lang-modes
   '(("C" . c)
     ("C++" . c++)
     ("asymptote" . asy)
     ("bash" . sh)
     ("beamer" . latex)
     ("calc" . fundamental)
     ("cpp" . c++)
     ("ditaa" . artist)
     ("dot" . fundamental)
     ("elisp" . emacs-lisp)
     ("ocaml" . tuareg)
     ("screen" . shell-script)
     ("shell" . sh)
     ("sqlite" . sql)
     ("plantuml" . plantuml)))
 '(org-structure-template-alist
   '(("a" . "export ascii\12")
     ("c" . "center\12")
     ("C" . "comment\12")
     ("e" . "example\12")
     ("E" . "export")
     ("h" . "export html\12")
     ("l" . "export latex\12")
     ("q" . "quote\12")
     ("s" . "src")
     ("v" . "verse\12")))
 '(org-todo-keyword-faces
   '(("TODO" :foreground "red" :weight bold)
     ("NEXT" :foreground "blue" :weight bold)
     ("DONE" :foreground "forest green" :weight bold)
     ("WAITING" :foreground "orange" :weight bold)
     ("HOLD" :foreground "magenta" :weight bold)
     ("CANCELLED" :foreground "forest green" :weight bold)
     ("MEETING" :foreground "forest green" :weight bold)
     ("PHONE" :foreground "forest green" :weight bold)))
 '(org-todo-keywords
   '((sequence "TODO(t)" "INPROGRESS(p)" "NEXT(n)" "|" "DONE(d)")
     (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING" "LINK")))
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/")))
 '(package-selected-packages
   '(elpy org-download react-snippets go-tag lsp-ui lsp-mode flymake-yaml flycheck-actionlint flymake-actionlint go-imports flyspell-popup darkroom restclient-jq treesit-auto org-jira jenkinsfile-mode ef-themes transient ripgrep ansible-vault xml+ helm-go-package makefile-executor zone-nyan org-present xclip emacsql-sqlite gotest pcache httpcode systemd toml-mode eldoc-toml string-inflection rainbow-identifiers rainbow-blocks gitignore-snippets dired-rainbow godoctor go-fill-struct go-autocomplete go poetry npm-mode npm ansible cpupower go-complete edit-indirect material-theme exotica-theme virtualenvwrapper go-direx go-dlv go-eldoc go-imenu go-projectile go-snippets company-go go-guru go-playground axe company-terraform indent-tools yaml-imenu flymake-yamllint gitignore-templates docker-cli python-insert-docstring darkokai-theme jinja2-mode impatient-mode ts pandoc aggressive-indent focus rainbow-delimiters butler groovy-imports elmacro sicp free-keys visual-regexp flycheck-yamllint color-moccur realgud-ipdb hierarchy ecb ag mexican-holidays company-jedi pyvenv bind-key jedi plantuml-mode ctags-update emoji-display undo-tree aws-ec2 awscli-capf rjsx-mode markdown-mode+ humanoid-themes imenus vlf xwwp csv csv-mode clojure-mode clojure-quick-repls emojify mvn tangotango-theme highlight-indent-guides imenu-list synosaurus dockerfile-mode haskell-mode smex editorconfig typescript-mode realgud-node-inspect gnu-elpa-keyring-update aws-snippets org-gcal jenkins 2048-game lua-mode px jupyter github-theme latex-math-preview latex-pretty-symbols latex-preview-pane latex-unicode-math-mode csharp-mode auto-org-md highlight-doxygen simple-call-tree ycmd company-irony company-irony-c-headers bitlbee glsl-mode function-args cargo rust-mode js2-closure js2-highlight-vars js3-mode jsfmt ac-etags gnuplot gnuplot-mode nasm-mode mips-mode elfeed ruby-end autopair racket-mode zone-sl zone-rainbow vue-mode viking-mode term-run rinari php-mode ox-ioslide ox-impress-js ox-html5slide org-pdfview ob-browser nyan-mode multi-web-mode monokai-theme matlab-mode linum-off jsx-mode jade-mode htmlize hlinum green-phosphor-theme graphviz-dot-mode gotham-theme faff-theme evil enh-ruby-mode emmet-mode cyberpunk-theme company-web color-theme-solarized coffee-mode blackboard-theme arduino-mode angular-snippets angular-mode airline-themes))
 '(pixel-scroll-precision-mode t)
 '(plantuml-default-exec-mode 'server)
 '(plantuml-executable-args '("-headless -DRELATIVE_INCLUDE=\".\""))
 '(plantuml-indent-level 4)
 '(plantuml-jar-args '("-charset" "ISO-8859-1"))
 '(plantuml-jar-path "~/.emacs.d/plantuml.jar")
 '(plantuml-java-args
   '("-Djava.awt.headless=true" "-Dplantuml.include.path=\"~/.C4-PlantUML\"" "-jar" "--illegal-access=deny" "-checkversion"))
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(project-compilation-buffer-name-function 'project-prefixed-buffer-name)
 '(projectile-globally-ignored-file-suffixes '(".png" ".gif" ".pdf" "*.class"))
 '(python-indent-guess-indent-offset nil)
 '(python-indent-offset 4)
 '(python-shell-interpreter "python3")
 '(python-shell-interpreter-interactive-arg "-i")
 '(realgud:node-inspect-command-name "node inspect")
 '(request-curl "curl2")
 '(request-log-level 'warn)
 '(request-message-level 'warn)
 '(safe-local-variable-values '((org-html-htmlize-output-type . inline-css)))
 '(save-interprogram-paste-before-kill t)
 '(select-enable-clipboard nil)
 '(send-mail-function 'sendmail-send-it)
 '(show-paren-mode t)
 '(show-trailing-whitespace t)
 '(sky-color-clock-enable-emoji-icon nil)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(sql-port 0)
 '(switch-to-buffer-obey-display-actions t)
 '(tab-width 8)
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(terraform-format-on-save t)
 '(terraform-format-on-save-mode-hook nil)
 '(tooltip-mode nil)
 '(tramp-encoding-shell "/bin/bash")
 '(tramp-remote-path
   '(tramp-own-remote-path tramp-default-remote-path "/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin" "/opt/bin" "/opt/sbin" "/opt/local/bin" "/home/pkb/.pyenv/bin"))
 '(treemacs-width 30)
 '(treesit-font-lock-level 4)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   '((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF")))
 '(vc-annotate-very-old-color nil)
 '(vc-dir-mode-hook '(turn-on-diff-hl-mode))
 '(vertico-mouse-mode t)
 '(warning-minimum-level :emergency)
 '(warning-suppress-types '((comp)))
 '(web-mode-enable-current-element-highlight t)
 '(weechat-color-list
   (unspecified "#272822" "#49483E" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))
 '(whitespace-style
   '(face trailing tabs spaces lines newline empty indentation space-after-tab space-before-tab space-mark tab-mark newline-mark))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"])
 '(yaml-mode-hook
   '(yaml-set-imenu-generic-expression lsp-deferred highlight-indent-guides-mode) t)
 '(yank-pop-change-selection nil))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#222524" :foreground "#eaf2ef" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 120 :width normal :foundry "FRJN" :family "IntelOne Mono"))))
 '(highlight-indent-guides-character-face ((t (:foreground "gainsboro"))))
 '(highlight-indent-guides-even-face ((t (:background "color-17")))))
