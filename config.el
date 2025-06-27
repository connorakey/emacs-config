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

;; Bootstrap use-package via straight.el
(straight-use-package 'use-package)

;; Use straight.el by default in use-package
(setq straight-use-package-by-default t)

(require 'use-package)

(use-package evil
  :init
  (setq evil-want-integration t) 
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)  ;; splits on the right
  (setq evil-split-window-below t)   ;; splits on the bottom
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init))

(use-package general
  :config
  (general-evil-setup)

  ;; Set space as the global leader key
  (general-create-definer connor/leader-keys
			  
			  :states '(normal insert visual emacs)
			  :keymaps 'override
			  :prefix "SPC" ;; sets leader
			  :global-prefix "M-SPC") ;; access leader in insert mode

  (connor/leader-keys
   "b" '(:ignore t :wk "buffer") ;; doesn't do anything, just for which key.
   "bb" '(switch-to-buffer :wk "Switch buffer")
   "bk" '(kill-this-buffer :wk "Kill this buffer")
   "bn" '(next-buffer :wk "Next buffer")
   "bp" '(previous-buffer :wk "Previous buffer")
   "br" '(revert-buffer :wk "Reload buffer"))
   

  

)

(set-face-attribute 'default nil
		    :font "JetBrains Mono Nerd Font"
		    :height 110
		    :weight 'medium)
(set-face-attribute 'variable-pitch nil
		    :font "Ubuntu Nerd Font"
		    :height 120
		    :weight 'medium)

;; Make commented text and keywords italic
;; Font must have an italic face avaliable
(set-face-attribute 'font-lock-comment-face nil
		    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
		    :slant 'italic)

;; Make this font the default to all new frames (specifically needed for the emacsserver)
(add-to-list 'default-frame-alist '(font . "JetBrains Mono Nerd Font-11"))
(setq-default line-spacing 0.12)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(use-package which-key
:init
(which-key-mode 1)
:config
(setq which-key-side-window-location 'bottom
      which-key-sort-order #'which-key-key-order-alpha
      which-key-sort-uppercase-first nil
      which-key-add-column-padding 1
      which-key-max-display-columns nil
      which-key-min-display-lines 6
      which-key-side-window-slot -10
      which-key-side-window-max-height 0.25
      which-key-idle-delay 0.8
      which-key-max-description-length 25
      which-key-allow-imprecise-window-fit t
      which-key-separator "  "))
