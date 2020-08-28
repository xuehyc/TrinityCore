--Val'anyr -- http://www.wowhead.com/item=46017/valanyr-hammer-of-ancient-kings#comments:id=705194

-- Need convert to `spell_proc` table
/*
DELETE FROM `spell_proc_event` WHERE `entry` IN (64411, 64415);
INSERT INTO `spell_proc_event` VALUES (64411, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `spell_proc_event` VALUES (64415, 0, 0, 0, 0, 0, 0, 524288, 0, 0, 45000);
*/