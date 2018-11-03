-- Fix by Obivion from SPP Community
-- Remove Fel Iron entries from prospecting loot table, then readd based on Adamantite Ore prospecting loot table
-- Fel Iron 95% green gem, 5% blue gem, Adamantite 90% green, 10% blue gem, 100& adamantite powder

DELETE FROM `prospecting_loot_template` WHERE `Entry` = 23425;
INSERT INTO `prospecting_loot_template` (`Entry`,`Item`,`Reference`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`) VALUES

(23425,1,23424,90,0,1,1,1,1), -- 90% chance green gem
(23425,2,23425,10,0,1,1,1,1), -- 10% chance blue gem
(23425,24243,0,100,0,1,0,1,1) -- 100% chance adamantite powder