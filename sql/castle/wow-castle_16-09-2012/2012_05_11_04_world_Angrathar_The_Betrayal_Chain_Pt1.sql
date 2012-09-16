-- Step 1: Change quest relations so that "The Betrayal" part cannot be taken before the quest-chain parts.
UPDATE `quest_template` SET `NextQuestId`=13242 WHERE Id=12500;
UPDATE `quest_template` SET `NextQuestId`=13347 WHERE Id=12499;

-- Step 2: Add Fordragon's Shield (193196) and Saurfang's Battle Armor (193197) to Angrathar.
DELETE FROM `gameobject` WHERE `Id` IN (12500, 12499);
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (193197, 571, 1, 1, 4888.75, 1506.13, 213.663, 0.925738, 0, 0, 0.446517, 0.894775, 300, 0, 1);
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (193196, 571, 1, 1, 4895.57, 1501.07, 214.115, 0.913958, 0, 0, 0.441239, 0.89739, 300, 0, 1);

-- Step 3: Add the matching version of Alextrasza to Angrathar.
DELETE FROM `creature` WHERE `id`=31333;	
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (31333, 571, 1, 1, 0, 0, 4858.06, 1466.94, 209.574, 0.978363, 300, 0, 0, 139450000, 4258000, 0, 0, 0, 0);
