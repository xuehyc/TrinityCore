-- @DorianGrey
-- 2nd part of fix for Q10607 (Whispers of the Raven God). The gameobject are granting the corresponding kill-credits
-- when they are used (on gossip hello).
-- A small drawback is that these are granted even without having the corresponding buff active, but since there are a lot
-- of Grishna Arakkoa around the spots that are causing the buff to appear, this is acceptable. 

-- Step 1: Activate SmartAI on the related GO's.
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry` IN (184950,184967,184968,184969);

-- Step 2: Create smart_scripts for them.
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (184950, 184967, 184968, 184969); 
INSERT INTO `smart_scripts` VALUES 
(184950, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 33, 22798, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Whispers of the Raven God - 1st Prophecy: Grant kill-credit.'),
(184967, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 33, 22799, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Whispers of the Raven God - 2nd Prophecy: Grant kill-credit.'),
(184968, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 33, 22800, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Whispers of the Raven God - 3rd Prophecy: Grant kill-credit.'),
(184969, 1, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 33, 22801, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Whispers of the Raven God - 4th Prophecy: Grant kill-credit.');
