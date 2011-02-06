-- Add missing loot for quest: Searing Roc Feathers (13914/13905)
-- Data from WoWhead
REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES
(5430, 46381, -40, 0, 1, 1, 0, 0, 0);

-- Add missing loot for quest: Gorishi Grub (13917/13903)
-- Data from WoWArmory
SET @item :=46380; -- Silithid Meat
REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES
(6552, @item, -100, 0, 1, 1, 0, 0, 0),
(6551, @item, -100, 0, 1, 1, 0, 0, 0),
(6553, @item, -100, 0, 1, 1, 0, 0, 0),
(6555, @item, -100, 0, 1, 1, 0, 0, 0),
(6554, @item, -100, 0, 1, 1, 0, 0, 0);

-- Add missing loot for quest: Hungry, Hungry Hatchling (13915)
-- Data from UDB-Database
SET @item :=46367; -- Fresh Dinosaur Meat
REPLACE INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES
(6502, @item, -100, 0, 1, 1, 0, 0, 0),
(6503, @item, -100, 0, 1, 1, 0, 0, 0),
(6501, @item, -100, 0, 1, 1, 0, 0, 0),
(6504, @item, -100, 0, 1, 1, 0, 0, 0),
(9163, @item, -100, 0, 1, 1, 0, 0, 0),
(9164, @item, -100, 0, 1, 1, 0, 0, 0),
(9167, @item, -100, 0, 1, 1, 0, 0, 0),
(9166, @item, -100, 0, 1, 1, 0, 0, 0),
(9165, @item, -100, 0, 1, 1, 0, 0, 0),
(9162, @item, -100, 0, 1, 1, 0, 0, 0);

