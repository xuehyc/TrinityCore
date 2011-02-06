-- Fix reputation in quest: War at Sea
UPDATE `quest_template` SET
`RewRepFaction1` = '87',`RewRepValue1`  = '-500',        -- Bloodsail Buccaneers
`RewRepFaction2` = '21',`RewRepValue2`  = '250',         -- Booty Bay
`RewRepFaction3` = '577',`RewRepValue3` = '250',        -- Everlook
`RewRepFaction4` = '369',`RewRepValue4` = '500',        -- Gadgetzan
`RewRepFaction5` = '470',`RewRepValue5` = '250'         -- Ratschet
WHERE `quest_template`.`entry` = '9268'; 