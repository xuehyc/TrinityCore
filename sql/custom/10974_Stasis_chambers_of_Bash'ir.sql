-- Quest(10974)/NPC (22919) Fix

-- Image of Commandant Ameer Quest Flag(22919)
DELETE FROM `creature_template` WHERE entry = '22919';
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`,`difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
`modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`,`gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`,
`npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`,`dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`,
`rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`,`trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`,
`maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`,`pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`,
`resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`,`spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`,
`mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`,`Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`,
`questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`,`RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`,`ScriptName`, `WDBVerified`) VALUES

('22919', '0', '0', '0', '0', '0', '19661', '0', '0', '0', 'Image of Commander Ameer', 'The Protectorate', NULL, '0', '70', '70', '1', '1795', '1795',
 '2', '1.125', '1.14286', '1', '0', '252', '357', '0', '304', '1', '2000', '0', '1', '2', '8', '0', '0', '0', '0', '0', '215', '320', '44', '10', '0',
 '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '0', '3', '1', '1', '1', '0', '0',
 '0', '0', '0', '0', '0', '0', '1', '2256', '0', '0', '', '12340');

-- Image of Commandant Ameer Spawn
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`,`equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`,
`spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`,`DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES

('22919', '530', '1', '1', '0', '2256', '3866.6', '5978.59', '291.792', '3.97902', '300', '0', '0', '6986', '0', '0', '0', '0', '0', '0');

-- Fix Quests Image of Comanndant Ameer (20482)->(22919)
UPDATE `creature_involvedrelation` SET `id` = '22919' WHERE `quest` IN ( '10974', '10975', '10976', '10977', '10981' ,'10982');
UPDATE `creature_questrelation` SET `id` = '22919' WHERE `quest` IN ( '10975', '10976', '10977', '10981' ,'10982'); 

