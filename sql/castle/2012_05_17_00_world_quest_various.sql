-- @DorianGrey: Just a bunch of quest-fixes.

-- Deathblow to the Legion: Since the event does not seem to work, enable Socrethar as quest target, remove special-flags.
UPDATE `quest_template` SET `SpecialFlags`=`SpecialFlags`&~2, `RequiredNpcOrGo1`=20132, `RequiredNpcOrGoCount1`=1 WHERE `Id`=10409;

-- Turning point: Enable quest offering to party members.
UPDATE `quest_template` SET `Flags`=`Flags`|2 WHERE `Id`=10507;

-- Argent Aid: Fix quest coupling.
UPDATE `quest_template` SET `NextQuestIdChain`=13363 WHERE `Id`=13362; 
UPDATE `quest_template` SET `PrevQuestId`=13362 WHERE `Id`=13363;

-- Volatility Daily/Non-daily: Fix prerequisite.
UPDATE `quest_template` SET `PrevQuestId`=13239 WHERE `Id`=13261;

-- Judgement Day (13227) should only be offered if Honor Above All Else (13036) was not completed yet.
DELETE FROM `conditions` WHERE `SourceEntry`=13227 AND `SourceTypeOrReferenceId`=20;
INSERT INTO `conditions` VALUES (20, 0, 13227, 0, 0, 8, 0, 13036, 0, 0, 1, 0, '', 'Q \'Judgement Day\' should only be offered if \'Honor Above All Else\' was not completed yet');
