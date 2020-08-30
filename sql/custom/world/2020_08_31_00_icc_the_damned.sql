/*
 * npc = `The Damned`
 * Add waypoint for three NPCs
 * Add `Bone Flurry` and `Shattered Bones` spells cast
*/

UPDATE `creature` SET `position_x` = -170.463, `position_y` = 2211.51, `position_z` = 35.2344, `orientation` = 0.0573 WHERE `guid` IN(86243, 201146);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 201107;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 37011;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 37011) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(37011, 0, 0, 0, 6, 0, 100, 1, 0, 0, 0, 0, 0, 11, 70961, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Damned - On Just Died - Cast \'Shattered Bones\' (No Repeat)'),
(37011, 0, 1, 0, 2, 0, 100, 0, 1, 30, 15000, 20000, 0, 11, 70960, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'The Damned - Between 1-30% Health - Cast \'Bone Flurry\''),
(37011, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 39, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Damned - On Aggro - Call For Help'),
(37011, 0, 3, 0, 1, 0, 100, 0, 1000, 1000, 60000, 60000, 0, 49, 0, 0, 0, 0, 0, 0, 25, 8, 0, 0, 0, 0, 0, 0, 0, 'The Damned - Out of Combat - Start Attacking');

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (201107);
INSERT INTO `creature_formations`(`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(201107, 201107, 0, 0, 515, 0, 0),
(201107, 86243, 4, 90, 515, 1, 2),
(201107, 201146, 4, 270, 515, 1, 2);

DELETE FROM `creature_addon` WHERE `guid` IN (201107);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`) VALUES
(201107, 3701100, 0, 0, 1, 0);

DELETE FROM `waypoint_data` WHERE `id` = 3701100;
INSERT INTO `waypoint_data`(`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(3701100, 1, -175, 2190, 35.5, 0, 0, 1, 0, 100, 0),
(3701100, 2, -175, 2240, 35.5, 0, 0, 1, 0, 100, 0);
