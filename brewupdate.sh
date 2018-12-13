#!/bin/bash
# ############################################################################
# NAME: brewupdate.sh
# DESC: Script to update, upgrade and check (doctor) Homebrew.
#
# LOG:
# yyyy/mm/dd [user] [version]: [notes]
# 2014/10/15 cgwong v0.1.0: Initial creation.
# 2015/01/04 cgwong v0.1.1: Added cask commands.
#                           Removed logging, corrected getting name from path.
# 2015/01/07 cgwong v0.1.2: Commented unneeded lines.
# 2015/01/20 cgwong v0.1.3: Added terminal output for verbose execution.
# 2018/11/05 mrnilz v0.1.4: Only notify of updates
# 2018/11/26 mrnilz v0.1.5: Add notifier for script errors
# 2018/12/10 mrnilz v0.1.6: Add mention outdated in notifier and debug-echo-output msg
# ############################################################################

set -e

function msg() {
  terminal-notifier -title 'Homebrew' -message "$1"
}

trap 'msg "Error Occured during Homebrew check for update. On line $LINENO"' ERR


echo "----- Starting new run of brewupdate $(date) ------"

brew update
brew cleanup
brew doctor

OUTDATED_BREW=$(brew outdated --json=v1 | jq '.[] | select(.pinned != true)')

if [ "$OUTDATED_BREW" ]; then
  MSG_BREW="Package(s) \"$(echo $OUTDATED_BREW | jq .name | xargs )\" need upgrade..."
  echo "$MSG_BREW"
  msg "$MSG_BREW"
fi

OUTDATED_CASK=$(brew cask outdated)

if [ "$OUTDATED_CASK" ]; then
  MSG_CASK="Cask(s) \"$OUTDATED_CASK\" need upgrade..."
  echo "$MSG_CASK"
  msg "$MSG_CASK"
fi

echo "----- Finished run of brewupdate $(date) ------"
