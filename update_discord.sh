#! /bin/bash

# Made by Caedorus, forked and amended by Kharakhov.
# This little script compares the version of the currently installed discord to the latest one, then downloads and updates if required.
# If discord is not installed, it will install it.
# Compatible with all systems that install discord from a deb package, use dpkg, and pkexec. This basically means debian and derivatives.
# Note: I forked this build from Caedorus at 2026-02-04 13:00 UTC.

update() {
 OLD_VERSION_UNCLEAN=$(dpkg -s discord | grep '^Version:' || echo "123456789None") # the 9 characters get stripped
 OLD_VERSION=${OLD_VERSION_UNCLEAN:9:8} # strip characters such that we only have the version
 NEW_VERSION_UNCLEAN=$(curl -s https://discord.com/api/updates/stable?platform=linux)
 NEW_VERSION=${NEW_VERSION_UNCLEAN:10:7} # strip characters again for the same reason
 echo "Old version: ${OLD_VERSION}"
 echo "New version: ${NEW_VERSION}"
 if [ "$NEW_VERSION" != "$OLD_VERSION" ] && [ -n "$NEW_VERSION" ] && [ -n "$OLD_VERSION" ]; then # if both variables are defined and not the same
  echo "Updating from $OLD_VERSION to $NEW_VERSION!"
  mkdir -p /tmp/update_discord && pushd /tmp/update_discord # make and go to a temporary directory. pushd ensures we can go back to wherever we used to be
  wget https://discord.com/api/download?platform=linux -O discord_latest.deb || exit 1 # download and fail if the download fails
  echo "Your password is required and will now be prompted for to install this update. To cancel, hit cancel or press Ctrl+C."
  pkexec dpkg -i discord_latest.deb || exit 1 # install and fail if the install fails
  pkexec -k # remove the previous authentication record. Otherwise, a malicous discord could get root access without needing a password.
  echo "Cleaning up..."
  popd # return to the previous directory
  rm -rf /tmp/update_discord # clean the temp directory
 elif [ ! -n "$NEW_VERSION" ] || [ ! -n "$OLD_VERSION" ]; then # if either variable is not defined
  echo "An error occurred!" 
  exit 1
 else # by process of exclusion, this triggers if both variables are defined and the same.
  echo "Already the latest version!"
 fi
}
update
# Uncomment the next 2 lines if you would like discord to start after the update. This turns the script into something that automatically updates discord before launch if needed.
#discord "$@" # "$@" passes command-line arguments, if any, to discord.
#update # this makes sure that if you press the "update" button at the right-top discord will update (since that button literally just closes discord)
