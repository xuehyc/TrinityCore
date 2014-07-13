
DELETE FROM `creature_template_addon` WHERE `entry`=36736; 
INSERT INTO `creature_template_addon` (`entry`, `mount`, `bytes1`, `bytes2`, `auras`) VALUES
(36736, 0, 0x0, 0x1, '69174'); -- Invisible Stalker (Icecrown Dungeon Trap) - Reflection Window Beam Visual

DELETE FROM `creature_text` WHERE `entry` IN (30344, 30824, 36954);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextID`) VALUES
-- High Captain Justin Bartlett
(30344, 0, 0, 'FIRE! FIRE!', 14, 0, 100, 0, 0, 16721, 'High Captain Justin Bartlett - Fire', 36993),
(30344, 1, 0, 'Quickly, climb aboard! We mustn''t tarry here! There''s no telling when this whole mountainside will collapse.', 14, 0, 100, 0, 0, 16722, 'High Captain Justin Bartlett - Final', 37213),
-- Sky-Reaver Korm Blackscar
(30824, 0, 0, 'FIRE! FIRE!', 14, 0, 100, 0, 0, 16732, 'Sky-Reaver Korm Blackscar - Fire', 38681),
(30824, 1, 0, 'Get on board, now! This whole mountainside could collapse at any moment.', 14, 0, 100, 0, 0, 16733, 'Sky-Reaver Korm Blackscar - Final', 37212),
-- Lich King
(36954, 0, 0, 'Your allies have arrived, Jaina, just as you promised. You will all become powerful agents of the Scourge..', 14, 0, 100, 0, 0, 17212, 'Lich King SAY_LICH_KING_AGGRO_A', 37172),
(36954, 1, 0, 'I will not make the same mistake again, Sylvanas. This time there will be no escape. You will all serve me in death!', 14, 0, 100, 0, 0, 17213, 'Lich King SAY_LICH_KING_AGGRO_H', 37173),
(36954, 2, 0, 'There is no escape!', 14, 0, 100, 0, 0, 17217, 'Lich King SAY_LICH_KING_WALL_01', 37177),
(36954, 3, 0, 'Succumb to the chill of the grave.', 14, 0, 100, 0, 0, 17218, 'Lich King SAY_LICH_KING_WALL_02', 37175),
(36954, 4, 0, 'Another dead end.', 14, 0, 100, 0, 0, 17219, 'Lich King SAY_LICH_KING_WALL_03', 37176),
(36954, 5, 0, 'How long can you fight it?', 14, 0, 100, 0, 0, 17220, 'Lich King SAY_LICH_KING_WALL_04', 38668),
(36954, 6, 0, 'Arise minions.  Do not let them pass.', 14, 0, 100, 0, 0, 17216, 'Lich King SAY_LICH_KING_GHOUL', 38669),
(36954, 7, 0, 'Minions, sieze them.  Bring their corpses back to me.', 14, 0, 100, 0, 0, 17222, 'Lich King SAY_LICH_KING_ABON', 38670),
(36954, 8, 0, 'Death''s cold embrace awaits.', 14, 0, 100, 0, 0, 17221, 'Lich King SAY_LICH_KING_WINTER', 37174),
(36954, 9, 0, 'Nowhere to run! You''re mine now...', 14, 0, 100, 0, 0, 17223, 'Lich King SAY_LICH_KING_END_DUN', 36994);

DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5605,5740);
INSERT INTO `areatrigger_scripts` (`entry`,`scriptname`) VALUES
(5605, 'at_hor_shadow_throne'),
(5740, 'at_hor_impenetrable_door');

DELETE FROM `areatrigger_teleport` WHERE `id`=5740;
INSERT INTO `areatrigger_teleport` (`id`, `name`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
(5740, 'Halls of Reflection (The Impenetrable Door)', 668, 5354.01, 2053.53, 707.695, 0.7853982);

DELETE FROM `lfg_entrances` WHERE `dungeonId` IN(255,256);
INSERT INTO `lfg_entrances` (`dungeonId`, `name`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(255, 'Halls of Reflection (Normal)', 5239.01, 1932.64, 707.695, 0.800565),
(256, 'Halls of Reflection (Heroic)', 5239.01, 1932.64, 707.695, 0.800565);

-- Lady Jaina Proudmoore
UPDATE `creature_template` SET `ScriptName`='npc_jaina_or_sylvanas_intro_hor' WHERE `entry`=37221;
-- Lady Sylvanas Windrunner
UPDATE `creature_template` SET `ScriptName`='npc_jaina_or_sylvanas_intro_hor' WHERE `entry`=37223;
-- Frostsworn General
UPDATE `creature_template` SET `ScriptName`='npc_frostsworn_general' WHERE `entry`=36723;
-- The Lich King
UPDATE `creature_template` SET `ScriptName`='npc_the_lich_king_escape_hor', `mechanic_immune_mask`=617299839 WHERE `entry` = 36954;
-- Icecrown Dungeon Horde Gunship Cannon
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=37593;

UPDATE `gameobject_template` SET `faction`=2102,`flags`=32 WHERE `entry`=201385;
UPDATE `gameobject_template` SET `faction`=1375,`flags`=32 WHERE `entry` IN (201596,201709,202211);
UPDATE `gameobject_template` SET `flags`=40 WHERE `entry` IN (201598,201599);
UPDATE `gameobject_template` SET `faction`=35,`flags`=16 WHERE `entry` IN (201710,202212,202336,202337);

 -- Lady Jaina Proudmoore
UPDATE `creature_template` SET `spell1`=0, `gossip_menu_id`=10860 WHERE `entry`=36955;
 -- Lady Sylvanas Windrunner
UPDATE `creature_template` SET `gossip_menu_id`=10909 WHERE `entry`=37554;

DELETE FROM `gossip_menu` WHERE `entry`=10931;
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(10931, 15190); -- 37554 -- outro gossip

UPDATE `gossip_menu_option` SET `option_id`=1, `npc_option_npcflag`=1 WHERE `menu_id`=10860 AND `id`=0;

-- skip intro
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup` IN (11031,10950);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(15,11031,1,0,0,14,0,24500,0,0,1,0,0,'','Show options only if quest 24500 taken/complete/rewarded'),
(15,10950,1,0,0,14,0,24802,0,0,1,0,0,'','Show options only if quest 24802 taken/complete/rewarded');

