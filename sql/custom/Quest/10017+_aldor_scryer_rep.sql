## Aldor & Scryer repeatable Reputation Quests
SET @aldor      =       932;
SET @scryer     =       934;
#  Aldor
UPDATE `quest_template` SET
`RewRepFaction1` = @aldor,  `RewRepValue1` = '250',
`RewRepFaction2` = @scryer, `RewRepValue2` = '-275'
WHERE `quest_template`.`entry` IN (
                                        10017,          -- Strained Supplies
                                        10019,          -- Strained Supplies #2
                                        10325,          -- Marks of Kil'jaeden
                                        10326,          -- More Marks of Kil'jaeden
                                        10653,          -- Marks of Sargeras (Shatt)
                                        10826,          -- Marks of Sargeras (SMV)
                                        10654,          -- More Marks of Sargeras (Shatt)
                                        10827           -- More Marks of Sargeras (SMV)
                                  );

UPDATE `quest_template` SET
`RewRepFaction1` = @aldor,  `RewRepValue1` = '25',
`RewRepFaction2` = @scryer, `RewRepValue2` = '-27'
WHERE `quest_template`.`entry` IN (
                                        10327,          -- Single Mark of Kil'jaeden
                                        10655,          -- Single Mark of Sargeras (Shatt)
                                        10828           -- Single Mark of Sargeras (SMV)
                                  );

UPDATE `quest_template` SET
`RewRepFaction1` = @aldor,  `RewRepValue1` = '350',
`RewRepFaction2` = @scryer, `RewRepValue2` = '-385'
WHERE `quest_template`.`entry` IN (
                                        10420,          -- A Cleansing Light
                                        10421           -- Fel Armaments
                                  );

#  Scryer
UPDATE `quest_template` SET
`RewRepFaction1` = @aldor,  `RewRepValue1` = '-275',
`RewRepFaction2` = @scryer, `RewRepValue2` = '250'
WHERE `quest_template`.`entry` IN (
                                        10024,          -- Voren'thal's Visions
                                        10025,          -- More Basilisk Eyes
                                        10412,          -- Firewing Signets
                                        10415,          -- More Firewing Signets
                                        10656,          -- Sunfury Signets (Shatt)
                                        10824,          -- Sunfury Signets (SMV)
                                        10658,          -- More Sunfury Signets (Shatt)
                                        10823           -- More Sunfury Signets (SMV)
                                  );

UPDATE `quest_template` SET
`RewRepFaction1` = @aldor,  `RewRepValue1` = '-27',
`RewRepFaction2` = @scryer, `RewRepValue2` = '25'
WHERE `quest_template`.`entry` IN (
                                        10414,          -- Single Firewing Signet
                                        10659,          -- Single Sunfury Signet (Shatt)
                                        10822           -- Single Sunfury Signet (SMV)
                                  );

UPDATE `quest_template` SET
`RewRepFaction1` = @aldor,  `RewRepValue1` = '-385',
`RewRepFaction2` = @scryer, `RewRepValue2` = '350'
WHERE `quest_template`.`entry` IN (
                                        10416,          -- Synthesis of Power
                                        10419           -- Arcane Tomes
                                  );
