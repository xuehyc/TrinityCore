-- Remove invalid event NPC spawn.
DELETE FROM `creature` WHERE `guid`=134677;

-- Proper Rezlak spawn.
INSERT INTO `creature` VALUES (134677, 3293, 1, 0, 0, 0, 0, 0, 0, -1, 0, 0, 1000.16, -4413.57, 14.446, 5.2673, 300, 0, 0, 1004, 0, 0, 0, 0, 0, 0, 0, '', 0);
