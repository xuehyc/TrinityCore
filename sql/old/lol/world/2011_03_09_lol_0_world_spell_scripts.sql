-- add quest credit + target despawn (quest 12810)
DELETE FROM `spell_scripts` WHERE `id`=6509;
INSERT INTO `spell_scripts` VALUES 
(6509,0,0,8,29391,1,0,0,0,0,0),
(6509,0,0,18,0,0,0,0,0,0,0);
