# Corona Tracker

## Config File
This project contains a `Config.plist` file storing information about how to communicate
with the webserver.

To not publish any changes to `Config.plist` accidentally, please run this git command:
```sh
$ git update-index --assume-unchanged Config.plist
```
After this, local changes to `Config.plist` are not recognized by git.
