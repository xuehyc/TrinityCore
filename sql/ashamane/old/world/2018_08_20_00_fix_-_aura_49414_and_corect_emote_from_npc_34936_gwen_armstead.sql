-- fix - corect emotes and aura 49414 from npc 34936 gwen armstead working
UPDATE `creature_addon` SET `emote`=375, `auras`=49414  WHERE `guid`=20556362;
DELETE FROM `spell_area` WHERE `spell`=49416 AND `area`=4756 AND `quest_start`=14078;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `teamId`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`) 
VALUES (49416, 4756, 14078, 14099, 0, -1, 0, 2, 3, 64, 10);

