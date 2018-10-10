-- Various fixes by Monad in Worgen Zone

-- fix - corect models for captive worgen 36698 26797 36798
UPDATE creature_template SET modelid1=30294 AND modelid2=30293 AND modelid3=30295 AND modelid4=0 WHERE entry IN (36698);
UPDATE creature_template SET modelid1=30295 AND modelid2=30294 AND modelid3=30293 AND modelid4=0 WHERE entry IN (36698);
UPDATE creature_template SET modelid1=30293 AND modelid2=30295 AND modelid3=30294 AND modelid4=0 WHERE entry IN (36698);

-- fix - corect phase shifts duskhaven
DELETE FROM `spell_area` WHERE `spell`=68481 AND `area`=4786 AND `quest_start`=14375 AND `aura_spell`=0 AND `teamId`=-1 AND `racemask`=0 AND `gender`=2;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `teamId`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`) 
VALUES (68481, 4786, 14375, 14321, 0, -1, 0, 2, 3, 64, 64);

DELETE FROM `spell_area` WHERE `spell`=68482 AND `area`=4786 AND `quest_start`=14321 AND `aura_spell`=0 AND `teamId`=-1 AND `racemask`=0 AND `gender`=2;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `teamId`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`) 
VALUES (68482, 4786, 14321, 0, 0, -1, 0, 2, 3, 64, 0);
