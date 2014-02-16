(load-file "~/Downloads/cedet-1.0pre7/common/cedet.el")
(global-ede-mode 1)

;;;; project settings:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(ede-cpp-root-project "Test"
		:name "TestProject"
		:file "/gpfs/main/home/yanli/Desktop/CS195v/old/old_gpusupport/projects/life/Makefile"
		:include-path '("/"
				)
		:system-include-path '("/usr/include"
				       "/usr/local/include")
		:spp-table '(("isUnix" . "")
			     ("BOOST_TEST_DYN_LINK" . "")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(semantic-load-enable-excessive-code-helpers)
;;(semantic-mode 1)
;; load the ecb
(add-to-list 'load-path "~/Downloads/ecb-2.40/")
(load-file "~/Downloads/ecb-2.40/ecb.el")
;; ;; enable prototype help and smart completion 


(setq ecb-tip-of-the-day nil)
(setq ecb-source-path '("/gpfs/main/home/yanli/"))
;; if we activate ECB first time then we display the node "First steps" of
;; the online-manual
(ignore-errors
    (when (null ecb-source-path)
        (let ((ecb-show-help-format 'info))
            (ecb-show-help)
            (Info-goto-node "First steps"))))

;; (semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
;; ;(global-srecode-minor-mode 1)

;(require 'semantic-ia)    
;; ;; GCC settings
;(require 'semantic-gcc)

;; ;; set the color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-blue-sea)
(color-theme-blue-mood)
(color-theme-charcoal-black)
;; ;;

;; ;;  display the line number
(global-linum-mode t)
;; ;;

(require 'setnu)
(setnu-mode t)


(setq truncate-partial-width-windows nil)
(set-scroll-bar-mode nil)

;; show line number and column number
(column-number-mode t)
(line-number-mode t)
(setq inhibit-startup-message t)
(setq search-highlight t)

;; ;; hot key
(global-set-key (kbd "C-,") 'undo)
(global-set-key (kbd "C-.") 'redo)

;; move to the beginning of the line
(global-set-key (kbd "<home>") 'move-beginning-of-line)

;; move to the end of the line
(global-set-key (kbd "<end>") 'move-end-of-line)

(global-set-key (kbd "<kp-5>") 'recentf-open-files) ; numpad5
(global-set-key (kbd "<kp-7>") 'bookmark-bmenu-list)

;; window operation
(global-set-key (kbd "C-<kp-right>") 'shrink-window-horizontally)
(global-set-key (kbd "C-<kp-left>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-<kp-down>") 'enlarge-window)
(global-set-key (kbd "C-<kp-up>") 'shrink-window)

;; window movement
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)

;; comment
(global-set-key (kbd "C-x e") 'comment-region)
;; uncomment
(global-set-key (kbd "C-x w") 'uncomment-region)


;; go to specified line
(global-set-key (kbd "C-x g") 'goto-line)

(setq qt4-base-dir "/usr/include/qt4")
(semantic-add-system-include qt4-base-dir 'c++-mode)
(add-to-list 'auto-mode-alist (cons qt4-base-dir 'c++-mode))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig-dist.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qglobal.h"))

;;name completion
(defun my-cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key (kbd "<f5>") 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c'" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c;" 'semantic-analyze-proto-impl-toggle))
(add-hook 'c-mode-common-hook 'my-cedet-hook)

(defun my-c-mode-cedet-hook ()
 (local-set-key "." 'semantic-complete-self-insert)
 (local-set-key ">" 'semantic-complete-self-insert))
(add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

;; ;; imenu integration
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

;; folding mode
(global-semantic-tag-folding-mode 1)

(global-semantic-mru-bookmark-mode 1)
;; jump to declaration
(defun my-navigation-hook ()
  (local-set-key (kbd "M-<f12>") 'semantic-complete-jump-local)
  (local-set-key (kbd "<f12>") 'semantic-ia-fast-jump)
  (local-set-key (kbd "C-<f12>") 'semantic-complete-jump)
;; where the function is used  
  (local-set-key (kbd "C-c [") 'semantic-symref)
)
(add-hook 'c-mode-common-hook 'my-navigation-hook)

;; set tab width
(setq default-tab-width 4)


;;

  ;; (defadvice show-paren-function
  ;;     (after show-matching-paren-offscreen activate)
  ;;     "If the matching paren is offscreen, show the matching line in the
  ;;       echo area. Has no effect if the character before point is not of
  ;;       the syntax class ')'."
  ;;     (interactive)
  ;;     (let* ((cb (char-before (point)))
  ;;            (matching-text (and cb
  ;;                                (char-equal (char-syntax cb) ?\) )
  ;;                                (blink-matching-open))))
  ;;       (when matching-text (message matching-text))))

;; parenthesis style
(load-file "~/Downloads/cedet-1.0pre7/common/mic-paren.el")
(paren-activate)

;; indent style
 (setq c-default-style "linux"
          c-basic-offset 4)

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                           'fullboth)))
(global-set-key [f11] 'toggle-fullscreen)

(toggle-fullscreen)

;; replace string

(global-set-key (kbd "C-x q") 'replace-string)

(add-to-list 'auto-mode-alist '("\\.cu$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.glsl$" . c-mode))

;; toggle bar
;; (scroll-bar-mode 1)
;;(set-scroll-bar-mode 'right)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-add-path-for-not-matching-files (quote (nil)))
 '(ecb-options-version "2.40"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
