/*DK Bandaid
Goblin DK Quest A special Surprise Fix. 
https://www.wowhead.com/quest=28650/a-special-surprise
https://www.wowhead.com/npc=49356/gally-lumpstain
Original SQL to Restore:
DELETE FROM `creature` WHERE  `guid`=396689;
DELETE FROM `creature_text` WHERE  `CreatureID`=49356;
DELETE FROM `broadcast_text` WHERE  `ID`=77866;
DELETE FROM `broadcast_text` WHERE  `ID`=77867;
DELETE FROM `broadcast_text` WHERE  `ID`=77868;
DELETE FROM `broadcast_text` WHERE  `ID`=77869;
DELETE FROM `broadcast_text` WHERE  `ID`=77870;
DELETE FROM `broadcast_text` WHERE  `ID`=77871;
DELETE FROM `broadcast_text` WHERE  `ID`=77872;
DELETE FROM `broadcast_text` WHERE  `ID`=77873;
DELETE FROM `broadcast_text` WHERE  `ID`=77874;
DELETE FROM `broadcast_text` WHERE  `ID`=77875;
UPDATE `creature_template` SET `unit_flags`='0' WHERE  `entry`=49356;
DELETE FROM `creature_addon` WHERE  `entry`=396689
*/
DELETE FROM `creature` WHERE  `guid`=396689;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseUseFlags`, `phaseMask`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES (396689, 49356, 609, 4298, 4352, 1, 0, 4, 171, 0, -1, 0, 0, 1330.47, -5753.55, 137.388, 3.28455, 300, 0, 0, 10, 0, 0, 0, 0, 0, 'npc_a_special_surprise', 0);

DELETE FROM `creature_text` WHERE  `CreatureID`=49356;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `SoundType`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (49356, 9, 0, '%s dies from his injuries.', 16, 0, 100, 0, 0, 0, 0, 77875, 0, 'special_surprise EMOTE_DIES');
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `SoundType`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (49356, 8, 0, 'Do it, $n! Put me out of my misery!', 12, 0, 100, 0, 0, 0, 0, 77874, 0, 'special_surprise SAY_EXEC_WAITING');
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `SoundType`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (49356, 7, 0, 'There... There\'s no more time for me. I\'m done for. Finish me off, $n. Do it or they\'ll kill us both. $n... Remember Kezan, our beloved home. This world is worth saving.', 12, 0, 100, 0, 0, 0, 0, 77873, 0, 'special_surprise SAY_EXEC_TIME');
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `SoundType`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (49356, 6, 0, 'Listen to me, $n. You must fight against the Lich King\'s control. He is a monster that wants to see this world - our world - in ruin. Don\'t let him use you to accomplish his goals. You were once a hero and you can be again. Fight, damn you! Fight his control!', 12, 0, 100, 0, 0, 0, 0, 77872, 0, 'special_surprise SAY_EXEC_LISTEN');
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `SoundType`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (49356, 5, 0, 'Remember the goblin that you once were, $g brother:sister! You were my best friend! Fight this!', 12, 0, 100, 0, 0, 0, 0, 77871, 0, 'special_surprise SAY_EXEC_THINK');
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `SoundType`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (49356, 4, 0, 'You don\'t remember me, $n? I lost count of the number of jobs you and I ran back in the day on Kezan. Then I picked up a real bad Kaja\'Cola habit and you saved me! It was you who took me to Kalimdor to join the Steamwheedle Cartel. You were the only good goblin I knew. That\'s how I ended up in the Argent Dawn, because I knew it was what you woulda done. How could this have happened to you?', 12, 0, 100, 0, 0, 0, 0, 77870, 0, 'special_surprise SAY_EXEC_NOREM');
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `SoundType`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (49356, 2, 0, '$n?', 12, 0, 100, 0, 0, 0, 0, 77868, 0, 'special_surprise SAY_EXEC_NAME');
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `SoundType`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (49356, 3, 0, '$n, I\'d recognize that face anywhere... What... What have they done to you, $n?', 12, 0, 100, 0, 0, 0, 0, 77869, 0, 'special_surprise SAY_EXEC_RECOG');
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `SoundType`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (49356, 0, 0, 'C... can\'t we work this out somehow?', 12, 0, 100, 0, 0, 0, 0, 77866, 0, 'special_surprise SAY_EXEC_START');
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `SoundType`, `BroadcastTextId`, `TextRange`, `comment`) VALUES (49356, 1, 0, 'Alright, j... just let me... let me st... stand up.', 12, 0, 100, 0, 0, 0, 0, 77867, 0, 'special_surprise SAY_EXEC_PROG');

DELETE FROM `broadcast_text` WHERE  `ID`=77866;
DELETE FROM `broadcast_text` WHERE  `ID`=77867;
DELETE FROM `broadcast_text` WHERE  `ID`=77868;
DELETE FROM `broadcast_text` WHERE  `ID`=77869;
DELETE FROM `broadcast_text` WHERE  `ID`=77870;
DELETE FROM `broadcast_text` WHERE  `ID`=77871;
DELETE FROM `broadcast_text` WHERE  `ID`=77872;
DELETE FROM `broadcast_text` WHERE  `ID`=77873;
DELETE FROM `broadcast_text` WHERE  `ID`=77874;
DELETE FROM `broadcast_text` WHERE  `ID`=77875;
INSERT INTO `broadcast_text` (`ID`, `LanguageID`, `Text`, `Text1`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `SoundEntriesID`, `EmotesID`, `Flags`, `VerifiedBuild`) VALUES (77866, 0, 'C... can\'t we work this out somehow?', 'C... can\'t we work this out somehow?', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);
INSERT INTO `broadcast_text` (`ID`, `LanguageID`, `Text`, `Text1`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `SoundEntriesID`, `EmotesID`, `Flags`, `VerifiedBuild`) VALUES (77867, 0, 'Alright, j... just let me... let me st... stand up.', 'Alright, j... just let me... let me st... stand up.', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);
INSERT INTO `broadcast_text` (`ID`, `LanguageID`, `Text`, `Text1`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `SoundEntriesID`, `EmotesID`, `Flags`, `VerifiedBuild`) VALUES (77868, 0, '$n?', '$n?', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);
INSERT INTO `broadcast_text` (`ID`, `LanguageID`, `Text`, `Text1`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `SoundEntriesID`, `EmotesID`, `Flags`, `VerifiedBuild`) VALUES (77869, 0, '$n, I\'d recognize that face anywhere... What... What have they done to you, $n?', '$n, I\'d recognize that face anywhere... What... What have they done to you, $n?', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);
INSERT INTO `broadcast_text` (`ID`, `LanguageID`, `Text`, `Text1`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `SoundEntriesID`, `EmotesID`, `Flags`, `VerifiedBuild`) VALUES (77870, 0, 'You don\'t remember me, $n? I lost count of the number of jobs you and I ran back in the day on Kezan. Then I picked up a real bad Kaja\'Cola habit and you saved me! It was you who took me to Kalimdor to join the Steamwheedle Cartel. You were the only good goblin I knew. That\'s how I ended up in the Argent Dawn, because I knew it was what you woulda done. How could this have happened to you?', 'You don\'t remember me, $n? I lost count of the number of jobs you and I ran back in the day on Kezan. Then I picked up a real bad Kaja\'Cola habit and you saved me! It was you who took me to Kalimdor to join the Steamwheedle Cartel. You were the only good goblin I knew. That\'s how I ended up in the Argent Dawn, because I knew it was what you woulda done. How could this have happened to you?', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);
INSERT INTO `broadcast_text` (`ID`, `LanguageID`, `Text`, `Text1`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `SoundEntriesID`, `EmotesID`, `Flags`, `VerifiedBuild`) VALUES (77871, 0, 'Remember the goblin that you once were, $g: brother:sister! You were my best friend! Fight this!', 'Remember the goblin that you once were, $g: brother:sister! You were my best friend! Fight this!', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);
INSERT INTO `broadcast_text` (`ID`, `LanguageID`, `Text`, `Text1`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `SoundEntriesID`, `EmotesID`, `Flags`, `VerifiedBuild`) VALUES (77872, 0, 'Listen to me, $n. You must fight against the Lich King\'s control. He is a monster that wants to see this world - our world - in ruin. Don\'t let him use you to accomplish his goals. You were once a hero and you can be again. Fight, damn you! Fight his control!', 'Listen to me, $n. You must fight against the Lich King\'s control. He is a monster that wants to see this world - our world - in ruin. Don\'t let him use you to accomplish his goals. You were once a hero and you can be again. Fight, damn you! Fight his control!', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);
INSERT INTO `broadcast_text` (`ID`, `LanguageID`, `Text`, `Text1`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `SoundEntriesID`, `EmotesID`, `Flags`, `VerifiedBuild`) VALUES (77873, 0, 'There... There\'s no more time for me. I\'m done for. Finish me off, $n. Do it or they\'ll kill us both. $n... Remember Kezan, our beloved home. This world is worth saving.', 'There... There\'s no more time for me. I\'m done for. Finish me off, $n. Do it or they\'ll kill us both. $n... Remember Kezan, our beloved home. This world is worth saving.', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);
INSERT INTO `broadcast_text` (`ID`, `LanguageID`, `Text`, `Text1`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `SoundEntriesID`, `EmotesID`, `Flags`, `VerifiedBuild`) VALUES (77874, 0, 'Do it, $n! Put me out of my misery!', 'Do it, $n! Put me out of my misery!', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);
INSERT INTO `broadcast_text` (`ID`, `LanguageID`, `Text`, `Text1`, `EmoteID1`, `EmoteID2`, `EmoteID3`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `SoundEntriesID`, `EmotesID`, `Flags`, `VerifiedBuild`) VALUES (77875, 0, '%s dies from his injuries.', '%s dies from his injuries.', 0, 0, 0, 0, 0, 0, 0, 0, 1, 18019);

DELETE FROM `creature_template_addon` WHERE  `entry`=49356;
INSERT INTO `creature_template_addon` (`entry`, `waypointPathId`, `cyclicSplinePathId`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (49356, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, NULL);

UPDATE `creature_template` SET `unit_flags`='33536' WHERE  `entry`=49356;

DELETE FROM `creature_addon` WHERE  `guid`=396689;
INSERT INTO `creature_addon` (`guid`, `waypointPathId`, `cyclicSplinePathId`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (396689, 0, 0, 0, 65544, 1, 0, 0, 0, 0, 0, NULL);
