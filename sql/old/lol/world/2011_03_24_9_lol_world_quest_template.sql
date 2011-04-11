-- Fix Reputation for Quest 11023 Bomb them again
UPDATE quest_template SET RewRepValueID1=7 WHERE entry=11023;
UPDATE quest_template SET RewRepValueID2=7 WHERE entry=11023;
