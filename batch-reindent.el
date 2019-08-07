(defun batch-reindent (path ext)
  "Reindent all files of extention in path"
  (interactive "sPath: \nsExtension: ")
  (let* ((ts)
         (tmp-buffer)
         ;; disable find-file hooks to speed up processing:
         ;; don't run git commands on every file
         (find-file-hook '())
         (files (split-string (shell-command-to-string (format "find %s -name *%s -print0" path ext)) "\0" t)))
    (dolist (f files)
      (message "[%s] %s start" (format-time-string "%Y-%m-%dT%H:%M:%S.%6N") f)
      (setq tmp-buffer (find-file f))
      (setq ts (current-time))
      (with-current-buffer tmp-buffer
        (mark-whole-buffer)
        (ignore-errors
          (indent-region (point-min) (point-max) nil))
        (message "[%s] %s stop took=%0.6f" (format-time-string "%Y-%m-%dT%H:%M:%S.%6N") f (float-time (time-since ts)))
        (save-buffer))
      (kill-buffer tmp-buffer))))
