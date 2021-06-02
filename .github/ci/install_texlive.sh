#!/bin/bash

set -e

# Change default package repository
export REPO=https://mirrors.rit.edu/CTAN/systems/texlive/tlnet

# See if there is a cached version of TeX Live available
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
echo "/tmp/texlive/bin/x86_64-linux" >> $GITHUB_PATH

if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  wget $REPO/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-20*

  # Install a minimal system
  ./install-tl --profile ../.github/ci/texlive-ubuntu.profile --repository $REPO
  cd ..
else
  # Update TeX Live install but add nothing new
  tlmgr update --self --all --no-auto-install
fi

# Install TeX Live packages
tlmgr install           \
  algorithm2e           \
  alphalph              \
  biber                 \
  biblatex              \
  biblatex-gb7714-2015  \
  booktabs              \
  caption               \
  chngcntr              \
  cjk                   \
  ctex                  \
  dirtree               \
  enumitem              \
  environ               \
  eso-pic               \
  etoolbox              \
  everysel              \
  fandol                \
  filehook              \
  fontspec              \
  footmisc              \
  hologo                \
  ifoddpage             \
  latexmk               \
  listings              \
  logreq                \
  multirow              \
  newtx                 \
  ntheorem              \
  pageslts              \
  pdflscape             \
  pdfpages              \
  pgf                   \
  physics               \
  relsize               \
  silence               \
  siunitx               \
  tex-gyre              \
  threeparttable        \
  threeparttablex       \
  tocloft               \
  translator            \
  trimspaces            \
  txfonts               \
  undolabl              \
  xcolor                \
  xecjk                 \
  xetex                 \
  xkeyval               \
  xstring               \
  zhnumber