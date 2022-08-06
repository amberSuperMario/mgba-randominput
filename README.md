# mgba-randominput
A simple Lua script for [mGBA](https://mgba.io/) to input random button presses automatically. The script will wait a random number of frames (1-60 by default), press a random button, hold it for a random number of frames (1-180 by default), release the button, and then start the whole process over.

Requires a development build of mGBA (v0.10 or higher). Currently excludes Select, L, and R, because I'm using it for Pokemon Emerald, and that made for a smoother experience.

You only need one of the two included scripts. randominput-smarter.lua seperates the D-pad from other buttons so that the script can push a random direction and a random face button at the same time, and also has a lowered chance of pressing Start to help keep the script from spamming pauses. randominput.lua will simply press a single random button regardless of type and does not try to lower the odds of pressing Start.
