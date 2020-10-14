[MeasureState]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=State
UpdateDivider=20

[MeasureTitle]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Title
Substitute="":"nothing"
UpdateDivider=20

[MeasureRating]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Rating
UpdateDivider=20

[MeasureStateButton]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=State
Substitute="0":"Play","1":"Pause","2":"Play"
UpdateDivider=20

[MeasureCover]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Cover
CoverPath=#@#images\coverGPMDP.png
Substitute="":"#@#images\gpmdp.png"

[MeasureArtist]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Artist
RegExpSubstitute=1
;; Removes anything followed by a '-' or '&' (except for 'country' and 'free') or 'feat.' or 'and' or ':' or '/'
Substitute="^(?siU)^(.+)((,| -| & (?!\bcountry\b|\bfree\b)| feat.| and| :| \/).+)+$":"\1"
UpdateDivider=20

[MeasureArtistFull]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Artist
UpdateDivider=20

[MeasureAlbum]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Album
UpdateDivider=20

[MeasureTrack]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Title
RegExpSubstitute=1
;; Removes anything following a: '-' or anything in between () or [] with 'mix','with','feat','ft','from','version','track','live','unplugged','acoustic','bootleg','demo','cover','theme','remaster','as heard','w\'
;Substitute="^(?siU)^(.+) (-.+|((\(|\[).*(mix|with|feat|ft|from|version|track|live|unplugged|acoustic|bootleg|demo|cover|theme|remaster|as heard|w\/).+))+$":"\1"
;; Removes anything with () or [] or anythging following a , - or /
Substitute="^(?siU)^(.+) ((-|\/|(\(|\[).*()).+)+$":"\1"
UpdateDivider=20

[MeasureTrackFull]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Title
UpdateDivider=20

[MeasureProgress]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Progress
UpdateDivider=20

[MeasureDuration]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Duration
UpdateDivider=20

[MeasurePosition]
Measure=Plugin
Plugin=GPMDPPlugin
PlayerInfo=Position
UpdateDivider=20