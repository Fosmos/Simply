[MeasureTitle]
Measure=Plugin
Plugin=MediaPlayer
PlayerType=Title
UpdateDivider=50

[MeasureCover]
Measure=Plugin
Plugin=MediaPlayer
PlayerType=Cover
Substitute="":"#@#Images\wmp.png"
UpdateDivider=1

[MeasureState]
Measure=Plugin
Plugin=MediaPlayer
PlayerType=State
IfCondition=MeasureState = 1
IfTrueAction=[!SetOption MeterPlayPause ImageName "#@#Images\pause.png"][!UpdateMeter MeterPlayPause][!CommandMeasure Animation "Execute 4"][!Redraw]
IfFalseAction=[!SetOption MeterPlayPause ImageName "#@#Images\play.png"][!UpdateMeter MeterPlayPause][!CommandMeasure Animation "Execute 4"][!Redraw]
UpdateDivider=1

[MeasureRating]
Measure=Plugin
Plugin=MediaPlayer
PlayerType=Rating
IfCondition=MeasureRating = 0
IfTrueAction=[!SetOption MeterHeart ImageName "#@#Images\heart.png"][!SetOption MeterHeart ImageTint "ffffff"][!SetVariable heartRatingMode "#likeVal#"][!UpdateMeter "MeterHeart"][!Redraw]
IfFalseAction=[!SetOption MeterHeart ImageName "#@#Images\heartFull.png"][!SetOption MeterHeart ImageTint "#heartTint#"][!SetVariable heartRatingMode "#noLikeVal#"][!UpdateMeter "MeterHeart"][!Redraw]
UpdateDivider=1

[MeasureArtist]
Measure=Plugin
Plugin=MediaPlayer
PlayerType=Artist
RegExpSubstitute=1
;; Removes anything followed by a '-' or '&' (except for 'country' and 'free') or 'feat.' or 'and' or ':' or '/'
Substitute="^(?siU)^(.+)((,| -| & (?!\bcountry\b|\bfree\b)| feat.| \band\b| :| \/).+)+$":"\1"
UpdateDivider=1

[MeasureTrack]
Measure=Plugin
Plugin=MediaPlayer
PlayerType=Title
OnChangeAction=[!UpdateMeterGroup SongCover][!Redraw]
RegExpSubstitute=1
; Removes anything with () or []
Substitute="^(?siU)^(.+) (-.*?(#REGEX#).*|(\(.*(#REGEX#)|\[.*(#REGEX#)).+)+$":"\1"
UpdateDivider=1

[MeasureProgress]
Measure=Plugin
Plugin=MediaPlayer
PlayerType=Progress
UpdateDivider=1

[MeasurePosition]
Measure=Plugin
Plugin=MediaPlayer
PlayerType=Position
UpdateDivider=1

[MeasureDuration]
Measure=Plugin
Plugin=MediaPlayer
PlayerType=Duration
UpdateDivider=1


