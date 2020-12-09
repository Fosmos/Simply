; I strongly advise touching nothing in here
; Except maybe the font stuff
; Everything else should be changed through the Settings dialog
[Variables]
playerName=Spotify
playerPlugin=Web
playerEXE=%userprofile%\AppData\Roaming\Spotify\Spotify.exe
ImageName=spotify.png
Direction=1
Orientation=Horizontal

; Song Info Variables
FontSmall=0.25
FontLarge=0.35
FontColor=255,255,255,255
FontMain=Ubuntu Medium
FontLight=Ubuntu Light
Justify=Right

; Cover Variables
CoverSize=125
Width=(#CoverSize#*7)
Height=(#CoverSize#)
Origin=(#CoverSize#*6)
CoverOrigin=#Origin#
ImageTint2=[MeasurerBackground]
Background=[MeasureBackground2]
Foreground=[MeasureForeground2]
Chameleon=1

; Heart
likeVal=SetRating 5
noLikeVal=SetRating 0
heartTint=1DB954

SkinGroup=Simply
Config=Simply
Channel=
Port=
ID=
