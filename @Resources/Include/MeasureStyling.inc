[MeasureGetCoverColor]
Measure=Plugin
Plugin=Chameleon
Type=File
Path=[MeasureCover]
UpdateDivider=50

[MeasureCoverAvrg]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Average
UpdateDivider=50

[MeasureCoverBG1]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Background1
UpdateDivider=50

[MeasureCoverBG2]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Background2
UpdateDivider=50

[MeasureCoverFG1]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Foreground1
UpdateDivider=50

[MeasureCoverFG2]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureGetCoverColor
Format=Dec
Color=Foreground2
UpdateDivider=50

; Desktop
[MeasureDesktopColor]
Measure=Plugin
Plugin=Chameleon
Type=Desktop
UpdateDivider=100

[MeasureDesktopAvrg]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureDesktopColor
Format=Dec
Color=Average
UpdateDivider=100

[MeasureDesktopFG1]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureDesktopColor
Format=Dec
Color=Foreground1
UpdateDivider=100

[MeasureDesktopFG2]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureDesktopColor
Format=Dec
Color=Foreground2
UpdateDivider=100

[MeasureDesktopBG1]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureDesktopColor
Format=Dec
Color=Background1
UpdateDivider=100

[MeasureDesktopBG2]
Measure=Plugin
Plugin=Chameleon
Parent=MeasureDesktopColor
Format=Dec
Color=Background2
UpdateDivider=100