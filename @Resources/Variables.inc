; I strongly advise touching nothing in here
; Except maybe the font stuff
; Everything else should be changed through the Settings dialog
[Variables]
; To add a custom font, drop the .ttf file in @Resources\Fonts\
FontMain=Ubuntu Medium
FontLight=Ubuntu Light
Justify=Right
; Customize what you want cutout of the track name
; e.g., Say the track name is "To the Moon and Back (Feat. Gustave)"
; Having 'Feat' in this list will cut the name to just "To the Moon and Back"
; This is still in development, so it's not perfect
REGEX="From|Feat|Acoustic Version|EP|With|Album Version|Writing Session|Medley|Single|Take|Solo|\+"

; ---------------------
; --- DON'T TOUCH!! ---
; ---------------------

; Song Info Variables
FontSmall=0.25
FontLarge=0.35
TextColor=0,0,0,255
Tooltips=0
ArtistToolTip=
TrackToolTip=

; Auto-set through the settings
playerName=Spotify
playerPlugin=Web
playerEXE=%userprofile%\AppData\Roaming\Spotify\Spotify.exe
ImageName=spotify.png
Direction=1
Orientation=Horizontal
AutoHide=1

; Cover Variables (Auto-set in settings)
CoverSize=125
Width=(#CoverSize#*7)
Height=(#CoverSize#)
Origin=(#CoverSize#*6)
CoverOrigin=#Origin#
Background=[MeasureBackground]
Foreground=[MeasureForeground]
DefaultColors=1

; Heart
likeVal=SetRating 5
noLikeVal=SetRating 0
heartTint=1DB954

SkinGroup=Simply
Config=Simply

; Colors
Color1=255,255,255,255
Color1Chameleon=0
Color2=255,255,255,255
Color2Chameleon=0
Color3=[MeasureCoverBG2]
Color3Chameleon=1
Color4=[MeasureCoverFG2]
Color4Chameleon=1
