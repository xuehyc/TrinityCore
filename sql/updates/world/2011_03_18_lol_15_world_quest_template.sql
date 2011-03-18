-- Fix Quest Linking of 13384 and onwards
UPDATE `quest_template` SET `PrevQuestId`=13372 WHERE `entry` =13384;
UPDATE `quest_template` SET `PrevQuestId`=13375 WHERE `entry` =13385;
