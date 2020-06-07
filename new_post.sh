#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Execution requires a single argument" 1>&2
  exit 1
fi

hugo new posts/`date "+%Y-%m-%d"`-${1}.md --editor="code"
