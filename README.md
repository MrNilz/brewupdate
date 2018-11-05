# brewupdate #

brewupdate is a [launchd agent][launchd] to update [homebrew][homebrew] formulae automatically day at 11 AM (local time).

## How to Install or Upgrade ##
Clone the git repo and run
```shell
brewupdate-install-local.sh
```

### Manual installation ###

To manually install `brewupdate`:

Copy `brewupdate.sh` to your `/usr/local/bin` folder, then the plist to `~/Library/LaunchAgents` and run the command `launchctl load ~/Library/LaunchAgents/net.brewupdate.agent.plist` to load the LaunchAgent into the launchd manager.
Correct the @USERHOME@ folders in '~/Library/LaunchAgents/net.brewupdate.agent.plist'.


## … and where do I see what's updated? ##

When the script runs, it'll show a notification using the [terminal-notifier][terminal-notifier] command-line tool. The logs are being kept inside `$HOME/Library/Logs/Homebrew/brewupdate/brewupdate.log` and errors inside `$HOME/Library/Logs/Homebrew/brewupdate/brewupdate-error.log`. You can change that by editing the `StandardOutPath` and `StandardErrorPath` properties inside the `net.brewupdate.agent.plist` file (don't forget to unload and load after making the changes).

## License

Code is under the [BSD 2-Clause license][license].

[launchd]: http://developer.apple.com/library/mac/#technotes/tn2083/_index.html
[homebrew]: https://github.com/mxcl/homebrew/
[terminal-notifier]: https://github.com/alloy/terminal-notifier
[license]: https://github.com/cgswong/brewupdate/tree/master/LICENSE.txt
