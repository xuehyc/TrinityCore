-- spawn mole machine console at brd entrance
DELETE FROM `gameobject` WHERE `id` = 188498;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`)
VALUES
('188498','230','1','1','436.934','16.7189','-70.956','4.55729','0','0','0.759762','-0.650201','300','0','1');


-- limit spawn to brewfest
DELETE FROM `game_event_gameobject` WHERE `guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` = 188498);
INSERT INTO `game_event_gameobject` (`guid`, `event`) 
VALUES
((SELECT `guid` FROM `gameobject` WHERE `id` = 188498), 26);


-- spawn coren direbrew, questgivers
DELETE FROM `creature` WHERE `id` IN (23872,26719,27584,28329);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`)
VALUES
('23872','230','1','1','0','0','890.931','-130.817','-49.7464','5.22232','20','0','0','302400','0','0','0'),
('26719','230','1','1','0','0','885.068','-160.315','-49.7594','2.14591','300','0','0','2614','0','0','0'),
('27584','0','1','1','21849','0','-5138.6','-616.636','397.767','2.41067','300','0','0','4050','0','0','0'),
('28329','1','1','1','0','0','1207.08','-4273.46','21.1918','4.32346','300','0','0','4050','0','0','0');


-- limit to brewfest
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (23872,26719,27584,28329));
INSERT INTO `game_event_creature` (`guid`, `event`) 
VALUES
((SELECT `guid` FROM `creature` WHERE `id` = 23872), 26),
((SELECT `guid` FROM `creature` WHERE `id` = 26719), 26),
((SELECT `guid` FROM `creature` WHERE `id` = 27584), 26),
((SELECT `guid` FROM `creature` WHERE `id` = 28329), 26);


-- set scriptnames
UPDATE `creature_template` SET `ScriptName` = 'npc_coren_direbrew', `flags_extra` = 0, `dmg_multiplier` = 20, `lootid` = 23872 WHERE `entry` = 23872;
UPDATE `creature_template` SET `ScriptName` = 'npc_brewmaiden' WHERE `entry` IN (26822,26764);
UPDATE `creature_template` SET `faction_A` = 736, `faction_H` = 736 WHERE `entry` = 26776;
UPDATE `gameobject_template` SET `ScriptName` = 'go_mole_machine_console' WHERE `entry` = 188498;


-- set some cast targets
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (47344, 47310);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) 
VALUES
(13, 47310, 18, 1, 0),                                 -- cast disarm as aoe
(13, 47344, 18, 1, 26764), (13, 47344, 18, 1, 26822);  -- select one of the barmaiden as target for "Request Second Mug"


-- spell scripts
DELETE FROM `spell_scripts` WHERE `id` IN (47344,49466);
INSERT INTO `spell_scripts` (`id`, `effIndex`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) 
VALUES 
(47344, 0, 0, 15, 47339, 3, 0, 0, 0, 0, 0), -- cast back "Send Second Mug" on "Request Second Mug" hit
(49466, 1, 0, 6, 230, 0, 0, 872.789, -156.874, -49, 0.462); -- port to grim guzzler (remote)
  

-- linked spell to remove auras when drinking brew
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 47371;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) 
VALUES
(47371, -47376, 1, 'Remove Visual Buff'),
(47371, -47331, 1, 'Remove Has Brew Aura');


-- coren direbrew loot
DELETE FROM `creature_loot_template` where `entry` = 23872;
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`)
VALUES
( '23872', '49078', '0', '1', '1', '1', '1' ), -- Ancient Pickled Egg, mode: Outdoor/Dungeon
( '23872', '49080', '0', '1', '1', '1', '1' ), -- Brawler''s Souvenir, mode: Outdoor/Dungeon
( '23872', '49074', '0', '1', '1', '1', '1' ), -- Coren''s Chromium Coaster, mode: Outdoor/Dungeon
( '23872', '49076', '0', '1', '1', '1', '1' ), -- Mithril Pocketwatch, mode: Outdoor/Dungeon
( '23872', '49116', '0', '1', '1', '1', '1' ), -- Bitter Balebrew Charm, mode: Outdoor/Dungeon
( '23872', '49118', '0', '1', '1', '1', '1' ), -- Bubbling Brightbrew Charm, mode: Outdoor/Dungeon
( '23872', '38280', '100', '1', '0', '1', '1' ), -- Direbrew''s Dire Brew, Quest item, mode: Outdoor/Dungeon
( '23872', '49120', '4', '1', '0', '1', '1' ), -- Direbrew''s Bloody Shanker, mode: Outdoor/Dungeon
( '23872', '37863', '4', '1', '0', '1', '1' ), -- Direbrew''s Remote, mode: Outdoor/Dungeon
( '23872', '38281', '100', '1', '0', '1', '1' ), -- Direbrew''s Dire Brew, Quest item, mode: Outdoor/Dungeon
( '23872', '37828', '2', '1', '0', '1', '1' ), -- Great Brewfest Kodo, mode: Outdoor/Dungeon
( '23872', '33977', '2', '1', '0', '1', '1' ); -- Swift Brewfest Ram, mode: Outdoor/Dungeon


--coren direbrew & brewmaiden immunitys
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|8|16|32|64|128|256|512|1024|2048|4096|8192|65536|131072|524288|4194304|8388608|33554432|67108864|536870912 WHERE `entry` IN (23872,26822,26764);
