[MeasureState]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=State

[MeasureTitle]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Title
UpdateDivider=20

[MeasureRating]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Rating
UpdateDivider=20

[MeasureStateButton]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=State
Substitute="0":"Play","1":"Pause","2":"Play"
UpdateDivider=20

[MeasureTrack]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Title
RegExpSubstitute=1
;; Removes anything with () or [] 
Substitute="^(?siU)^(.+) (-.*?(#REGEX#).*|(\(.*(#REGEX#)|\[.*(#REGEX#)).+)+$":"\1"
UpdateDivider=20

[MeasureTrackFull]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Title
UpdateDivider=20

[MeasureArtist]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Artist
RegExpSubstitute=1
;; Removes anything followed by a '-' or '&' (except for 'country' and 'free') or 'feat.' or 'and' or ':' or '/'
Substitute="^(?siU)^(.+)((,| -| & (?!\bcountry\b|\bfree\b)| feat.| and| :| \/).+)+$":"\1"
UpdateDivider=20

[MeasureArtistFull]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Artist
UpdateDivider=20

[MeasureCover]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Cover
CoverPath=#@#images\coverWeb.png
Substitute="":"#@#images\#ImageName#"
UpdateDivider=20

[MeasureProgress]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Progress
UpdateDivider=20

[MeasurePosition]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Position
UpdateDivider=20

[MeasureDuration]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Duration
UpdateDivider=20

[MeasurePlayer]
Measure=Plugin
Plugin=WebNowPlaying
PlayerType=Player
UpdateDivider=20