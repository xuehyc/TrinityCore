-- temp. disable invisibility
DELETE FROM `creature_addon` WHERE `guid` = 85057;

-- update creature_templates
UPDATE `creature_template` SET `flags_extra`=2, `npcflag`=2097153, `unit_flags`=770 WHERE `entry` IN (35594,35607);

-- spawn
DELETE FROM `creature` WHERE `id` IN (35594,35607);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`)
VALUES
('85057','35594','571','1','1','28282','0','5931.78','729.095','642.136','3.29716','180','0','0','5342','0','0','0','0','0','0'),
('502329','35607','571','1','1','28282','0','5923.62','723.277','642.136','1.50253','180','0','0','5342','0','0','0','0','0','0');

-- gossip menu
DELETE FROM `gossip_menu_option` WHERE `menu_id`=10656 AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`)
VALUES (10656,0,1,NULL,13,2097152,0,0,0,0,0,NULL);

-- condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10656;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES (15,10656,0,0,7,202,350,0,0,'','steam powered auctioneer - requires engineering 350');
