[MeasureTitle]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Title
UpdateDivider=50

[MeasureState]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=State
UpdateDivider=20

[MeasureRating]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Rating
UpdateDivider=50

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
Substitute="^(?siU)^(.+)((,| -| & (?!\bcountry\b|\bfree\b)| feat.| and| :| \/).+)+$":"\1"
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