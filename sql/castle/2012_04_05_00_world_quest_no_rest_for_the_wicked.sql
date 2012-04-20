-- @DorianGrey.
-- Fix for Q "No Rest for the Wicked" (13346, 13350, 13367, 13368).
-- Objective is "Alumeth the Ascended".
-- Step 1: Update WDB verification of the game-object - didn't work in my test-runs without that, whyever.
UPDATE `gameobject_template` SET `WDBVerified`=12340 WHERE `entry`=300241;

-- Step 2: Create new spell-script. 60831 is the spell casted by the item, 60834 "Ping Alumeth Summon Bunny" - Spell called after channeling of 60834 has finished.
DELETE FROM `spell_scripts` WHERE `id` = 60834;
INSERT INTO `spell_scripts` (`id`, `effIndex`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES (60834, 0, 0, 10, 32300, 30000, 0, 8224.81, 2187.05, 499.737, 3.23896);

-- Step 3: Update Alumeth's faction, skills and AI-category.
UPDATE `creature_template` SET `faction_A`=21, `faction_H`=21, `mindmg`=467, `maxdmg`=662, `spell1`=60472, `spell2`=34322, `spell3`=37978, `spell4`=34942, `spell5`=0, `AIName`='SmartAI' WHERE `entry`=32300;

-- Step 4: Tell him to use his spells.
DELETE FROM `smart_scripts` WHERE `entryorguid`=32300;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (32300, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 5000, 10000, 11, 60472, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Alumeth - Mind Flay');
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (32300, 0, 1, 0, 0, 0, 100, 0, 0, 1000, 8000, 12000, 11, 34322, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Alumeth - Psychic Scream');
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (32300, 0, 2, 0, 0, 0, 100, 0, 0, 0, 4000, 6000, 11, 37978, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Alumeth - Renew');
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (32300, 0, 3, 0, 0, 0, 100, 0, 0, 1000, 3000, 4000, 11, 34942, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Alumeth - Shadow Word: Pain');
