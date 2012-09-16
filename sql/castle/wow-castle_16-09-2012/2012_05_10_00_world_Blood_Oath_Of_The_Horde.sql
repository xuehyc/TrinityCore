/* @DorianGrey
Fix for Q11983: Blood Oath of the Horde.
The gossip with the Taunka is based on http://www.wowhead.com/quest=11983/blood-oath-of-the-horde#comments:id=478649.

Note that the scripts below still lack some problems:
-> Closing the gossip-menu does not seem to work properyl. Don't know why.
-> Despawning the taunka after the oath is visualized as death. (WTF? Dying and despawning are different actions, but handled in the same way...)
-> Despawning takes longer that the script requests (seems to take several seconds, while requesting 1 ms).

But, after all, it works - for now.
*/

-- Step 1: Update creature-definitions for taunka refugees.
UPDATE `creature_template` SET `gossip_menu_id`=26179, `npcflag`=`npcflag`|1,`AIName`='SmartAI' WHERE `entry` IN (26179, 26184);

-- Step 2: Create the gossip-options. It's the same for both mentioned above, though.
DELETE FROM `gossip_menu_option` WHERE `menu_id` IN (26179, 2617, 2618, 2619);
INSERT INTO `gossip_menu_option` VALUES (26179, 0, 0, 'Worry no more, taunka. The Horde will save and protect you and your people, but first you must swear allegiance to the Warchief by taking the blood oath of the Horde.', 1, 1, 2617, 0, 0, 0, '');
INSERT INTO `gossip_menu_option` VALUES (2617, 0, 0, 'Yes, taunka. Retribution is a given right of all members of the Horde.', 1, 1, 2618, 0, 0, 0, '');
INSERT INTO `gossip_menu_option` VALUES (2618, 0, 0, 'Then repeat after me: "Lok\'tar ogar! Victory or death - it is these words that bind me to the Horde. For they are the most sacred and fundamental of truths to any warrior of the Horde.\r\n\r\nI give my flesh and blood freely to the Warchief. I am the instrument of my Warchief\'s desire. I am a weapon of my Warchief\'s command.', 1, 1, 2619, 0, 0, 0, '');
INSERT INTO `gossip_menu_option` VALUES (2619, 0, 0, 'For the Horde!\r\n\r\nArm yourself from the crates that surround us and report to Agmar\'s Hammer, east of here. Your first trial as a member of the Horde is to survive the journey.\r\n\r\nLok\'tar ogar!', 1, 1, 2619, 0, 0, 0, '');

-- Step 3: Create corresponding npc-text fields.
DELETE FROM `npc_text` WHERE `Id` IN (26179, 2617, 2618, 2619);
INSERT INTO `npc_text` VALUES (26179, 'Only the Horde can save us now.', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 1);
INSERT INTO `npc_text` VALUES (2617, 'Will the Horde grant me the chance to battle the Scourge?', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 1);
INSERT INTO `npc_text` VALUES (2618, 'To avenge my people, to drive out the blight that has engulfed our land - I will take your oath. I will pledge all that I have and all that I am to the Horde.', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 1);
INSERT INTO `npc_text` VALUES (2619, 'From this moment until the end of days I live and die - For the Horde!"\r\n\r\nLok\'tar ogar! Victory or death - it is these words that bind me to the Horde. For they are the most sacred and fundamental of truths to any warrior of the Horde.\r\n\r\nI give my flesh and blood freely to the Warchief. I am the instrument of my Warchief\'s desire. I am a weapon of my Warchief\'s command.\r\n\r\nFrom this moment until the end of days I live and die - FOR THE HORDE!', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 1);

DELETE FROM `gossip_menu` WHERE `text_id` IN (26179, 2617, 2618, 2619);
INSERT INTO `gossip_menu` VALUES (26179, 26179);
INSERT INTO `gossip_menu` VALUES (26184, 26179);
INSERT INTO `gossip_menu` VALUES (2617, 2617);
INSERT INTO `gossip_menu` VALUES (2618, 2618);
INSERT INTO `gossip_menu` VALUES (2619, 2619);

-- Step 4: Enable visibility limitation
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=26179;  
INSERT INTO `conditions` VALUES (15, 26179, 0, 0, 0, 9, 0, 11983, 0, 0, 0, 0, '', 'Blood oath of the Horde.');

-- Step 5: Create smart-scripts for the gossip. 
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (26179, 26184);
INSERT INTO `smart_scripts` VALUES (26179, 0, 0, 1, 62, 0, 100, 0, 2619, 0, 0, 0, 33, 26179, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Blood oath of the Horde - Grant credit');
INSERT INTO `smart_scripts` VALUES (26179, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Blood oath of the Horde - Close gossip');
INSERT INTO `smart_scripts` VALUES (26179, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blood oath of the Horde - Despawn');
INSERT INTO `smart_scripts` VALUES (26184, 0, 0, 1, 62, 0, 100, 0, 2619, 0, 0, 0, 33, 26179, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Blood oath of the Horde - Grant credit');
INSERT INTO `smart_scripts` VALUES (26184, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Blood oath of the Horde - Close gossip');
INSERT INTO `smart_scripts` VALUES (26184, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Blood oath of the Horde - Despawn');
