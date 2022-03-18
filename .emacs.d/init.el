;;; init.el --- Configuration -*- lexical-binding: t -*-



;;; -- User interface

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'user-interface)
(require 'keybindings)


;;; -- Yasnippet

(use-package yasnippet
  :straight t
  :defer 3
  :config
  (let ((inhibit-message t))
    (yas-global-mode)))



;;; -- Company

(use-package company
  :straight t
  :init
  (global-company-mode))



;;; -- LSP

(use-package lsp-mode
  :straight t)



;;; -- LSP-Pyright
(use-package lsp-pyright
  :straight t)



;;; -- Vertico

(use-package vertico
  :straight t
  :init
  (vertico-mode))



;;; -- Orderless

(use-package orderless
  :straight t
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))



;;; -- Marginalia

(use-package marginalia
  :straight t
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))



;;; -- Shell-pop

(use-package shell-pop
  :straight t
  :config
  (setq shell-pop-autocd-to-working-dir t))




;;; init.el ends here
