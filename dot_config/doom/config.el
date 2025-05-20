;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
; (setq org-directory "~/org/")
; (setq org-directory (or (getenv "ORG_DIRECTORY") "~/org"))
(setq org-directory (or (getenv "ORG_DIRECTORY") "~/notes/org-files"))
;; (setq org-log-done 'time)
;; (setq org-archive-location "%s_done::datetree/*** My Custom Header")

; TODO: Delete me
; (setq org-agenda-files
;       (directory-files-recursively "/home/matthew/notes/business-ops-center/" "\\.org$"))

; (setq org-agenda-files
;       (directory-files-recursively org-directory "\\.org$"))

;; non-recursive version
(setq org-agenda-files
      (directory-files org-directory t "\\.org$"))

(setq org-archive-location "archive.org::datetree/"
                                        ; Longer example:
                                        ; org-archive-location "%s_done::datetree/* Some header"
      org-enforce-todo-dependencies t
      org-log-done 'time)

; (defun my/skip-unless-closed-or-logbook ()
;   "Skip entries without CLOSED: or LOGBOOK: markers."
;   (let ((subtree-end (save-excursion (org-end-of-subtree t))))
;     (unless (re-search-forward "CLOSED:\\|LOGBOOK:" subtree-end t)
;       subtree-end)))

; (defun my/skip-unless-completed ()
;   "Skip entries unless they're closed, logged, or habits."
;   (let ((subtree-end (save-excursion (org-end-of-subtree t)))
;         (is-habit (org-is-habit-p)))
;     (unless (or is-habit
;                 (re-search-forward "CLOSED:\\|LOGBOOK:" subtree-end t))
;       subtree-end)))


; (setq my-org-agenda-custom-commands
;       '(("y" "Yesterday's DONE tasks"
;          agenda ""
;          ((org-agenda-span 1)
;           (org-agenda-start-day "-1d")
;           (org-agenda-start-with-log-mode t)
;           ; (org-agenda-skip-function #'my/skip-unless-closed-or-logbook)))))
;           (org-agenda-skip-function #'my/skip-unless-completed)))))

; (setq my-org-agenda-custom-commands
;       '(("y" "Yesterday's DONE tasks"
;          agenda ""
;          ((org-agenda-span 1)
;           (org-agenda-start-day "-1d")
;           (org-agenda-start-with-log-mode t)
;           (org-agenda-skip-function
;            '(org-agenda-skip-entry-if 'notregexp "CLOSED:"))))))

; (setq org-agenda-custom-commands my-org-agenda-custom-commands)

; (setq org-agenda-custom-commands
;       (append org-agenda-custom-commands my-org-agenda-custom-commands))

; Exmaple of all todo commands
; (after! org
;   (setq org-agenda-custom-commands
;         '(("c" "Simple agenda view"
;            ((agenda "")
;             (alltodo ""))))))

; (after! org
;         (setq org-agenda-custom-commands
;               (append org-agenda-custom-commands my-org-agenda-custom-commands)))


(setq org-agenda-prefix-format
      '((agenda . "  %?-12t% s")
      ; '((agenda . "  %?-13t%?-12s")
        (todo . "  ")
        (tags . "  ")
        (search . "  ")
        ))

(after! org-agenda
  (org-super-agenda-mode))

(after! org
        (add-to-list 'org-modules 'org-habit)
        (setq org-habit-graph-column 80)  ;; Position of the habit graph
        ;; (setq org-habit-show-habits-only-for-today nil)  ;; Optional: show habits for the whole week
        ;; (setq org-habit-show-habits-only-for-today t)  ;; Optional: show habits for the whole week
        (setq org-habit-show-all-today t)
        )


(after! org
  (setq org-agenda-files
        (directory-files-recursively org-directory "\\.org$")))

