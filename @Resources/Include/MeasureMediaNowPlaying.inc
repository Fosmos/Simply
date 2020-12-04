[MeasureTitle]
Measure=NowPlaying
PlayerName=#playerName#
PlayerType=Title
UpdateDivider=20

[MeasureState]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=State
UpdateDivider=20

[MeasureRating]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Rating
UpdateDivider=20

[MeasureStateButton]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=State
Substitute="0":"Play","1":"Pause","2":"Play"
UpdateDivider=20

[MeasureCover]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Cover
CoverPath=#@#images\coverNowPlaying.png
Substitute="":"#@#images\#ImageName#"
UpdateDivider=20

[MeasureTrack]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Title
RegExpSubstitute=1
Substitute="^(?siU)^(.+) ((-|\/|(\(|\[).*()).+)+$":"\1"
UpdateDivider=20

[MeasureTrackFull]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Title
UpdateDivider=20

[MeasureArtist]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Artist
RegExpSubstitute=1
Substitute="^(?siU)^(.+) ((-|,|& (?!\bcountry\b|\bfree\b)|feat.|and|:|\/).+)+$":"\1"
UpdateDivider=20

[MeasureArtistFull]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Artist
UpdateDivider=20

[MeasureAlbum]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Album
UpdateDivider=20

[MeasureProgress]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Progress
UpdateDivider=20

[MeasurePosition]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Position
UpdateDivider=20

[MeasureDuration]
Measure=NowPlaying
PlayerName=[MeasureTitle]
PlayerType=Duration
UpdateDivider=20