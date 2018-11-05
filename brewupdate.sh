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
# ############################################################################

set -e

echo "----- Starting new run $(date) ------"
brew update
brew cleanup
brew doctor

OUTDATED=$(brew outdated --json=v1 | jq 'select(.[].pinned != true)')

if [ "$OUTDATED" ]; then
  terminal-notifier -title 'Homebrew' -message 'Packages need upgrade...'
fi

echo "----- Finished run $(date) ------"
