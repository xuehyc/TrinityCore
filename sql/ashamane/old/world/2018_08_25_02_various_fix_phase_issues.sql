
-- fix - quest 14087 14159 14239 phase corections for applying and removeing phases 170 171 and 172 military district

DELETE FROM `spell_area` WHERE `spell`=59073 AND `area`=4757 AND `quest_start`=0 AND `aura_spell`=0 AND `teamId`=-1 AND `racemask`=0 AND `gender`=2;

DELETE FROM `spell_area` WHERE `spell`=59073 AND `area`=4756 AND `quest_start`=14078 AND `aura_spell`=0 AND `teamId`=-1 AND `racemask`=0 AND `gender`=2;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `teamId`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`) 
VALUES (59073, 4756, 14078, 14159, 0, -1, 0, 2, 3, 64, 64);

DELETE FROM `spell_area` WHERE `spell`=59073 AND `area`=4757 AND `quest_start`=14078 AND `aura_spell`=0 AND `teamId`=-1 AND `racemask`=0 AND `gender`=2;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `teamId`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`) 
VALUES (59073, 4757, 14078, 14159, 0, -1, 0, 2, 3, 64, 64);

DELETE FROM `spell_area` WHERE `spell`=59074 AND `area`=4757 AND `quest_start`=14159 AND `aura_spell`=0 AND `teamId`=-1 AND `racemask`=0 AND `gender`=2;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `teamId`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`) 
VALUES (59074, 4757, 14159, 14293, 0, -1, 0, 2, 3, 64, 64);

DELETE FROM `spell_area` WHERE `spell`=59087 AND `area`=4757 AND `quest_start`=14293 AND `aura_spell`=0 AND `teamId`=-1 AND `racemask`=0 AND `gender`=2;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `teamId`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`) 
VALUES (59087, 4757, 14293, 0, 0, -1, 0, 2, 3, 64, 0);
