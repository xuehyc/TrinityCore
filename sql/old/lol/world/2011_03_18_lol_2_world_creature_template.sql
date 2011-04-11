-- Instructor Hroegar Flag and Loot Fix
SET @NPC = 29915;
UPDATE creature_template SET mingold = 1111,maxgold = 3333 , faction_A = 14 , faction_H =14 WHERE entry = @NPC;
DELETE FROM creature_loot_template WHERE entry = @NPC;
INSERT INTO creature_loot_template VALUES
(@NPC, 43297, 1, 1, 0, 1, 1),       -- Damaged Necklace
(@NPC, 41843, -99, 1, 0, 1, 1),     -- Key to Vaelen's Chains    
(@NPC, 43089, 98, 1, 0, 1, 1),      -- Vrykul Bones
(@NPC, 33470, 23, 1, 0, 1, 4),      -- Frostweave Cloth
(@NPC, 43852, 14, 1, 0, 1, 1),      -- Thick Fur Clothing Scraps
(@NPC, 43851, 14, 1, 0, 1, 1),      -- Fur Clothing Scraps
(@NPC, 33454, 4, 1, 0, 1, 1),       -- Salted Venison
(@NPC, 33445, 3, 1, 0, 1, 1),       -- Honeymint Tea
(@NPC, 42422, -14, 1, 0, 1, 1),     -- Jotunheim Cage Key
(@NPC, 33447, 1.9, 1, 0, 1, 1);     -- Runic Healing Potion 