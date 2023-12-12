;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")
(setq org-directory "~/tmp/scratchpad-20230328/")
;; (setq org-directory (file-name-as-directory "~/tmp/scratchpad-20230326/"))
;; (setq org-agenda-files '("~/tmp/scratchpad-20230326/inbox.org"
;;                          "~/tmp/scratchpad-20230326/gtd.org"
;;                          "~/tmp/scratchpad-20230326/tickler.org"))

;; TODO
;; (setq org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3)
;;                            ("~/gtd/someday.org" :level . 1)
;;                            ("~/gtd/tickler.org" :maxlevel . 2)))
;;
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)
;; `nil)

;; ;; TODO Delete me
;; (setq mpb-var1 100)
;; (setq mpb-var2 (- 100 34))
;; (setq mpb-var3 (+ mpb-var2 2))
;; (setq mpb-var4 '(mpb-var1 mpb-var2))
;; (setq mpb-var5 '("~/tmp/scratchpad-20230326/inbox.org"
;;                  "~/tmp/scratchpad-20230326/gtd.org"))

;; (defun identity-fnx (x)
;;   (* x x))

;; (setq my-squares
;;       (mapcar #'identity-fnx '(1 2 3))) ; => (1 2 3)

;; TODO
;; (setq org-todo-keywords
;;       '((sequence "TODO" "FEEDBACK" "VERIFY" "|" "DONE" "DELEGATED")))
;;
(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(defun concat-org-directory(filename)
  (concat (file-name-as-directory org-directory) filename))

;; (defun concat-org-directory-list(filenames)
;;   (mapcar #'concat-org-directory filenames))

;; (setq my-file-paths1
;;       (mapcar #'concat-org-directory '("inbox.org" "gtd.org")))

;; (setq my-file-paths1
;;       (mapcar #'concat-org-directory '("inbox.org" "gtd.org")))

;; (setq org-agenda-files
;;       (mapcar #'concat-org-directory '("inbox.org" "gtd.org" "tickler.org")))

;; (setq myList3 '("foo" "bar"))
;; (setq myList3 '("qux" "quux"))

;; (setq org-agenda-files3
;;       (mapcar #'concat-org-directory myList3))


;; (setq org-agenda-files (concat-org-directory-list '("inbox.org" "gtd.org" "tickler.org")))

;; ;; (setq org-refile-targets4 (list ((concat-org-directory "gtd.org") :maxlevel . 3)
;; ;;                                 ((concat-org-directory "someday.org") :level . 1)
;; ;;                                 ((concat-org-directory "tickler.org") :maxlevel . 2)))

;; ;; The below is a dynamic, but kinda unwieldy way to get to do the following but
;; ;; without hardcoding:
;; ;; (setq org-refile-targets4 '(("~/gtd/gtd.org" :maxlevel . 3)
;; ;;                            ("~/gtd/someday.org" :level . 1)
;; ;;                            ("~/gtd/tickler.org" :maxlevel . 2)))
;; (setq org-refile-targets (list (cons (concat-org-directory "gtd.org") (cons :maxlevel 3 ))
;;                                (cons (concat-org-directory "someday.org") (cons :level 1 ))
;;                                (cons (concat-org-directory "tickler.org") (cons :maxlevel 2 ))))

;; (setq gtd-file (concat-org-directory "gtd.org"))
;; (setq someday-file (concat-org-directory "someday.org"))
;; (setq tickler-file (concat-org-directory "tickler.org"))

(setq gtd-file (concat-org-directory "gtd.org")
      inbox-file (concat-org-directory "inbox.org")
      someday-file (concat-org-directory "someday.org")
      tickler-file (concat-org-directory "tickler.org")
      ;; org-agenda-files747 (list inbox-file gtd-file tickler-file)
      org-agenda-files `(,inbox-file ,gtd-file ,tickler-file)
      ;; org-agenda-files749 '(inbox-file ,gtd-file ,tickler-file)
      org-refile-targets `((,gtd-file :maxlevel . 3)
                           (,someday-file :level . 1)
                           (,tickler-file :maxlevel . 2))
      ;; org-refile-targets747 (list (cons gtd-file (cons :maxlevel 3 ))
      ;;                             (cons someday-file (cons :level 1 ))
      ;;                             (cons tickler-file (cons :maxlevel 2 )))
      )

;; (setq org-refile-targets2 (list (cons gtd-file (cons :maxlevel 3 ))
;;                                 (cons someday-file (cons :level 1 ))
;;                                 (cons tickler-file (cons :maxlevel 2 ))))

;; (require 'thunk)

;; (setq mpb-number 10)

;; (thunk-let ((mpb-number
;;                )))

;; (defun mpbf (number)
;;   (thunk-let ((derived-number
;;                (progn (message "Calculating 1 plus 2 times %d" mpb-number)
;;                       (1+ (* 2 mpb-number)))))
;;     derived-number))

    ;; (if (> number 10)
    ;;     derived-number
    ;;   number)))

;; (defun mpbf (number)
;;   (thunk-let ((derived-number
;;               ;; (progn (message "Calculating 1 plus 2 times %d" number)
;;               ;;        myList3)))
;;               myList3))
;;     (if (> number 10)
;;         derived-number
;;       number)))



;; (thunk-let ((myList4
;;              ;; (progn (message "Calculating 1 plus 2 times %d" number)
;;              ;;        myList3)))
;;              myList3)))

;; (thunk-let ((myList5 (mpbf 11))))

(setq org-capture-templates `(("t" "Todo [inbox]" entry
                               (file+headline ,inbox-file "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline ,tickler-file "Tickler")
                               "* %i%? \n %U")))

;; (setq org-capture-template2 (list (`"t" `"Todo [inbox]" `entry
;;                                    `(file+headline "~/gtd/inbox.org" "Tasks")
;;                                    "* TODO %i%?"))
;;       )
;;                                   ;; ("T" "Tickler" entry
;;                                   ;;  `(file+headline "~/gtd/tickler.org" "Tickler")
;;                                   ;;  "* %i%? \n %U")))


;; (setq myList (list mpb-var1 mpb-var2))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))


(setq org-babel-clojure-backend 'cider)

(defun org-babel-execute:typescript (body params)
  (let ((org-babel-js-cmd "npx ts-node < "))
    (org-babel-execute:js body params)))

(setq deft-directory "~/tmp/scratchpad-20230326/"
      deft-extensions `("org" "txt")
      deft-recursive t)