;; this is working but needs refinement
; (setq org-stuck-projects
;       '("+project/-DONE" ("NEXT") nil ""))
; Default value is ("+LEVEL=2/-DONE" ("TODO" "NEXT" "NEXTACTION") nil "")


(after! org
  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           ((agenda "" ((org-deadline-warning-days 7)))
            (todo "NEXT" ((org-agenda-overriding-header "Next Tasks")))
            (tags "project+LEVEL=1" ((org-agenda-overriding-header "Top-Level Projects")))
            (tags-todo "+project" ((org-agenda-overriding-header "Project Tasks")))))

          ;; ;; this can be deleted
          ;; ("e" "Dashboard"
          ;;  ((agenda "" ((org-deadline-warning-days 7)))
          ;;   (todo "NEXT" ((org-agenda-overriding-header "Next Tasks")))
          ;;   (tags "project+LEVEL=1" ((org-agenda-overriding-header "Top-Level Projects")))
          ;;   (tags-todo "+project" ((org-agenda-overriding-header "Project Tasks")))))

          ("r" "Review Dashboard"
           ((agenda "" ((org-agenda-span 3)
                        (org-agenda-start-day "0d")
                        (org-agenda-overriding-header "Agenda: Next 3 Days")))
            ;; illustrative example
            ; (todo "NEXT"
            ;       ((org-agenda-overriding-header "Next Actions (Plain)")))
            (todo "NEXT"
                  ((org-agenda-overriding-header "Next Actions (Unscheduled)")
                   (org-agenda-skip-function
                     '(or (org-agenda-skip-entry-if 'scheduled 'deadline)))))
            (stuck "" ((org-agenda-overriding-header "Stuck Projects")))
            (tags "CLOSED>=\"-7d\""
                  ((org-agenda-overriding-header "Closed Recently")))))

          ("v" "Veekly review" agenda "+work"
           ((org-agenda-span 8)
            (org-agenda-start-day "-7d")
            (org-agenda-start-with-log-mode t)  ;; double-check if really needed
            (org-agenda-show-log t)
            (org-agenda-skip-function
              '(org-agenda-skip-entry-if 'notregexp ":work:"))
            (org-agenda-log-mode-items '(closed state clock))))

          ("w" "Weekly review" agenda ""
           ((org-agenda-span 8)
            (org-agenda-start-day "-7d")
            (org-agenda-start-with-log-mode t)  ;; double-check if really needed
            (org-agenda-show-log 'only)
            (org-agenda-log-mode-items '(state clock))))

          ; ("w" "Work Tasks"
          ;  ((tags-todo "+work" ((org-agenda-overriding-header "Work-related Tasks")))))

          ("h" "Home Tasks"
           (
            ;; illustrative example
            ; (tags "+@home" ((org-agenda-overriding-header "Home-related Tags")))
            (tags-todo "+@home" ((org-agenda-overriding-header "Home-related Tasks")))))

          ; ("x" "Everything Dashboard"
          ;  ((agenda "" ((org-agenda-span 7)))
          ;   (todo "NEXT")
          ;   (tags-todo "+@home")
          ;   (tags "CLOSED>=\"-7d\"")
          ;   (search "project review"))))

          ; ("x" "Office Tasks"
          ;  ((tags-todo "office" ((org-agenda-overriding-header "Office Tasks")))))

          ("p" "Projects Overview"
           ((todo "PROJECT" ((org-agenda-overriding-header "All Projects")))
            (tags "project+LEVEL=1" ((org-agenda-overriding-header "Top-Level Projects")))))

          ; ("s" "Stuck Projects"
          ;  ((stuck "" ((org-agenda-overriding-header "Stuck Projects")))))

          ("n" "Next Actions"
           ((todo "NEXT")))

          ("u" "Next actions (unscheduled only)"
           ((todo "NEXT"
                  ((org-agenda-overriding-header "Next Actions (Not Scheduled or Deadlined)")
                   (org-agenda-skip-function
                     '(or (org-agenda-skip-entry-if 'scheduled 'deadline)))))))

          ;; ("x" "Completed Yesterday 0"
          ;;  ((agenda ""
          ;;         (
          ;;          (org-agenda-log-mode-items '(closed))
          ;;          (org-agenda-overriding-header "Tasks Completed 0")
          ;;          (org-agenda-show-log t)
          ;;          (org-agenda-skip-function
          ;;            '(org-agenda-skip-entry-if 'notclosed))
          ;;          (org-agenda-span 1)
          ;;          (org-agenda-start-day "-1d")
          ;;          )))
          ;;  )

          ;;            ;; (org-agenda-log-mode-items '(closed state))
          ;;            (org-agenda-log-mode-items '(closed state))

          ;; ("y" "Completed Yesterday 1"
          ;;  ((agenda ""
          ;;           ((org-agenda-span 1)
          ;;            (org-agenda-start-day "0d")
          ;;            (org-agenda-show-log t)
          ;;            ;; (org-agenda-log-mode-items '(closed state))
          ;;            (org-agenda-log-mode-items '(closed state))
          ;;            (org-agenda-overriding-header "Tasks Completed 1")
          ;;            (org-agenda-skip-function
          ;;             '(org-agenda-skip-entry-if 'notclosed 'nottodo 'done))
          ;;            ;;;; (org-agenda-prefix-format "  %t %s") ;; Override per view
          ;;            (org-agenda-prefix-format "  %t ") ;; Override per view
          ;;            (org-agenda-remove-tags nil)
          ;;            )))
          ;;  )

          ;; ("z" "Completed Yesterday 2"
          ;;  ((agenda ""
          ;;           (
          ;;            (org-agenda-archives-mode t)
          ;;            (org-agenda-log-mode-items '(state))  ; Show state changes (e.g., DONE)
          ;;            (org-agenda-overriding-header "Tasks Completed 2")
          ;;            (org-agenda-show-log t)
          ;;            (org-agenda-span 1)
          ;;            (org-agenda-start-day "-1d")
          ;;            ))))       ; Include archived tasks if any

          ("g" "Grouped Agenda"
           ((agenda "" ((org-super-agenda-groups
                         '((:name "Today"
                            :time-grid t
                            :scheduled today)
                           (:name "Due Soon"
                            :deadline future)
                           (:name "Overdue"
                            :deadline past)
                           (:name "High Priority"
                            :priority "A")
                           (:name "Projects"
                            :tag "project")
                           (:discard (:anything t))))))))

          ; broken, i think
          ("q" "Org-ql: TODOs by agenda-group"
           ((org-ql-block '(todo "IDEA")
                          ((org-ql-block-header "TODOs Grouped by agenda-group"))
                           :columns (deadline heading scheduled ((property "agenda-group") "Group"))
                           :sort (deadline scheduled))
            (agenda)))

          ; this works
          ("s" "Custom: Agenda and Emacs IDEA [#A] items"
           ((org-ql-block '(and (todo "IDEA")
                                (tags "Emacs")
                                (priority "A"))
                          ((org-ql-block-header "IDEA :Emacs: High-priority")))
            (agenda)))

          ("v" "My custom org-ql agenda"
           ((org-ql-block
             '(todo "IDEA")
             :columns (todo (priority "P") heading)
             :sort (priority)
             :ts-format "%Y-%m-%d")
            (agenda)))

          ; this works, but it's slower than the org-ql-block version
          ("t" "Custom: Agenda and Emacs IDEA [#A] items"
           ((tags-todo "PRIORITY=\"A\"+Emacs/!IDEA")
            (agenda)))

          ; ("w2" "Work Projects"
          ;  ((tags-todo "+work+project")))

          ("b" "Backlog"
           ((todo "TODO"
                  ((org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'scheduled 'deadline))
                   (org-agenda-overriding-header "Backlog"))))))))


(setq org-ql-views
      '(("Work TODOs"
         :buffers-files org-agenda-files
         :query (and (todo) (tags "work"))
         :title "Work Tasks")
        ("Completed Last Week"
         :buffers-files org-agenda-files
         :query (and (done) (closed :from -6))
         :title "Done This Week")))



; (setq org-agenda-custom-commands
;       '(("y" "Yesterday's DONE tasks"
;          agenda ""
;          ((org-agenda-span 1)
;           (org-agenda-start-day "-1d")
;           (org-agenda-start-with-log-mode t)
;           (org-agenda-skip-function
;            '(org-agenda-skip-entry-if 'notregexp "CLOSED:"))))))

;; Syntax example for list manipulation
;; (setq my-list '(a b c))
;; (push 'd my-list)         ;; Adds 'd' to the front: (d a b c)
;; (setq my-list (append my-list '(e f g))) ;; my-list is now (a b c e f g)
;; (setq my-list (append my-list 'x)) ;; my-list is now (a b c e f g)


; (defun my/generate-todo-report ()
;   "Generate a report of all TODOs in ~/org/todo.org into ~/org/todo-report.org."
;   (interactive)
;   (let ((todos
;          (org-ql-search (list "./todo.org")
;            '(todo)
;            :action (lambda ()
;                      (org-get-heading t t t t)))))
;     (with-temp-file "./todo-report.org"
;       (insert "* TODO Report\n\n")
;       (dolist (todo todos)
;         (insert "- " todo "\n")))
;     (message "Report generated at ./todo-report.org")))


(defun my/generate-todo-report ()
  "Generate a report of all TODOs in ~/notes/business-ops-center into ~/notes/business-ops-center/todo-report.org."
  (interactive)
  (let ((todos
         (org-ql-select (list "~/notes/business-ops-center/todo.org")
           '(todo)
           :action (lambda ()
                     (org-get-heading t t t t)))))
    (with-temp-file "~/notes/business-ops-center/todo-report.org"
      (insert "* TODO Report\n\n")
      (dolist (todo todos)
        (insert "- " todo "\n")))
    (message "Report generated at ~/notes/business-ops-center/todo-report.org")))

(use-package! org-depend :after org)
; (use-package! org-ql :after org)

(use-package! org-ql
  :commands (org-ql-search org-ql-view)
  :config
  ;; force dynamic block registration
  ; (require 'org-ql-block))

  (org-dynamic-block-define "org-ql-block" #'org-ql-block-dynamic))

; (setq org-enforce-todo-dependencies t)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
