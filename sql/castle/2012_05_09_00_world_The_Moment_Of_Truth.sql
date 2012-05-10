/* @DorianGrey
	Fix for Q10201: "And Now, the Moment of Truth"
	I had to rewrite Grek's whole AI, since the former EventAI cannot handle gossip-selections.
	Some of the entries were wrong, since three of Grek's four texts should be linked on quest
	selection only. The fix below works but with some typo drawbacks, since the text delays seem
	to be ignored - whyever.
*/
-- Step 1: Create gossip link and enable smart-ai.
UPDATE `creature_template` SET `gossip_menu_id`=19606, `AIName`='SmartAI' WHERE `entry`=19606;

-- Step 2: Create gossip entry.
DELETE FROM `gossip_menu_option` WHERE `menu_id`=19606 AND `id`=0;
INSERT INTO `gossip_menu_option` VALUES (19606, 0, 0, 'Grek, would you mind trying this oil ?', 1, 1, 0, 0, 0, 0, '');

-- Step 3: Enable visibility condition.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=19606;	
INSERT INTO `conditions` VALUES (15, 19606, 0, 0, 0, 9, 0, 10201, 0, 0, 0, 0, '', 'And now, the moment of truth - talking to Grek.');

-- Step 4: Creature creature texts.
DELETE FROM `creature_text` WHERE `entry`=19606;
INSERT INTO `creature_text` VALUES (19606, 1, 244, 'Someone come read this wanted poster to Grek. Grek can\'t read.', 12, 0, 0, 0, 0, 0, 'Grek - "Read poster pls"');
INSERT INTO `creature_text` VALUES (19606, 2, 245, 'Grek try!', 12, 0, 0, 0, 0, 0, 'Grek - Gossip 1 on quest');
INSERT INTO `creature_text` VALUES (19606, 3, 246, 'This oil no good for Grek! What Grek look like to you, some weakling in robes?', 12, 0, 0, 0, 0, 0, 'Grek - Gossip 2 on quest');
INSERT INTO `creature_text` VALUES (19606, 4, 247, 'Grek get a drink.', 12, 0, 0, 0, 0, 0, 'Grek - Gossip 3 on quest');

-- Step 5: Create smart_scripts.
DELETE FROM `smart_scripts` WHERE `entryorguid`=19606;
INSERT INTO `smart_scripts` VALUES (19606, 0, 0, 1, 1, 0, 100, 0, 120000, 120000, 120000, 120000, 1, 1, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grek - "Read Poster pls"');
INSERT INTO `smart_scripts` VALUES (19606, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 5, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grek - "Read Poster pls"-Emote');
INSERT INTO `smart_scripts` VALUES (19606, 0, 2, 3, 62, 0, 100, 0, 19606, 0, 0, 0, 33, 19606, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Grek - Kill credit on gossip selection');
INSERT INTO `smart_scripts` VALUES (19606, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 1, 2, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grek - "Grek try!" - on Q');
INSERT INTO `smart_scripts` VALUES (19606, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grek - "Grek try!" - Emote');
INSERT INTO `smart_scripts` VALUES (19606, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 1, 3, 3500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grek - Flame on Player');
INSERT INTO `smart_scripts` VALUES (19606, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 5, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grek - Flame on Player Emote');
INSERT INTO `smart_scripts` VALUES (19606, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 1, 4, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grek - Go drinking.');
INSERT INTO `smart_scripts` VALUES (19606, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 5, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Grek - Go drinking Emote.');

-- Step 6: DB cleanup. Required, since EventAI may be enforced otherwise...
DELETE FROM `creature_ai_scripts` WHERE `creature_id`=19606;
DELETE FROM `creature_ai_texts` WHERE `entry` IN (-244,-245,-246,-247);