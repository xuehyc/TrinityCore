-- Fix by Obivion
-- Remove northrend entries from prospecting loot table, then add with correct reference_loot_table entries

DELETE FROM `prospecting_loot_template` WHERE `Entry` IN (36909,36912,36910);
INSERT INTO `prospecting_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`) VALUES

-- Cobalt Ore 36909
(36909,1,36920,95,0,1,1,1,1), -- 95% chance green gems
(36909,2,36918,5,0,1,1,1,1), -- 5% chance blue gem


-- Saronite Ore 36912
(36912,1,36920,85,0,1,1,1,1), -- 85% chance green gems
(36912,2,36918,15,0,1,1,1,1), -- 15% chance blue gems

-- Titanium Ore 36910
(36910,1,36920,75,0,1,1,1,1), -- 75% chance green gems
(36910,2,36918,25,0,1,1,1,1), -- 25% chance blue gems
(36910,3,36919,20,0,1,0,1,1), -- 20% chance purple gems
(36910,46849,0,57,0,1,0,1,5) -- 75% chance adamantite powder

-- Reference Information

-- Possible reference_loot_template 36920 (MaxCount 1),
-- 36929 Hyge Citrine
-- 36926 Shadow Crystal
-- 36917 Bloodstone
-- 36923 Chalcedony
-- 36932 Dark Jade
-- 36920 Sun Crystal

-- Possible reference_loot_template 36918 (MaxCount 1)
-- 36930 Monarch Topaz
-- 36933 Forest Emerald
-- 36924 Sky Sapphire
-- 36921 Autumn's Glow
-- 36918 Scarlet Ruby
-- 36927 Twilight Opal

-- 46849 Titanium Powder (Not in or needed in reference_loot_template) 

-- Possible reference_loot_template 36919 (MaxCount 1)
-- 36925 Majestic Zircon
-- 36931 Ametrine
-- 3619 Cardinal Ruby
-- 36928 Dreadstone
-- 36934 Eye of Zul
-- 36922 King's Amber