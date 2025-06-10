;;; org/capture-templates.el -*- lexical-binding: t; -*-

;; (setq org-capture-templates ())


;; TODO replace ~/.config/doom with doom-user-dir

(add-to-list 'org-capture-templates
             '("d" "Daily Report" entry
               (file+olp+datetree "~/org/reports.org")
               (file "~/.config/doom/org/templates/dailyreviewtemplate.org")
               :tree-type month))

(add-to-list 'org-capture-templates
             '("r" "Report" entry
               ;; both of these work:
               ;; (file+headline "~/org/custom.org" "Inbox")
               (file+olp+datetree "~/org/reports.org")
               (file "~/.config/doom/org/templates/reports.org")))


;; Note: This uses "Meetings" headline if it exists, but does not otherwise create it.
(add-to-list 'org-capture-templates
             '("m" "Meeting" entry (file+function
                                    "~/org/reports.org"
                                    (lambda ()
                                      (org-datetree-find-date-create
                                       (org-date-to-gregorian (org-today)) t)
                                      (re-search-forward "^\\*.+ Meetings" nil t)))
               "* TODO %?\n%U" :empty-lines 1))

;; (defun my/org-today-meetings-target ()
;;   "Return location path to today's 'Meetings' heading in a datetree-style file."
;;   (let* ((time (current-time))
;;          (year (format-time-string "%Y" time))
;;          (month-name (format-time-string "%B" time))        ;; e.g. June
;;          (month-num (format-time-string "%m" time))         ;; e.g. 06
;;          (day-heading (format-time-string "%Y-%m-%d %A" time)) ;; e.g. 2025-06-10 Tuesday
;;          (month-heading (format "%s-%s %s" year month-num month-name))) ;; e.g. 2025-06 June
;;     `(,year ,month-heading ,day-heading "Meetings")))

;; (add-to-list 'org-capture-templates
;;              '("M" "Meeting Entry"
;;                entry
;;                (file+function "~/org/reports.org" my/org-today-meetings-target)
;;                "* %^{Meeting title}\nEntered on %U\n"
;;                :empty-lines 1))




;; =====


(add-to-list 'org-capture-templates
             '("R" "Report 1" entry
               (here)
               (file "~/.config/doom/org/templates/reports.org")))

(add-to-list 'org-capture-templates
             '("c" "[ ]" checkitem
               (here)))

(add-to-list 'org-capture-templates
             '("i" "item" item
               (here)))

(add-to-list 'org-capture-templates
             '("e" "entry" entry
               ;; (file+headline "~/org/custom.org" "Entries")
               (here)
               "* %?"))

(add-to-list 'org-capture-templates
             '("p" "plain" plain
               (here)
               "%?"))

;; (file+headline "templates/reports.org" "Inbox")
