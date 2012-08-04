DELETE FROM `gameobject` WHERE `id`=202443;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (202443, 571, 1, 1, 5804.72, 640.837, 647.627, 2.46273, 0, 0, 0.942945, 0.332949, 300, 0, 1);

UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=202443;
DELETE FROM `smart_scripts` WHERE `entryorguid` =202443 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`,`action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`,`target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(202443, 1, 0, 0, 62, 0, 100, 0, 11431, 0, 0, 0, 68, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0 ,'On Gossip Select - Play Movie 16');
