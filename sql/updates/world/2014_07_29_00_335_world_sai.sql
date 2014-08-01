
DELETE FROM `creature` WHERE `guid` in (49548,49736); -- GUID by ArkDB
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`,  `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(49548, 28355, 0, 1, 1,  -8670.599, 427.4635, 100.9918, 0.9599311, 120, 0, 0), 
(49736, 28347, 0, 1, 1,  -8672.78, 430.8922, 100.9918, 0.6632251, 120, 0, 0); 
