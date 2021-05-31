#!/usr/bin/env bash

set -e

# OSX GUI apps do not pick up environment variables the same way as Terminal apps and there are no easy solutions,
# especially as Apple changes the GUI app behavior every release (see https://stackoverflow.com/q/135688/483528). As a
# workaround to allow GitHub Desktop to work, add this (hopefully harmless) setting here.

if ! [ -x "$(command -v tflint)" ]; then
  mkdir ~/bin
  cd ~/bin
  wget https://github.com/terraform-linters/tflint/releases/download/v0.20.3/tflint_linux_amd64.zip
  unzip tflint_linux_amd64.zip
fi
export PATH=$PATH:/usr/local/bin:~/bin

for file in "`echo $@ | grep -Ev 'modules|common'`"; do
  tflint $file --deep
done
