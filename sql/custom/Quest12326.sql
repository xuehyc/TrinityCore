UPDATE creature_template SET spell1 = 49315, spell2 = 49333, spell3 = 49109, spell4 = 49081 WHERE entry = 27587
INSERT INTO spell_area (`spell`,`area`,`autocast`) VALUES (49081,4246,0);
UPDATE creature_template SET flags_extra = flags_extra | 2 WHERE entry = 27607;
UPDATE creature_template SET scriptname = 'npc_7th_legion_siege_engineer' WHERE entry = 27163;
UPDATE creature_template SET scriptname = 'vehicle_alliance_steamtank' WHERE entry IN (27587);
UPDATE `creature_template` SET `unit_flags`=0 WHERE `entry` = 27587;