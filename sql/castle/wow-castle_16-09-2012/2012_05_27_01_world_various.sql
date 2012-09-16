-- Quest 10853: Spirit Calling
   -- Remove unit-flag UNIT_FLAG_IMMUNE_TO_PC (256) and dynamic-flag UNIT_DYNFLAG_TAPPED_BY_PLAYER (8), which isn't required.
   SET @mob_lesser_netherdrake = 21004;
   UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~256, `dynamicflags`=0 WHERE `entry`=@mob_lesser_netherdrake;

-- Quest 10488: Protecting Our Own
   -- Note: Using SmartAI here is just one option, another may be event_scripts (event 13489 is sent after spell-cast)
   -- or just changing the required npc-id in quest_template. I thought of SmartAI being the most accurate.
   SET @quest_protecting_our_own = 10488;
   SET @spell_stealth_detection = 37691;
   SET @spell_gordreks_ointment = 32578;
   SET @mob_thunder_direwolf = 20748;
   SET @mob_thunder_direwolf_bunny = 21142;
   
   -- Step 1: Enable the usage of SmartAI.
   UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@mob_thunder_direwolf;
   
   -- Step 2: Drop EventAI-script - would block otherwise (forced change to EventAI if a scripts exists).
   DELETE FROM `creature_ai_scripts` WHERE `creature_id`=@mob_thunder_direwolf;
   
   -- Step 3: Create smart_scripts-entries: The former EventAI and the "on-hit-by-spell"-mechanims required for the quest.
   DELETE FROM `smart_scripts` WHERE `entryorguid`=@mob_thunder_direwolf;
   INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
   (@mob_thunder_direwolf, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 11, @spell_stealth_detection, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Thunderlord Dire Wolf - Stealth Detection'),
   (@mob_thunder_direwolf, 0, 1, 0, 8, 0, 100, 0, @spell_gordreks_ointment, 0, 90000, 90000, 33, @mob_thunder_direwolf_bunny, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Thunderlord Dire Wolf - Grant kill credit on being hit by spell ');
   
   -- Step 4: Remove SpellCast dependency - it's not required due to trigger-bunny, and would prevent the script from working correctly.
   UPDATE `quest_template` SET `RequiredSpellCast1`=0 WHERE `Id`=@quest_protecting_our_own;
   
   -- Backup of EventAI-Script.
   -- INSERT INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (2074800, 20748, 11, 0, 100, 0, 0, 0, 0, 0, 11, 37691, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Thunderlord Dire Wolf - Stealth Detection');
