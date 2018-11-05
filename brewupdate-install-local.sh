#!/bin/bash
# ############################################################################
# NAME: brewupdate-install.sh
# DESC: Script to setup launchd process to update, upgrade and check (doctor)
#       for brew.
#
# LOG:
# yyyy/mm/dd [user] [version]: [notes]
# 2014/10/15 cgwong v0.1.0: Initial creation from https://github.com/mkalmes/brewupdate/blob/develop/brewupdate-install.sh
# 2015/01/07 cgwong v0.2.0: Added check for successful load.
# 2018/11/05 mrnilz v0.3.0: install local files instead of remote one
# ############################################################################

set -e

UPDATE_SCRIPT="/usr/local/bin/brewupdate.sh"
AGENTS="$HOME/Library/LaunchAgents"
PLIST="$AGENTS/net.brewupdate.agent.plist"


[ -f "$PLIST" ] && launchctl unload "$PLIST"

if [ "$1" == "uninstall" ]; then
  rm -f "$PLIST" "$UPDATE_SCRIPT"
  if [ $? -eq 0 ]; then
    echo "Unloaded brewupdate."
    exit 0
  else
    echo "Failed unloading brewupdate!!"
    exit 1
  fi
fi

cp brewupdate.sh /usr/local/bin
cp net.brewupdate.agent.plist $HOME/Library/LaunchAgents
## add StandardOutPath and StandardErrorPath to plist
sed -i '' -e "s|@USERHOME@|$HOME|g" "$PLIST"

[ -f "$PLIST" ] && launchctl load "$PLIST"
if [ $? -eq 0 ]; then
  echo "Loaded brewupdate."
else
  echo "Failed loading brewupdate!!"
  exit 1
fi

brew install terminal-notifier
echo "Installed terminal-notifier."

brew install jq
echo "Installed jq."

## create log folder
mkdir -p $HOME/Library/Logs/Homebrew/brewupdate

exit 0
