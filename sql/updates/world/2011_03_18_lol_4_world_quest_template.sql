-- Fix Quest linking from 12930 onwards
UPDATE `quest_template` SET `PrevQuestId`=12930, `ExclusiveGroup`=-12931, `NextQuestId`=12957 WHERE `entry`=12931;
UPDATE `quest_template` SET `PrevQuestId`=12930, `ExclusiveGroup`=-12931, `NextQuestId`=12964 WHERE `entry`=12937;
UPDATE `quest_template` SET `PrevQuestId`=12931, `ExclusiveGroup`=-12957, `NextQuestId`=12965 WHERE `entry`=12957;
UPDATE `quest_template` SET `PrevQuestId`=12937, `ExclusiveGroup`=-12957, `NextQuestId`=12978 WHERE `entry`=12964;
UPDATE `quest_template` SET `PrevQuestId`=12957 WHERE `entry`=12965;
UPDATE `quest_template` SET `PrevQuestId`=12964 WHERE `entry`=12978;
UPDATE `quest_template` SET `PrevQuestId`=12980 WHERE `entry`=12984;
UPDATE `quest_template` SET `ExclusiveGroup`=-12988, `NextQuestId`=12993 WHERE `entry`=12988;
UPDATE `quest_template` SET `PrevQuestId`=12984, `ExclusiveGroup`=-12988, `NextQuestId`=12993 WHERE `entry`=12991;

