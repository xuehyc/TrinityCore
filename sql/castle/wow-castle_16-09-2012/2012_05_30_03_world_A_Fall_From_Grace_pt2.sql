-- @DorianGrey
-- Part 2 for "A Fall from Grace" (Q12274).
-- High Abbot Lundgren now uses npc_escortAI, which can be used during the quest.
-- His text's have been taken from wowhead.

-- Step 1: Enable script usage.
UPDATE `creature_template` SET `ScriptName`='npc_high_abbot_lundgren' WHERE `entry`=27245;

-- Step 2: Create waypoints, ten for regular usage and one as a dummy.
DELETE FROM `script_waypoint` WHERE `entry`=27245;
INSERT INTO `script_waypoint` (`entry`, `pointid`, `location_x`, `location_y`, `location_z`, `waittime`, `point_comment`) VALUES 
(27245, 0, 2789.4038, -487.6989, 119.6170, 50, NULL),
(27245, 1, 2816.5700, -464.4892, 119.6139, 50, NULL),
(27245, 2, 2817.8723, -452.2622, 119.6139, 50, NULL),
(27245, 3, 2827.6858, -443.4267, 119.6139, 50, NULL),
(27245, 4, 2827.0698, -412.6503, 118.1966, 50, NULL),
(27245, 5, 2811.3479, -411.3476, 118.1966, 50, NULL),
(27245, 6, 2783.8577, -441.8513, 118.1966, 50, NULL),
(27245, 7, 2770.3781, -482.1140, 115.8384, 50, NULL),
(27245, 8, 2739.9192, -515.6594, 103.0430, 50, NULL),
(27245, 9, 2738.2974, -524.0002, 103.4287, 50, NULL),
(27245, 10, 2748.5298, -527.7862, 104.6969, 50, NULL); -- Dummy, just to prevent the NPC from despawning immediately.

-- Step 3: Add scripts texts. Hope that the entries will not cause any conflicts againg...
DELETE FROM `script_texts` WHERE `npc_entry`=27245 AND `entry` IN (-1700070, -1700071, -1700072, -1700073, -1700074, -1700075);
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES 
(27245, -1700070, 'I know a place nearby where we can speak in private, my child. Follow me.', '', '', '', '', '', '', '', '', 0, 0, 0, 0, ''),
(27245, -1700071, 'Did you think that I could not see through your flimsy disguise, $N?', '', '', '', '', '', '', '', '', 0, 0, 0, 0, ''),
(27245, -1700072, 'There is much that you do not understand, $R. The Master sees all.', '', '', '', '', '', '', '', '', 0, 0, 0, 0, ''),
(27245, -1700073, 'He told me that you would come for me. I won\'t die by your hand, though. I have seen what you have done to my compatriots.', '', '', '', '', '', '', '', '', 0, 0, 0, 0, ''),
(27245, -1700074, 'No. I will leave this world in a manner of my own choosing. And I will return, the grand admiral\'s will permitting!', '', '', '', '', '', '', '', '', 0, 0, 0, 0, ''),
(27245, -1700075, 'AAAEEEEIIIiiiiiiiiiiiiiiiiiiiiiiiiiiii........................................', '', '', '', '', '', '', '', '', 0, 0, 0, 0, '');
