-- Fix Quest 11023 Bomb them Again Reputation
UPDATE `quest_template` SET `RewRepValue1`=0, `RewRepValue2`=0 WHERE `entry`=11023;