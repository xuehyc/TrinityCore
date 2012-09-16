-- @DorianGrey
-- First part of fix for Q12274: A Fall from Grace.
-- This parts includes the Raven Priest cover that is granted by Agent Skully.
-- See the corresponding spell-script in spell_generic.cpp .
-- Players that want to do this quest have to talk with Agent Skully after accepting the quest.
-- This can be done again as long as the quest is active.

-- Step 1: Register SpellScript.
DELETE FROM `spell_script_names` WHERE `spell_id`=48762;
INSERT INTO `spell_script_names` VALUES(48762, 'spell_gen_scarlet_raven_priest_image');

-- Step 2: Update Agent Skully to use SmartAI, and add a gossip-menu.
UPDATE `creature_template` SET `gossip_menu_id`=27350, `AIName`='SmartAI' WHERE `entry`=27350;

-- Step 3: Implement the gossip-menu mentioned above.
DELETE FROM `gossip_menu_option` WHERE `menu_id`=27350 AND `id`=1;
INSERT INTO `gossip_menu_option` VALUES (27350, 1, 0, 'I\'ve lost my cover... I need a new one.', 1, 1, 0, 0, 0, 0, '');

-- Step 4: Force the menu to only be seen during the quest.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=27350;
INSERT INTO `conditions` VALUES (15, 27350, 1, 0, 0, 9, 0, 12274, 0, 0, 0, 0, '', 'A Fall from Grace - Get cover again if it was lost during quest.');

-- Step 5: Add a smart_script that casts the spell on the target on gossip selection.
DELETE FROM `smart_scripts` WHERE `entryorguid`=27350;
INSERT INTO `smart_scripts` VALUES (27350, 0, 0, 0, 62, 0, 100, 0, 27350, 1, 0, 0, 85, 48762, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Agent Skully - Offer cover renewal during A Fall from Grace');
