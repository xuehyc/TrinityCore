-- Instructor Hroegar Flag and Loot Fix
UPDATE world . creature_template SET mingold = '1111',maxgold = '3333' , faction_A ='14' , faction_H ='14' WHERE entry = '29915';

DELETE FROM `world`.`creature_loot_template` WHERE `entry` = '29915';
INSERT INTO `world`.`creature_loot_template` VALUES
('29915', '43297',   '1', '1', '0', '1', '1'),     -- Damaged Necklace
('29915', '41843', '-99', '1', '0', '1', '1'),     -- Key to Vaelen's Chains
('29915', '43089',  '98', '1', '0', '1', '1'),     -- Vrykul Bones
('29915', '33470',  '23', '1', '0', '1', '4'),     -- Frostweave Cloth
('29915', '43852',  '14', '1', '0', '1', '1'),     -- Thick Fur Clothing Scraps
('29915', '43851',  '14', '1', '0', '1', '1'),     -- Fur Clothing Scraps
('29915', '33454',   '4', '1', '0', '1', '1'),     -- Salted Venison
('29915', '33445',   '3', '1', '0', '1', '1'),     -- Honeymint Tea
('29915', '42422', '-14', '1', '0', '1', '1'),     -- Jotunheim Cage Key
('29915', '33447', '1.9', '1', '0', '1', '1');     -- Runic Healing Potion 


