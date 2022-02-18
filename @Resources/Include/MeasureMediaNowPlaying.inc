[MeasureTitle]
Measure=NowPlaying
PlayerName=#playerName#
PlayerType=Title
UpdateDivider=50

[MeasureState]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=State
UpdateDivider=20

[MeasureRating]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Rating
UpdateDivider=50

[MeasureCover]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Cover
CoverPath=#@#images\coverNowPlaying.png
Substitute="":"#@#images\#ImageName#"
UpdateDivider=50

[MeasureTrack]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Title
RegExpSubstitute=1
;; Removes anything with () or []
Substitute="^(?siU)^(.+) (-.*?(#REGEX#).*|(\(.*(#REGEX#)|\[.*(#REGEX#)).+)+$":"\1"
UpdateDivider=50

[MeasureTrackFull]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Title
UpdateDivider=100

[MeasureArtist]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Artist
RegExpSubstitute=1
;; Removes anything followed by a '-' or '&' (except for 'country' and 'free') or 'feat.' or 'and' or ':' or '/'
Substitute="^(?siU)^(.+)((,| -| & (?!\bcountry\b|\bfree\b)| feat.| and| :| \/).+)+$":"\1"
UpdateDivider=50

[MeasureArtistFull]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Artist
UpdateDivider=100

[MeasureProgress]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Progress
UpdateDivider=100

[MeasurePosition]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Position
UpdateDivider=20

[MeasureDuration]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Duration
UpdateDivider=100