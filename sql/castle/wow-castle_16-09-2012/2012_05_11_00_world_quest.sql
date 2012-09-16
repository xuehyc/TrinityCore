-- Fix quests 13384 / 13385 Entscheidung im Auge der Ewigkeit / Heroische Entscheidung im Auge der Ewigkeit
-- Judgment at the Eye of Eternity / Heroic Judgment at the Eye of Eternity
-- put items 44650, 44651 Herz der Magie / Heart of Magic to regular loot
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (26094, 26097) AND `item` IN (44650, 44651);
INSERT INTO `gameobject_loot_template` (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(26094, 44650, -100, 1, 0, 1, 1),
(26097, 44651, -100, 1, 0, 1, 1);