DELETE FROM `spell_script_names` WHERE `spell_id` IN (72900,70190,70017,72368,72369);
INSERT INTO `spell_script_names` (`spell_id` ,`ScriptName`) VALUES
(72900, 'spell_hor_start_halls_of_reflection_quest_ae'),
(70190, 'spell_hor_evasion'),
(70017, 'spell_hor_gunship_cannon_fire'),
(72368, 'spell_marwyn_shared_suffering'),
(72369, 'spell_marwyn_shared_suffering');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry` IN (69857,70199,70021,70246);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13,1,69857,0,0,31,0,3,36954,0,0,0,0,'','Taunt Arthas targets The Lich King'),
(13,2,70199,0,0,31,0,3,36954,0,0,0,0,'','Blinding Retreat targets The Lich King'),
(13,1,70021,0,0,31,0,3,22515,0,0,0,0,'','Gunship Cannon Fire targets World Trigger'),
(13,1,70021,0,0,1,0,70017,0,0,1,0,0,'','Gunship Cannon Fire target not has aura Gunship Cannon Fire'),
(13,1,70246,0,0,31,0,3,22515,0,0,0,0,'','Gunship Cannon Fire targets World Trigger'),
(13,1,70246,0,0,1,0,70017,0,0,1,0,0,'','Gunship Cannon Fire target not has aura Gunship Cannon Fire');

-- Cloak of Darkness proc on dodge
DELETE FROM `spell_proc_event` WHERE `entry`=70188;
INSERT INTO `spell_proc_event` (`entry`,`procEx`) VALUES
(70188,0x10);

DELETE FROM `spelldifficulty_dbc` WHERE `id` IN(72395,72396,72397);
INSERT INTO `spelldifficulty_dbc` (`id`,`spellid0`,`spellid1`) VALUES
(72395,72395,72390), -- Hopelessness
(72396,72396,72391), -- Hopelessness
(72397,72397,72393); -- Hopelessness

DELETE FROM `spell_custom_attr` WHERE `entry` = 74117;
INSERT INTO `spell_custom_attr` (`entry`,`attributes`) VALUES
(74117, 2);
