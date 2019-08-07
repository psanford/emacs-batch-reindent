#!/bin/bash

GO_MODE="/home/psanford/projects/go-mode.el/go-mode.el"
EXT=".go"

if [ ! -e "$1" ]; then
  echo "usage: $0 <directory|file>" >&2
  exit 1
fi
printf "$1\n$EXT\n" | emacs --batch -q -l $GO_MODE -l batch-reindent.el -f batch-reindent
