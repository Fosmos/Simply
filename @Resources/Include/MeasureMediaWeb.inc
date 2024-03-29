[MeasureTitle]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Title
UpdateDivider=50

[MeasureState]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=State
IfCondition=MeasureState = 1
IfTrueAction=[!SetOption MeterPlayPause ImageName "#@#Images\pause.png"][!UpdateMeter MeterPlayPause][!CommandMeasure Animation "Execute 4"][!Redraw]
IfFalseAction=[!SetOption MeterPlayPause ImageName "#@#Images\play.png"][!UpdateMeter MeterPlayPause][!CommandMeasure Animation "Execute 4"][!Redraw]
UpdateDivider=20

[MeasureRating]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Rating
IfCondition=MeasureRating = 0
IfTrueAction=[!SetOption MeterHeart ImageName "#@#Images\heart.png"][!SetOption MeterHeart ImageTint "ffffff"][!SetVariable heartRatingMode "#likeVal#"][!UpdateMeter "MeterHeart"][!Redraw]
IfFalseAction=[!SetOption MeterHeart ImageName "#@#Images\heartFull.png"][!SetOption MeterHeart ImageTint "#heartTint#"][!SetVariable heartRatingMode "#noLikeVal#"][!UpdateMeter "MeterHeart"][!Redraw]
UpdateDivider=1

[MeasureCover]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Cover
CoverPath=#@#images\coverWeb.png
Substitute="":"#@#images\#ImageName#"
UpdateDivider=50

[MeasureTrack]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Title
RegExpSubstitute=1
;; Removes anything with () or []
Substitute="^(?siU)^(.+) (-.*?(#REGEX#).*|(\(.*(#REGEX#)|\[.*(#REGEX#)).+)+$":"\1"
UpdateDivider=50

[MeasureTrackFull]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Title
UpdateDivider=100

[MeasureArtist]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Artist
RegExpSubstitute=1
;; Removes anything followed by a '-' or '&' (except for 'country' and 'free') or 'feat.' or 'and' or ':' or '/'
Substitute="^(?siU)^(.+)((,| -| & (?!\bcountry\b|\bfree\b)| feat.| \band\b| :| \/).+)+$":"\1"
UpdateDivider=50

[MeasureArtistFull]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Artist
UpdateDivider=100

[MeasureProgress]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Progress
UpdateDivider=100

[MeasurePosition]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Position
UpdateDivider=20

[MeasureDuration]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Duration
UpdateDivider=100