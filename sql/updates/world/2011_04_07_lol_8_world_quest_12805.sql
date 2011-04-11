-- Fix for Quest 12805 Salvaging Life's Strength

UPDATE `quest_template` SET `ReqCreatureOrGOId1`=29124, `ReqSpellCast1`=54191 WHERE `entry`=12805 LIMIT 1;
