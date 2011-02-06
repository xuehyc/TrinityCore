-- apply AI
UPDATE `creature_template` SET `ScriptName` = 'npc_quest_12851' WHERE `entry` IN (29358,29351);

-- set some target entrys
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 54798;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) 
VALUES
(13,54798,18,1,29351),
(13,54798,18,1,29358);

-- set quest start script
UPDATE `quest_template` SET `StartScript` = 12851 WHERE `entry` = 12851;

-- add icefang spell
UPDATE `creature_template` SET `spell1` = 54897 WHERE `entry` = 29602;

-- faster mob respawn
UPDATE `creature` SET `spawntimesecs` = 30 WHERE `id` IN (29358,29351);

-- add start script
DELETE FROM `quest_start_scripts` WHERE `id` = 12851;
INSERT INTO `quest_start_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`)
VALUES
(12851,0,15,54768,3,0,0,0,0,0);
