-- Fix quests 11731, 11921, 11922, 11926 Fackelwurf / Torch Tossing - Noch einmal Fackeln werfen / More Torch Tossing
-- Fix quests 11923, 11925, 11657, 11924 Fackeln fangen / Torch Catching - Noch einmal Fackeln fangen / More Torch Catching
-- Spawn spellfocus gameobject 300068, 50 yards diameter for spell casting allowed
UPDATE `gameobject_template` SET `data1` = 50 WHERE `entry` = 300068;
DELETE FROM `game_event_gameobject` WHERE `guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` = 300068);
DELETE FROM `gameobject` WHERE `id` = 300068;
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation0, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES
(300068, 0, 1, 1, -8822.72, 855.232, 99.0484, 5.9631, 0, 0, 0.159362, -0.98722, 300, 0, 1),
(300068, 0, 1, 1, -4682.71, -1225.83, 501.659, 0.101229, 0, 0, 0.0505929, 0.998719, 300, 0, 1),
(300068, 0, 1, 1, 1837.2, 219.057, 60.166, 6.24609, 0, 0, 0.0185457, -0.999828, 300, 0, 1),
(300068, 1, 1, 1, -1041.72, 305.708, 134.702, 2.29825, 0, 0, 0.912405, 0.409288, 300, 0, 1),
(300068, 1, 1, 1, 1920.53, -4320.48, 22.0346, 1.43789, 0, 0, 0.658591, 0.752501, 300, 0, 1),
(300068, 1, 1, 1, 8717.87, 928.938, 15.7723, 3.20661, 0, 0, 0.999472, -0.0325044, 300, 0, 1),
(300068, 530, 1, 1, -3775.33, -11512.1, -134.56, 2.67663, 0, 0, 0.973098, 0.230391, 300, 0, 1),
(300068, 530, 1, 1, 9816.61, -7228.03, 26.1073, 6.27033, 0, 0, 0.00642763, -0.999979, 300, 0, 1);
INSERT INTO `game_event_gameobject` (eventEntry, guid) SELECT 1, `guid` FROM `gameobject` WHERE `id` = 300068;
-- Spawn target creature 25535 and insert script for despawning on spell hit 46054
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25535;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25535 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2553500 AND `source_type` = 9;
INSERT INTO `smart_scripts` (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(25535, 0, 0, 1, 8, 0, 100, 0, 46054, 0, 0, 0, 44, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '[DNT] Torch Tossing Target Bunny - Set ingame phase to 2 on spellhit 46054'),
(25535, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 2553500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '[DNT] Torch Tossing Target Bunny - Call timed actionlist 2553500'),
(2553500, 9, 0, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 44, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '[DNT] Torch Tossing Target Bunny - Set back to ingame phase 1 after 30 seconds');
DELETE FROM `game_event_creature` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 25535);
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 25535);
DELETE FROM `creature` WHERE `id` = 25535;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(25535, 1, 1, 1, 11686, 0, -1041.61, 313.163, 133.278, -1.76278, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 1923.87, -4315.27, 22.4918, -2.18166, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 1920.49, -4319.35, 21.8167, 0.698132, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -8825.72, 845.613, 99.0511, 2.89725, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, -1042.52, 306.56, 134.451, -1.98968, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 1915.58, -4320.46, 21.8202, -1.58825, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 8722.04, 933.662, 15.9977, -2.18166, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 8716.73, 936.471, 14.8964, -1.58825, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, -1035.88, 312.549, 134.666, -1.58825, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, -1049.08, 306.373, 132.937, -2.18166, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 8716.85, 928.883, 15.3478, -1.76278, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 8721.22, 923.779, 16.4874, 0.698132, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 8717.3, 920.104, 15.1784, -1.98968, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 1925.15, -4321.27, 21.6547, -1.76278, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -4675.41, -1224.66, 501.659, -1.98968, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -4677.39, -1229.83, 501.659, -1.58825, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -4685.95, -1218.96, 501.659, 0.698132, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, 1838.23, 218.969, 60.1496, -1.76278, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, 1837.19, 225.627, 60.246, -1.58825, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, -1048.8, 299.889, 134.401, 0.698132, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 1, 1, 1, 11686, 0, 1918.07, -4314.9, 22.8562, -1.98968, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, 1837.4, 213.158, 60.3433, -1.98968, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, 1840.84, 216.245, 60.074, -2.18166, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, 1840.18, 222.607, 60.2069, 0.698132, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -4683.98, -1232.64, 501.659, -1.76278, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -4678.69, -1219.43, 501.659, -2.18166, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -8819.46, 848.506, 98.9483, -2.18166, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, -3768.73, -11511.2, -134.479, 2.70805, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, -3773.26, -11519.4, -134.56, 2.53526, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, -3776.32, -11511.5, -134.569, 5.69256, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, -3775.23, -11506.7, -134.539, 5.79074, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, -3780.47, -11514.1, -134.626, 5.66115, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, 9817.67, -7227.84, 26.1104, 3.89843, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, 9810.38, -7226.95, 26.0582, 0.898206, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, 9819.87, -7234.51, 26.1176, 0.898206, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, 9823.56, -7229.12, 26.1209, 3.78847, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 530, 1, 1, 11686, 0, 9817.55, -7221.36, 26.1142, 3.80025, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -8816.54, 854.183, 98.882, 4.34518, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -8815.11, 860.487, 98.96, 4.75751, 30, 0, 0, 4120, 0, 0, 0, 0, 0),
(25535, 0, 1, 1, 11686, 0, -8818.01, 865.253, 98.9761, 4.47084, 30, 0, 0, 4120, 0, 0, 0, 0, 0);
INSERT INTO `game_event_creature` (eventEntry, guid) SELECT 1, `guid` FROM `creature` WHERE `id` = 25535;
-- Apply required changes to quest templates
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 25535, `RequiredSpellCast1` = 46054, `RequiredSourceItemId2` = 34862, `RequiredSourceItemCount2` = 1, `StartScript` = `Id` WHERE `Id` IN (11731, 11921, 11922, 11926);
UPDATE `quest_template` SET `RequiredNpcOrGoCount1` = 8 WHERE `Id` IN (11731, 11922);
UPDATE `quest_template` SET `RequiredNpcOrGoCount1` = 20 WHERE `Id` IN (11921, 11926);
UPDATE `quest_template` SET `RequiredRaces` = 1101 WHERE `Id` IN (11731, 11921);
UPDATE `quest_template` SET `RequiredRaces` = 690 WHERE `Id` IN (11922, 11926);
UPDATE `quest_template` SET `RequiredNpcOrGo1` = 25515, `RequiredSourceItemId2` = 34833, `RequiredSourceItemCount2` = 1, `StartScript` = `Id`, `ObjectiveText1` = 'Fackeln gefangen' WHERE `Id` IN (11923, 11925, 11657, 11924);
UPDATE `quest_template` SET `RequiredNpcOrGoCount1` = 4 WHERE `Id` IN (11923, 11657);
UPDATE `quest_template` SET `RequiredNpcOrGoCount1` = 10 WHERE `Id` IN (11925, 11924);
UPDATE `quest_template` SET `RequiredRaces` = 1101 WHERE `Id` IN (11657, 11924);
UPDATE `quest_template` SET `RequiredRaces` = 690 WHERE `Id` IN (11923, 11925);
-- Insert quest start scripts as workaround for specialflag event
DELETE FROM `quest_start_scripts` WHERE `id` IN (11731, 11921, 11922, 11926, 11923, 11925, 11657, 11924);
INSERT INTO `quest_start_scripts` (id, delay, command, datalong, datalong2, dataint, x, y, z, o) VALUES
(11731, 0, 7, 11731, 10, 0, 0, 0, 0, 0),
(11921, 0, 7, 11921, 10, 0, 0, 0, 0, 0),
(11922, 0, 7, 11922, 10, 0, 0, 0, 0, 0),
(11926, 0, 7, 11926, 10, 0, 0, 0, 0, 0),
(11923, 0, 7, 11923, 10, 0, 0, 0, 0, 0),
(11925, 0, 7, 11925, 10, 0, 0, 0, 0, 0),
(11657, 0, 7, 11657, 10, 0, 0, 0, 0, 0),
(11924, 0, 7, 11924, 10, 0, 0, 0, 0, 0);
-- Conditions, so spells can hit targets
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (46054, 45732, 46747);
INSERT INTO `conditions` (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorTextId, ScriptName, Comment) VALUES
(13, 0, 46054, 0, 1, 18, 0, 1, 25535, 0, 0, 0, '', 'Quest support midsummer festival - target NPC 25535'),
(13, 0, 45732, 0, 1, 18, 0, 1, 25535, 0, 0, 0, '', 'Quest support midsummer festival - target NPC 25535'),
(13, 0, 46747, 0, 1, 18, 0, 1, 0, 0, 0, 0, '', 'Quest support midsummer festival - target palyer');
-- Link several spells with each other, so quest credits can be counted
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (46747, 45693);
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(46747, 45693, 0, 'Quest support midsummer festival'),
(45693, -45693, 0, 'Quest support midsummer festival');