;; Copyright (c) 2014, Paul Heymann
;; All rights reserved.

;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are met: 

;; 1. Redistributions of source code must retain the above copyright notice, this
;;    list of conditions and the following disclaimer. 
;; 2. Redistributions in binary form must reproduce the above copyright notice,
;;    this list of conditions and the following disclaimer in the documentation
;;    and/or other materials provided with the distribution. 

;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
;; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
;; DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
;; ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
;; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
;; ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

; todo yasnipper
; todo python flymake
; todo sql

(load-theme 'zenburn t)

(require 'ess-site)

(when (eq system-type 'darwin)
  ;; default Latin font (e.g. Consolas)
  (set-face-attribute 'default nil :family "Inconsolata")
  ;; default font size (point * 10)
  ;;
  ;; WARNING!  Depending on the default font,
  ;; if the size is not supported very well, the frame will be clipped
  ;; so that the beginning of the buffer may not be visible correctly.
  ;; (set-face-attribute 'default nil :height 165)
  ;; use specific font for Korean charset.
  ;; if you want to use different font size for specific charset,
  ;; add :size POINT-SIZE in the font-spec.
  ;; (set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding"))
  ;; you may want to add different for other charset in this way.
  )


;; display only tails of lines longer than 80 columns, tabs and
;; trailing whitespaces
(setq whitespace-line-column 79
      whitespace-style '(face tabs trailing lines-tail))

;; face for long lines' tails
(set-face-attribute 'whitespace-line nil
                    :background "red1"
                    :foreground "yellow"
                    :weight 'bold)

;; face for Tabs
(set-face-attribute 'whitespace-tab nil
                    :background "red1"
                    :foreground "yellow"
                    :weight 'bold)

;; activate minor whitespace mode when in python mode
(add-hook 'python-mode-hook 'whitespace-mode)


(tool-bar-mode 0)
(scroll-bar-mode -1)
(setq-default indent-tabs-mode nil)
(global-set-key "\C-o" 'other-window)

(ido-mode) ; turn on ido for file buffer completion
(cua-mode) ; turn on cua for reasonable cut and paste
(global-font-lock-mode t) ; make syntax highlighting dependent on syntax
(setq column-number-mode t) ; show column numbers
(setq visible-bell t) ; NO sound
(setq fill-column 80)

(setq scroll-conservatively 10
      scroll-margin          5
      scroll-preserve-screen-position t
      scroll-step            1) ; "normal" scrolling

(require 'paren) ; highlight corresponding parens
(show-paren-mode 1) ; highlight corresponding parens

(global-set-key "\M-g" 'goto-line) ; fix meta-g to be goto line

(fset 'yes-or-no-p 'y-or-n-p) ;; Make all "yes or no" prompts show "y or n" instead

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'remember-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'turn-on-auto-fill)

(display-time) ; Display clock
(setq default-major-mode 'text-mode) ; Open unidentified files in text mode

(setq user-full-name "FIX FIX") ; set user info
(setq user-login-name "FIX") ; set user info
(setq user-mail-address "fix@fix.com") ; set user info

(add-hook 'window-configuration-change-hook
	  (lambda ()
	    (setq frame-title-format
		  (concat
		   invocation-name "@" system-name ": "
		   (replace-regexp-in-string
		    (concat "/Users/" user-login-name) "~"
		    (or buffer-file-name "%b"))))))

(global-set-key [prior] 'pager-page-up)
(global-set-key [next] 'pager-page-down)
(global-set-key [M-up] 'pager-row-up)
(global-set-key [M-down] 'pager-row-down)

(setq x-select-enable-clipboard t)

(add-hook 'after-init-hook #'(lambda () (load "paul-org-remember.el")))

; for ispell:
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))

(global-set-key [f12] 'toggle-fullscreen)
