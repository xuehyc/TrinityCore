-- Remove double spawns.
DELETE FROM `creature` WHERE `guid` IN (286835, 286870, 286871, 286891, 286905, 286929, 286957, 310806, 310807, 310848, 310853, 452642, 452644, 452650, 452664, 452665, 452666, 452671, 452673, 452681, 452675);

-- Proper template for Tauren defender.
UPDATE `creature` SET `id`=72559 WHERE `guid`=310850;

-- Make NPC sleep in bunker.
DELETE FROM `creature_addon` WHERE `guid` IN (452680);
INSERT INTO `creature_addon` VALUES (452680, 0, 0, 3, 0, 0, 0, 0, 0, 0, NULL);
