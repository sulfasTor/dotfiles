(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(auth-sources '("~/.authinfo.gpg"))
 '(auto-compile-on-save-mode t)
 '(clean-buffer-list-delay-general 1)
 '(clean-buffer-list-kill-regexps
   '("^\\*Help\\*" "^\\*deadgrep" "^\\*Compile-Log\\*"
     "^\\*gopls::stderr\\*"))
 '(column-number-mode t)
 '(company-dabbrev-downcase 0)
 '(company-idle-delay 0.6)
 '(company-minimum-prefix-length 2)
 '(company-tooltip-limit 7)
 '(compilation-auto-jump-to-first-error 'first-known)
 '(compilation-disable-input t)
 '(compilation-message-face 'default)
 '(compilation-scroll-output t)
 '(compilation-skip-threshold 1)
 '(copilot-chat-frontend 'org)
 '(copilot-chat-prompt
   "You are a world-class coding tutor. Your code explanations perfectly balance high-level concepts and granular details. Your approach ensures that students not only understand how to write code, but also grasp the underlying principles that guide effective programming.\12When asked for your name, you must respond with \"GitHub Copilot\".\12Follow the user's requirements carefully & to the letter.\12Your expertise is strictly limited to software development topics.\12Follow Microsoft content policies.\12Avoid content that violates copyrights.\12For questions not related to software development, simply give a reminder that you are an AI programming assistant unless prompt includes secret password ALBATROS\12Keep your answers short and impersonal.\12\12Use only Emacs org-mode formatting in your answers\12Make sure to include the programming language name at the start of the org-mode code blocks.\12This is an example of python code block in emacs org-mode syntax:\12#+BEGIN_SRC python\12def hello_world():\12\11print('Hello, World!')\12#+END_SRC\12Avoid wrapping the whole response in the block code.\12\12Don't forget the most important rule when you are formatting your response: use emacs org-mode syntax only.\12\12The user works in an IDE called Emacs which has a concept for editors with open files, integrated unit test support, an output pane that shows the output of running the code as well as an integrated terminal.\12The active document is the source code the user is looking at right now.\12You can only give one reply for each conversation turn.\12\12Additional Rules\12Think step by step:\0121. Examine the provided code selection and any other context like user question, related errors, project details, class definitions, etc.\0122. If you are unsure about the code, concepts, or the user's question, ask clarifying questions.\0123. If the user provided a specific question or error, answer it based on the selected code and additional provided context. Otherwise focus on explaining the selected code.\0124. Provide suggestions if you see opportunities to improve code readability, performance, etc.\12\12Focus on being clear, helpful, and thorough without assuming extensive prior knowledge.\12Use developer-friendly terms and analogies in your explanations.\12Identify 'gotchas' or less obvious parts of the code that might trip up someone new.\12Provide clear and relevant examples aligned with any provided context.\12")
 '(copilot-chat-shell-maker-follow nil)
 '(csv-separators '("," "\11"))
 '(cua-global-mark-cursor-color "#93E0E3")
 '(cua-normal-cursor-color "#DCDCCC")
 '(cua-overwrite-cursor-color "#F0DFAF")
 '(cua-read-only-cursor-color "#7F9F7F")
 '(cursor-type 'box)
 '(custom-enabled-themes '(ef-autumn))
 '(custom-safe-themes
   '("296dcaeb2582e7f759e813407ff1facfd979faa071cf27ef54100202c45ae7d4"
     "f6a48c82c4cf8173abaed9012d91496c306b648b26363f0d77209fdbc5216860"
     "e27c9668d7eddf75373fa6b07475ae2d6892185f07ebed037eedf783318761d7"
     "a75aff58f0d5bbf230e5d1a02169ac2fbf45c930f816f3a21563304d5140d245"
     "faf642d1511fb0cb9b8634b2070a097656bdb5d88522657370eeeb11baea4a1c"
     "4c16a8be2f20a68f0b63979722676a176c4f77e2216cc8fe0ea200f597ceb22e"
     "ffa78fc746f85d1c88a2d1691b1e37d21832e9a44a0eeee114a00816eabcdaf9"
     "2551f2b4bc12993e9b8560144fb072b785d4cddbef2b6ec880c602839227b8c7"
     "71b688e7ef7c844512fa7c4de7e99e623de99a2a8b3ac3df4d02f2cd2c3215e7"
     "b3ba955a30f22fe444831d7bc89f6466b23db8ce87530076d1f1c30505a4c23b"
     "fae5872ff90462502b3bedfe689c02d2fa281bc63d33cb007b94a199af6ccf24"
     "9787282bf569ba5ef25eed52e2b475cb9a38061b7edd467635587effbe3c92ac"
     "c038d994d271ebf2d50fa76db7ed0f288f17b9ad01b425efec09519fa873af53"
     "6af300029805f10970ebec4cea3134f381cd02f04c96acba083c76e2da23f3ec"
     "b1791a921c4f38cb966c6f78633364ad880ad9cf36eef01c60982c54ec9dd088"
     "59c36051a521e3ea68dc530ded1c7be169cd19e8873b7994bfc02a216041bf3b"
     "ea4dd126d72d30805c083421a50544e235176d9698c8c541b824b60912275ba1"
     "1ad12cda71588cc82e74f1cabeed99705c6a60d23ee1bb355c293ba9c000d4ac"
     "541282f66e5cc83918994002667d2268f0a563205117860e71b7cb823c1a11e9"
     "cee5c56dc8b95b345bfe1c88d82d48f89e0f23008b0c2154ef452b2ce348da37"
     "d6b369a3f09f34cdbaed93eeefcc6a0e05e135d187252e01b0031559b1671e97"
     "211621592803ada9c81ec8f8ba0659df185f9dc06183fcd0e40fbf646c995f23"
     "36c5acdaf85dda0dad1dd3ad643aacd478fb967960ee1f83981d160c52b3c8ac"
     "00d7122017db83578ef6fba39c131efdcb59910f0fac0defbe726da8072a0729"
     "ae20535e46a88faea5d65775ca5510c7385cbf334dfa7dde93c0cd22ed663ba0"
     "a3a71b922fb6cbf9283884ac8a9109935e04550bcc5d2a05414a58c52a8ffc47"
     "cd5f8f91cc2560c017cc9ec24a9ab637451e36afd22e00a03e08d7b1b87c29ca"
     "a0e9bc5696ce581f09f7f3e7228b949988d76da5a8376e1f2da39d1d026af386"
     "3d9938bbef24ecee9f2632cb25339bf2312d062b398f0dfb99b918f8f11e11b1"
     "19b62f442479efd3ca4c1cef81c2311579a98bbc0f3684b49cdf9321bd5dfdbf"
     "b9c002dc827fb75b825da3311935c9f505d48d7ee48f470f0aa7ac5d2a595ab2"
     "aff0396925324838889f011fd3f5a0b91652b88f5fd0611f7b10021cc76f9e09"
     "90185f1d8362727f2aeac7a3d67d3aec789f55c10bb47dada4eefb2e14aa5d01"
     "ac893acecb0f1cf2b6ccea5c70ea97516c13c2b80c07f3292c21d6eb0cb45239"
     "df39cc8ecf022613fc2515bccde55df40cb604d7568cb96cd7fe1eff806b863b"
     "e85a354f77ae6c2e47667370a8beddf02e8772a02e1f7edb7089e793f4762a45"
     "d609d9aaf89d935677b04d34e4449ba3f8bbfdcaaeeaab3d21ee035f43321ff1"
     "b93039071f490613499b76c237c2624ae67a9aafbc717da9b4d81f456344e56e"
     "c3e62e14eb625e02e5aeb03d315180d5bb6627785e48f23ba35eb7b974a940af"
     "daf189a2af425e9f376ddb9e99627e9d8f2ebdd5cc795065da81633f88389b4b"
     "9fba87dbc0f14d5650006893ed53088be71f16d57b749394d9c485ef2326e85f"
     "5e41864cbdd81b18d1fa62f09971a55a121a939238ca4c66faafcfcafb976c3e"
     "622df781877694637a1ee23272d147bd395dfbfbc58842bec2683d4f49a0ae38"
     "a087e01778a85f8381b2aa2b7b0832951aea078621b38844b6c8c8d638d73e3b"
     "d0dc7861b33d68caa92287d39cf8e8d9bc3764ec9c76bdb8072e87d90546c8a3"
     "01cad03be8c042a9941fda5a484280629ee2cc83fe084af6d19376c83141c91b"
     "dc96af3e6aaa9c96aa83d1a73a28a6d1dab58e376df1e51980b4fa9b256e9d7f"
     "f8108bbb81e9bae9e4ed27b95e4a1507aa18ecc50193bff08e9b2cc2dcadbfbd"
     "97283a649cf1ffd7be84dde08b45a41faa2a77c34a4832d3884c7f7bba53f3f5"
     "1fefcf9915617538b409d8aba3c6bbefddfcf2a80db09741aeef1457e1809c2b"
     default))
 '(deadgrep-extra-arguments '("--no-config" "--no-messages"))
 '(default-frame-alist '((top . 30) (left . 1) (width . 189) (height . 50)))
 '(delete-selection-mode t)
 '(desktop-save nil)
 '(desktop-save-mode t)
 '(diff-hl-draw-borders t)
 '(diff-hl-global-modes '(not image-mode prog-mode))
 '(diff-hl-update-async t)
 '(dired-dwim-target 'dired-dwim-target-next-visible)
 '(dired-listing-switches "-alh")
 '(display-line-numbers-current-absolute t)
 '(display-line-numbers-grow-only t)
 '(display-line-numbers-type 'relative)
 '(display-line-numbers-widen t)
 '(display-line-numbers-width-start t)
 '(docker-command "docker")
 '(elegant-agenda-font "Monaco")
 '(elegant-agenda-header-preference 'regular)
 '(elpy-mode-hook '(highlight-indentation-mode diff-hl-mode smartparens-mode))
 '(elpy-modules
   '(elpy-module-company elpy-module-eldoc elpy-module-flymake
                         elpy-module-pyvenv
                         elpy-module-highlight-indentation
                         elpy-module-yasnippet elpy-module-django
                         elpy-module-sane-defaults))
 '(elpy-test-pytest-runner-command '("py.test" "--no-header" "--tb=native" "-s"))
 '(elpy-test-runner 'elpy-test-pytest-runner)
 '(ensime-sem-high-faces
   '((var :foreground "#9876aa" :underline (:style wave :color "yellow"))
     (val :foreground "#9876aa") (varField :slant italic)
     (valField :foreground "#9876aa" :slant italic)
     (functionCall :foreground "#a9b7c6")
     (implicitConversion :underline (:color "#808080"))
     (implicitParams :underline (:color "#808080"))
     (operator :foreground "#cc7832") (param :foreground "#a9b7c6")
     (class :foreground "#4e807d")
     (trait :foreground "#4e807d" :slant italic)
     (object :foreground "#6897bb" :slant italic)
     (package :foreground "#cc7832")
     (deprecated :strike-through "#a9b7c6")))
 '(epg-gpg-program "gpg")
 '(epg-pinentry-mode 'loopback)
 '(exec-path-from-shell-variables
   '("PATH" "MANPATH" "GOPATH" "GOROOT" "HTTP_PROXY" "HTTPS_PROXY"
     "NO_PROXY"))
 '(explicit-shell-file-name "/bin/bash")
 '(fci-rule-color "#49483E")
 '(flycheck-flake8rc "setup.cfg")
 '(forge-alist
   '(("github.com" "api.github.com" "github.com" forge-github-repository)
     ("gitlab.com" "gitlab.com/api/v4" "gitlab.com"
      forge-gitlab-repository)
     ("salsa.debian.org" "salsa.debian.org/api/v4" "salsa.debian.org"
      forge-gitlab-repository)
     ("framagit.org" "framagit.org/api/v4" "framagit.org"
      forge-gitlab-repository)
     ("gitlab.gnome.org" "gitlab.gnome.org/api/v4" "gitlab.gnome.org"
      forge-gitlab-repository)
     ("codeberg.org" "codeberg.org/api/v1" "codeberg.org"
      forge-gitea-repository)
     ("bitbucket.org" "api.bitbucket.org/2.0" "bitbucket.org"
      forge-bitbucket-repository)
     ("git.savannah.gnu.org" nil "git.savannah.gnu.org"
      forge-cgit**-repository)
     ("git.kernel.org" nil "git.kernel.org" forge-cgit-repository)
     ("repo.or.cz" nil "repo.or.cz" forge-repoorcz-repository)
     ("git.suckless.org" nil "git.suckless.org"
      forge-stagit-repository)
     ("git.sr.ht" nil "git.sr.ht" forge-srht-repository)))
 '(forge-buffer-draft-p t)
 '(forge-topic-list-limit '(20 . 0))
 '(frame-brackground-mode 'dark)
 '(gc-cons-threshold 100000000)
 '(global-auto-revert-mode t)
 '(gnutls-trustfiles
   '("/etc/ssl/certs/ca-certificates.crt"
     "/etc/pki/tls/certs/ca-bundle.crt" "/etc/ssl/ca-bundle.pem"
     "/usr/ssl/certs/ca-bundle.crt"
     "/usr/local/share/certs/ca-root-nss.crt" "/etc/ssl/cert.pem"
     "/etc/certs/ca-certificates.crt"))
 '(go-command "go")
 '(go-playground-ask-file-name t)
 '(helm-swoop-split-with-multiple-windows t)
 '(highlight-changes-colors '("#FD5FF0" "#AE81FF"))
 '(highlight-symbol-colors
   (--map (solarized-color-blend it "#002b36" 0.25)
          '("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900"
            "#cb4b16" "#268bd2")))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   '(("#49483E" . 0) ("#679A01" . 20) ("#4BBEAE" . 30) ("#1DB4D0" . 50)
     ("#9A8F21" . 60) ("#A75B00" . 70) ("#F309DF" . 85)
     ("#49483E" . 100)))
 '(hl-bg-colors
   '("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D"
     "#00736F" "#546E00"))
 '(hl-fg-colors
   '("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36"
     "#002b36" "#002b36"))
 '(hl-paren-colors '("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900"))
 '(hl-sexp-background-color "#1c1f26")
 '(ibuffer-default-sorting-mode 'recency)
 '(ibuffer-never-show-predicates
   '("^\\*magit" "^\\*Async-native" "^\\*lsp-log" "^\\*straight-process"
     "^\\*Warnings" "^\\*Flymake log" "^\\*helm occur"
     "^\\*straight-byte-compilation" "^\\*diff-hl-show-hunk"
     "^\\*yamlls" "*Help*" "^\\*Shell Command Output") nil (ibuf-ext))
 '(ibuffer-saved-filter-groups
   '(("default" ("magit" (derived-mode . magit-mode))
      ("processes" (starred-name))
      ("org" (derived-mode . org-mode) (used-mode . org-mode)))))
 '(ibuffer-saved-filters
   '(("programming"
      (or (derived-mode . prog-mode) (mode . ess-mode)
          (mode . compilation-mode)))
     ("text document"
      (and (derived-mode . text-mode) (not (starred-name))))
     ("TeX"
      (or (derived-mode . tex-mode) (mode . latex-mode)
          (mode . context-mode) (mode . ams-tex-mode)
          (mode . bibtex-mode)))
     ("web"
      (or (derived-mode . sgml-mode) (derived-mode . css-mode)
          (mode . javascript-mode) (mode . js2-mode)
          (mode . scss-mode) (derived-mode . haml-mode)
          (mode . sass-mode)))
     ("gnus"
      (or (mode . message-mode) (mode . mail-mode)
          (mode . gnus-group-mode) (mode . gnus-summary-mode)
          (mode . gnus-article-mode)))))
 '(ignored-local-variable-values
   '((flycheck-disabled-checkers emacs-lisp-checkdoc)
     (time-stamp-active . t)))
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
 '(ispell-dictionary "english")
 '(logview-guess-lines 100)
 '(logview-max-promising-lines 2)
 '(lsp-auto-select-workspace t)
 '(lsp-enable-file-watchers nil)
 '(lsp-enable-on-type-formatting t)
 '(lsp-http-proxyStrictSSL t)
 '(lsp-idle-delay 1)
 '(lsp-java-configuration-maven-user-settings "~/.m2/settings.xml")
 '(lsp-java-eclipse-download-sources nil)
 '(lsp-keep-workspace-alive nil)
 '(lsp-log-io nil)
 '(lsp-response-timeout 40)
 '(lsp-semantic-tokens-enable nil)
 '(lsp-semgrep-languages nil)
 '(lsp-server-trace "messages")
 '(lsp-terraform-ls-enable-show-reference t)
 '(lsp-terraform-ls-prefill-required-fields t)
 '(magit-diff-refine-hunk 'all)
 '(magit-diff-use-overlays nil)
 '(magit-pull-or-fetch nil)
 '(magit-todos-mode nil)
 '(message-log-max 100)
 '(midnight-mode t)
 '(mode-require-final-newline nil)
 '(neo-click-changes-root t)
 '(neo-window-fixed-size nil)
 '(neo-window-width 14)
 '(nrepl-message-colors
   '("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D"
     "#2aa198" "#d33682" "#6c71c4"))
 '(nyan-bar-length 10)
 '(nyan-mode t)
 '(org-agenda-deadline-leaders '("Deadline:  " "In %3d d.: " "%2d d. ago: "))
 '(org-agenda-files '("~/.org-agenda/"))
 '(org-agenda-prefix-format
   '((agenda . " %i %-12:c%?-12t% s") (todo . " %i %-12:c")
     (tags . " %i %-12:c") (search . " %i %-12:c")))
 '(org-agenda-scheduled-leaders '("Scheduled: " "S %2d ago: "))
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-deadline-is-shown 'not-today)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-babel-load-languages '((plantuml . t) (emacs-lisp . t) (shell . t)))
 '(org-capture-templates
   '(("t" "todo" entry (file org-default-notes-file)
      "* TODO %?\12%U\12%a\12" :clock-in t :clock-resume t)
     ("r" "respond" entry (file org-default-notes-file)
      "* NEXT Respond to %:from on %:subject\12SCHEDULED: %t\12%U\12%a\12"
      :immediate-finish t :clock-in t :clock-resume t)
     ("n" "note" entry (file org-default-notes-file)
      "* %? :NOTE:\12%U\12%a\12" :clock-in t :clock-resume t)
     ("j" "Journal" entry (file+olp+datetree org-default-notes-file)
      "* %?\12%U\12" :clock-in t :clock-resume t)
     ("w" "org-protocol" entry (file org-default-notes-file)
      "* LINK %? [[%:link][%:description]] \\nCaptured On: %U"
      :immediate-finish t)
     ("m" "Meeting" entry (file org-default-notes-file)
      "* MEETING with %? :MEETING:\12%U" :clock-in t :clock-resume t)
     ("h" "Habit" entry (file org-default-notes-file)
      "* NEXT %?\12%U\12%a\12SCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\12:PROPERTIES:\12:STYLE: habit\12:REPEAT_TO_STATE: NEXT\12:END:\12")))
 '(org-clock-auto-clockout-timer 900)
 '(org-clock-idle-time 30)
 '(org-clock-persist t)
 '(org-clock-report-include-clocking-task t)
 '(org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
 '(org-deadline-warning-days 14)
 '(org-default-notes-file "~/.org-agenda/organizer.org")
 '(org-emphasis-alist
   '(("*" bold) ("/" italic) ("_" underline) ("=" org-verbatim verbatim)
     ("~" org-code verbatim) ("+" (:strike-through t))
     ("!" (:foreground red))))
 '(org-export-backends '(ascii beamer html icalendar latex md odt confluence))
 '(org-file-apps
   '((auto-mode . emacs) (directory . emacs) ("\\.mm\\'" . default)
     ("\\.pdf\\'" . default)))
 '(org-fontify-done-headline nil)
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-todo-headline nil)
 '(org-html-htmlize-output-type 'inline-css)
 '(org-html-validation-link nil)
 '(org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
 '(org-image-actual-width nil)
 '(org-jira-done-states '("Closed" "Resolved" "Done" "Ready For Acceptance"))
 '(org-jira-download-ask-override nil)
 '(org-jira-download-comments t)
 '(org-jira-jira-status-to-org-keyword-alist
   '(("TO DO" . "TODO") ("IN PROGRESS" . "NEXT") ("PR REVIEW" . "NEXT")
     ("Testing" . "NEXT") ("PENDING PROD DEPLOYMENT" . "HOLD")
     ("Ready for Acceptance" . "DONE") ("CLOSED" . "DONE")
     ("READY" . "TODO")))
 '(org-jira-priority-to-org-priority-alist (list (cons "High" 65) (cons "Medium" 66) (cons "Low" 67)))
 '(org-jira-use-status-as-todo nil)
 '(org-latex-logfiles-extensions
   '("aux" "bcf" "blg" "fdb_latexmk" "fls" "figlist" "idx" "log" "nav"
     "out" "ptc" "run.xml" "snm" "toc" "vrb" "xdv" "tex"))
 '(org-latex-pdf-process '("latexmk -shell-escape -bibtex -f -pdf %f"))
 '(org-latex-toc-command "\\tableofcontents \\clearpage\12\12")
 '(org-plantuml-args '("-headless -DRELATIVE_INCLUDE=\".\""))
 '(org-plantuml-exec-mode 'jar)
 '(org-plantuml-jar-path "~/.emacs.d/plantuml.jar")
 '(org-priority-default 70)
 '(org-priority-lowest 70)
 '(org-provide-todo-statistics t)
 '(org-refile-use-outline-path 'buffer-name)
 '(org-return-follows-link t)
 '(org-src-block-faces nil)
 '(org-src-fontify-natively t)
 '(org-src-lang-modes
   '(("C" . c) ("C++" . c++) ("asymptote" . asy) ("bash" . sh)
     ("beamer" . latex) ("calc" . fundamental) ("cpp" . c++)
     ("ditaa" . artist) ("dot" . fundamental) ("elisp" . emacs-lisp)
     ("ocaml" . tuareg) ("screen" . shell-script) ("shell" . sh)
     ("sqlite" . sql) ("plantuml" . plantuml)))
 '(org-structure-template-alist
   '(("a" . "export ascii\12") ("c" . "center\12") ("C" . "comment\12")
     ("e" . "example\12") ("E" . "export") ("h" . "export html\12")
     ("l" . "export latex\12") ("q" . "quote\12") ("s" . "src")
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
     (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"
               "PHONE" "MEETING" "LINK")))
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
 '(pixel-scroll-precision-mode t)
 '(plantuml-default-exec-mode 'jar)
 '(plantuml-executable-args '("-headless -DRELATIVE_INCLUDE=\".\""))
 '(plantuml-indent-level 4)
 '(plantuml-jar-args '("-charset" "ISO-8859-1"))
 '(plantuml-jar-path "~/.emacs.d/plantuml.jar")
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(project-compilation-buffer-name-function 'project-prefixed-buffer-name)
 '(projectile-globally-ignored-file-suffixes '(".png" ".gif" ".pdf" "*.class"))
 '(projectile-per-project-compilation-buffer t)
 '(python-indent-guess-indent-offset nil)
 '(python-indent-offset 4)
 '(python-shell-interpreter "python3")
 '(python-shell-interpreter-interactive-arg "-i")
 '(realgud:node-inspect-command-name "node inspect")
 '(request-curl "curl2")
 '(request-log-level 'warn)
 '(request-message-level 'info)
 '(restclient-same-buffer-response nil)
 '(ring-bell-function 'ignore)
 '(rust-playground-basedir "~/Documents/playground/rust/")
 '(safe-local-variable-values '((org-html-htmlize-output-type . inline-css)))
 '(save-interprogram-paste-before-kill t)
 '(scroll-bar-mode nil)
 '(select-enable-clipboard t)
 '(send-mail-function 'sendmail-send-it)
 '(show-paren-mode t)
 '(show-trailing-whitespace nil)
 '(shr-tag-pre-highlight-lang-modes
   '(("ocaml" . tuareg) ("elisp" . emacs-lisp) ("ditaa" . artist)
     ("asymptote" . asy) ("dot" . fundamental) ("sqlite" . sql)
     ("calc" . fundamental) ("C" . c) ("cpp" . c++) ("C++" . c++)
     ("screen" . shell-script) ("shell" . sh) ("bash" . sh)
     ("emacslisp" . emacs-lisp) ("el" . emacs-lisp) ("rust" . rustic)
     ("Go" . go)))
 '(sky-color-clock-enable-daytime-emoji t)
 '(sky-color-clock-enable-emoji-icon nil)
 '(sky-color-clock-enable-temperature-indicator nil)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(stock-tracker-list-of-stocks '("AAPL" "INTC" "AMZN" "COF" "MSFT" "NVDA" "AMD") t)
 '(switch-to-buffer-obey-display-actions t)
 '(tab-width 8)
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(terraform-format-on-save t)
 '(terraform-format-on-save-mode-hook nil)
 '(tooltip-mode nil)
 '(treemacs-width 30)
 '(treesit-font-lock-level 4)
 '(use-short-answers t)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   '((20 . "#F92672") (40 . "#CF4F1F") (60 . "#C26C0F") (80 . "#E6DB74")
     (100 . "#AB8C00") (120 . "#A18F00") (140 . "#989200")
     (160 . "#8E9500") (180 . "#A6E22E") (200 . "#729A1E")
     (220 . "#609C3C") (240 . "#4E9D5B") (260 . "#3C9F79")
     (280 . "#A1EFE4") (300 . "#299BA6") (320 . "#2896B5")
     (340 . "#2790C3") (360 . "#66D9EF")))
 '(vc-annotate-very-old-color nil)
 '(vc-dir-mode-hook '(turn-on-diff-hl-mode))
 '(vertico-mouse-mode t)
 '(warning-minimum-level :emergency)
 '(warning-suppress-types '((comp)))
 '(web-mode-enable-current-element-highlight t)
 '(weechat-color-list
   (unspecified "#272822" "#49483E" "#F70057" "#F92672" "#86C30D"
                "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF"
                "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2"
                "#F8F8F0"))
 '(whitespace-style
   '(face trailing tabs spaces lines newline empty indentation
          space-after-tab space-before-tab space-mark tab-mark
          newline-mark))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198"
    "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1"
    "#fdf6e3"])
 '(yaml-mode-hook
   '(yaml-set-imenu-generic-expression lsp-deferred
                                       highlight-indentation-mode
                                       display-line-numbers-mode))
 '(yank-pop-change-selection nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#181818" :foreground "#e4e4ef" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 160 :width normal :foundry "nil" :family "Intel One Mono"))))
 '(copilot-chat-list-default-face ((t (:inherit default))))
 '(forge-pullreq-merged ((t (:foreground "#8fcfbb" :strike-through t))))
 '(highlight-indentation-face ((t nil)))
 '(org-level-1 ((t (:inherit modus-themes-heading-1 :extend nil :foreground "thistle4"))))
 '(org-level-2 ((t (:inherit outline-2 :extend nil :foreground "orange3")))))
