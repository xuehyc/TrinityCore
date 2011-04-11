-- Fix Quest 13070 A Cold Front Approaches
UPDATE `quest_template` SET `SpecialFlags` = 0 WHERE `entry` = 13070;
DELETE FROM `creature_involvedrelation` WHERE `quest` = 13070;
INSERT INTO `creature_involvedrelation` VALUES
(30657,13070);

