DELETE FROM creature WHERE id IN (34829);
REPLACE INTO creature (id, map, phaseId, position_x, position_y, position_z,
orientation, spawntimesecs, MovementType) VALUES
(34829, 1, 0, -360.739136, -3508.311279, 91.993134, 2.797112, 120, 0);

DELETE FROM creature_loot_template WHERE entry = 34829 and item = 46850;
REPLACE INTO creature_loot_template (entry, item, Chance, QuestRequired, MinCount,
MaxCount) VALUES
(34829, 46850, 79, 1, 1, 1);