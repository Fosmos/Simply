# Simply
A simple media player built from the ground up using ideas found in many other skins:
  - SpotiPlayer (https://www.deviantart.com/cybergen49/art/SpotiPlayer-for-Rainmeter-813654412)
  - TrapNationVis 2.0 (https://github.com/Fosmos/TrapNationVis)
  - ClearText (https://www.deviantart.com/redsaph/art/Cleartext-for-Rainmeter-519796161)
  - Interactive Dock 1.0 (https://www.deviantart.com/not-finch/art/Interactive-Dock-for-Rainmeter-772713805)
 
![](https://i.ibb.co/HVRWSqL/player.png)

## Quick Start
* Once installed (https://github.com/Fosmos/Simply/releases) run the Cover skin
* Right-Click the skin and select 'Settings'
* When you are satisfied with the settings select 'Apply' and your changes should be reflected
  - Chameleon Colors is currently in development so you can't change it's status
  - 'Spotify' uses the WebNowPlaying plugin and will only work with spotify open in a browser or using the .exe desktop app (more on this further down)
* That's it, everything should be working now 😄
## Features
* Supports multiple media players
* Album cover slides into view when hovering over skin
* Progress bar (Colors match album cover)
* Media controls
* Ability to 💚 songs

![](https://i.ibb.co/yknzsGG/player-animated.gif)

## Supported Players
* Google Music Desktop Player (aka → GPMDP)
  - Fully supported and tested
* iTunes (only tested on store app version)
  - Supports everything but the 'heart' feature
* Windows Media Player (aka → WMP)
  - Should be supported but untested
* Web
  - Requires rainmeter extension on Chrome and Edge (Chromium) (https://chrome.google.com/webstore/detail/webnowplaying-companion/jfakgfcdgpghbbefmdfjkbdlibjgnbli)
  - Should be fully supported but heart feature untested
* Spotify (NowPlaying)
  - Only Supports: Artist Name, Track Name, Play, Pause, Next and Previous
* Spotify (WebNowPlaying)
  - This should work right out of the box with spotify loaded in a browser that has the rainmeter plugin (see Web for more detail)
  - If using the .exe (not the store app) following this guide: https://github.com/marcopixel/Monstercat-Visualizer/wiki/WebNowPlaying-Spotify
  - Once above steps are completed, player is fully supported

More media players will be added as needed (let me know if you want one added)
## What Not To Touch
* You shouldn't have to touch anything in the Variables folder and most of the setting get overidden by the settings window anyway
* Don't mess with the @Resources folder. Seriously. Everything is finely tuned even down to the image sizes
