-- Add missing pattern (Pattern: Sash of Ancient Power) to Large Sack of Ulduar Spoils
DELETE FROM item_loot_template WHERE entry = 45878 AND item = 45102;
INSERT INTO item_loot_template (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(45878, 45102, 0, 1, 1, 1, 1);

-- Update reference drop chances for MC/AQ Patterns to blizzlike values
UPDATE creature_loot_template SET ChanceOrQuestChance = 10 WHERE entry IN (11982, 11988, 12056, 12057, 12118, 12259, 12264) AND mincountOrRef = -34011; -- molten core
UPDATE creature_loot_template SET ChanceOrQuestChance = 10 WHERE entry IN (15263,15299,15509,15510,15511,15516,15517,15543,15544) AND mincountOrRef = -34045 AND groupid = 1; -- aq40
UPDATE creature_loot_template SET ChanceOrQuestChance = 8 WHERE entry IN (15339,15340,15341,15348,15369,15370) AND groupid = 1 AND mincountOrRef = -34024; -- aq20

-- Update Enchanting Formula (Boots - Surefooted) to guaranteed drop (as of Patch 3.1.0, see http://old.wowhead.com/item=22545#comments:id=684109)
UPDATE creature_loot_template SET ChanceOrQuestChance = 100 WHERE item = 22545 AND entry = 16472;
