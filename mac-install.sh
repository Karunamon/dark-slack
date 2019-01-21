#!/bin/bash

# Sanity checks
if [ "$UID" != "0" ]; then
	echo "You must run this script as root. Try running sudo $0"
	exit 126
fi

if [ $(uname) != "Darwin" ]; then
	echo "This script only works with MacOS."
	exit 1
fi

cp -v caiceA.css dark.css /Applications/Slack.app/Contents/Resources

if [ $? != "0" ]; then
	echo "Failed copying CSS into Slack's resource folder"
	exit 2
fi

cat ssb-interop-patch.js >> /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js

if [ $? != "0" ]; then
	echo "Failed patching Slack's javascript"
	exit 2
fi

echo "Done. Restart or refresh Slack (⌘+-r) to see the changes."
exit 0


