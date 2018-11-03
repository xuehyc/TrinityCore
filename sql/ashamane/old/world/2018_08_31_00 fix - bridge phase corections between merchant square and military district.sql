-- fix - bridge phase corections between merchant square and military district

DELETE FROM `spell_area` WHERE `spell`=59073 AND `area`=4755 AND `quest_start`=14078 AND `aura_spell`=0 AND `teamId`=-1 AND `racemask`=0 AND `gender`=2;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `teamId`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`) 
VALUES (59073, 4755, 14078, 14159, 0, -1, 0, 2, 3, 64, 64);
