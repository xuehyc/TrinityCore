-- Fixes the quest 12920 Catching up with Brann / Brann einholen in Storm Peak / Sturmgipfel (by Tollmer)
-- Spawns Brann and gives a killcredit for the quest automatically on item usage
DELETE FROM `spell_scripts` WHERE `id` = 61122;
INSERT INTO `spell_scripts` (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(61122,0,0,10,29579,180000,0,0,0,0,0),
(61122,0,0,8,29579,0,0,0,0,0,0);