-- https://www.wowhead.com/npc=3102/felstalker
UPDATE `creature_template` SET `IconName`='Attack' WHERE `entry`=3102;

-- https://www.wowhead.com/npc=39245/northwatch-lug
-- https://www.wowhead.com/npc=39251/northwatch-supply-crate
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry` IN (39245, 39251);

-- https://www.wowhead.com/item=4862/scorpid-worker-tail
-- https://www.wowhead.com/npc=3124/scorpid-worker 			
-- https://www.wowhead.com/npc=3281/sarkoth 	
DELETE FROM `creature_loot_template` WHERE `Item`=4862;			
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Change`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(3124, 4862, 0, 88.025199, 1, 1, 0, 1, 1, ''),
(3281, 4862, 0,  6.209720, 1, 1, 0, 1, 1, '');
 
-- https://www.wowhead.com/item=3264/duskbat-wing
-- https://www.wowhead.com/npc=1512/duskbat 			
-- https://www.wowhead.com/npc=1513/mangy-duskbat
DELETE FROM `creature_loot_template` WHERE `Item`=3264;			
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Change`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(1512, 4862, 0, 94.073679, 1, 1, 0, 1, 1, ''),
(1513, 4862, 0, 85.870376, 1, 1, 0, 1, 1, '');

-- https://www.wowhead.com/quest=24769/more-than-expected
UPDATE `quest_template_addon` SET `PrevQuestID`=24768 WHERE `ID`=24769;

-- https://www.wowhead.com/quest=792/vile-familiars
-- https://www.wowhead.com/quest=24766/the-arts-of-a-druid
DELETE FROM `quest_template` WHERE `ID` IN (792, 24766);
DELETE FROM `quest_template_addon` WHERE `ID` IN (792, 24766);
DELETE FROM `quest_template_locale` WHERE `ID` IN (792, 24766);
DELETE FROM `quest_objectives` WHERE `QuestID` IN (792, 24766);
DELETE FROM `quest_objectives_locale` WHERE `QuestId` IN (792, 24766);
