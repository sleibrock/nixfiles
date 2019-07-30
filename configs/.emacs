;; Emacs bug #34341
;; Using the following setq action until it is resolved
;; https://github.com/bbatsov/prelude/issues/1225#issuecomment-511266025
;; https://debbugs.gnu.org/cgi/bugreport.cgi?bug=34341
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; Standard package.el include/init
(require 'package)
(package-initialize)



(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)


;; new in Emacs 25.1
(defun package--save-selected-packages (&rest opt) nil)

; define initial packages to install for a regular Emacs program
; 
(setq packages
      '(
	; editor related
	evil-visual-mark-mode
	evil-search-highlight-persist
	neotree
	smartparens
	spacemacs-theme
	smex 
	ido-vertical-mode
	rainbow-delimiters
	
	; languages
	markdown-mode
	scribble-mode
	haskell-mode
	go-mode
	rust-mode
	racket-mode
	tuareg     ; ocaml
	ocp-indent ; ocaml indentation plugin
	nim-mode
	))


(defun install-all-packages ()
  "Install all packages from our defined list of custom packages"
  (interactive)
  (package-refresh-contents)
  (mapcar (lambda (p) (package-install p)) packages))

;;;;;; define other configratuions below this comment ;;;;
(column-number-mode t)
(toggle-scroll-bar -1)
(setq backup-directory-alist `(("." . "~/.saves")))

(require 'evil)
(require 'evil-search-highlight-persist)
(evil-mode 1)
(global-evil-search-highlight-persist t)

(require 'smex)
(require 'ido)
(ido-mode 1)
(ido-vertical-mode 1)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

(prefer-coding-system 'utf-8-unix)

(global-set-key (kbd "C-x w") 'whitespace-mode)
(global-set-key (kbd "C-x t") 'neotree-toggle)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'prog-mode-hook #'smartparens-mode)

; any other lang specific requires
(require 'ocp-indent)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages
   (quote
    (nim-mode ocp-indent tuareg haskell-mode evil-search-highlight-persist evil-visual-mark-mode scribble-mode rainbow-delimiters racket-mode rust-mode go-mode ido-vertical-mode smex spacemacs-theme smartparens neotree markdown-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 98 :width normal)))))


; end
