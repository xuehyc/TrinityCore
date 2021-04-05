/* 
https://www.wowhead.com/npc=28943/fineous 
Fineous NPC DK Start area work around. Current does not show items for sale or repair option.
this lets you access that, even though his gossip option never shows up.
Original npc flag is 4225
*/
UPDATE `creature_template` SET `npcflag`='4224' WHERE  `entry`=28943;

/* https://www.wowhead.com/quest=12779/an-end-to-all-things 
issues with which lich king is which when it comes to quest progression
so we fixed the one that stays in phase. original id is 25462
*/
UPDATE `creature_questender` SET `id`='29110' WHERE  `id`=25462 AND `quest`=12779;
UPDATE `creature_queststarter` SET `id`='29110' WHERE  `id`=25462 AND `quest`=12779;
-- move the lich king as he falls thru the platform, we will move him to the base
DELETE FROM `creature` WHERE  `guid`=130896;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseUseFlags`, `phaseMask`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (130896, 29110, 609, 4298, 4356, 1, 0, 192, 0, 369, -1, 0, 0, 2322.53, -5732.56, 153.918, 0.821803, 360, 0, 0, 27890000, 0, 0, 0, 0, 0, '', 0);
