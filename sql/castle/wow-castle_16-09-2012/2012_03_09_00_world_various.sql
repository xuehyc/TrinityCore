-- close #216: fix wrong NpcOrGoId1 for Mounting Up
UPDATE quest_template SET RequiredNpcOrGo1=26472 WHERE id=12414 LIMIT 1;

-- close #119: insert missing creature start relationship for portaanus (quel'danas)
DELETE FROM `creature_questrelation` WHERE quest = 11534;
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES (25034, 11534);

-- close #505: grant credit in falcon vs hawk, cast back + despawn
SET @npc := 24747; -- Fjord Falcon
SET @spelltrigger := 44407; -- Hawk Hunting
SET @spell := 44408; -- Hawk Hunting

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@npc;

DELETE FROM `smart_scripts` WHERE `entryorguid` = @npc AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@npc, 0, 0, 1, 8, 0, 100, 1, @spelltrigger, 0, 0, 0, 11, @spell, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fjord Hawk - On Spellhit Grant Fjord Falcon Credit'),
(@npc, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fjord Hawk - Despawn after Quest Credit');

-- fix wrong quest classmask for scourgebane / eadric the pure
UPDATE `quest_template` SET `RequiredClasses` = 32 WHERE `id` = 13795;
UPDATE `quest_template` SET `RequiredClasses` = 1|2|4|8|16|64|128|256|1024 WHERE `id` = 13794;

