# update_discord
A little script to update discord on debian-based systems. Configurable to update automatically before launch.

For basic usage, download it and run it when you want to update discord.
If you wish to be able to easily run `update_discord` as a command that updates discord, move the file with root priveleges to a directory in your PATH. To find out which directories are in your path, run `echo $PATH`. I would recommend /usr/local/bin for custom scripts like these to keep things tidy. Rename it to remove the ".sh" at the end or you'll have to type it every time you want to run the command.

If you wish to have discord automatically update on launch, follow the above instructions, then uncomment the last two lines (remove the # at the start of the line). Now, right-click your desktop, select "create a new launcher here", put "update_discord" as the command, change the name/icon/comment to your liking, and select "yes" when prompted if you wish to add the launcher to the menu. You can also edit the menu entry directly, and/or edit the startup application. For more information, or if you don't see the option "create a new launcher here", I encourage you to look it up.

Extra features: the script will (try to) install Discord if it is not installed. Any command-line arguments are passed through to discord.
