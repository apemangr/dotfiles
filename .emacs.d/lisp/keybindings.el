;;; keybindings.el -*- lexical-binding: t -*-



(setq evil-want-keybinding nil)

;;; -- EVIL-mode


(use-package evil
  :straight t
  :config
  (evil-mode 1)
  (setq evil-want-keybinding nil))



;;; --EVIL-collection

(use-package evil-collection
  :straight t)



;;; -- Key-Chord

(use-package key-chord
  :straight t
  :config
  (setq key-chord-two-keys-delay 0.5)
  (key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
  (key-chord-mode 1))

(evil-set-leader 'normal (kbd "SPC") t)
(define-key evil-normal-state-map (kbd "<localleader>e") 'find-file)
(define-key evil-normal-state-map (kbd "<localleader>s") 'save-buffer)
(define-key evil-normal-state-map (kbd "<localleader>b") 'switch-to-buffer)
(define-key evil-normal-state-map (kbd "<localleader>t") 'shell-pop)


(provide 'keybindings)
