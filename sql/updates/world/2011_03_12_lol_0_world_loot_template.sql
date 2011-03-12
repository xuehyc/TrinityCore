-- Skinning Group for Engineering no Blizz dropchance
-- http://www.wowwiki.com/Salvage
DELETE FROM `skinning_loot_template` WHERE `entry` = 90001;
INSERT INTO `skinning_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
	(90001, 49050, 3, 1, 1, 1, 1),      -- Schematic: Jeeves
	(90001, 36812, 12, 1, 1, 1, 3),     -- Ground Gear
	(90001, 41337, 12, 1, 1, 1, 3),     -- Whizzed-Out Gizmo
	(90001, 42930, 12, 1, 1, 1, 3),     -- Crooked Cog
	(90001, 41338, 12, 1, 1, 1, 3),     -- Sprung Whirlygig
	(90001, 42931, 12, 1, 1, 1, 3),     -- Toothless Gear
	(90001, 39683, 7.4, 1, 1, 1, 2),    -- Froststeel Tube
	(90001, 39684, 7.4, 1, 1, 1, 1),    -- Hair Trigger
	(90001, 39681, 7.4, 1, 1, 1, 3),    -- Handful of Cobalt Bolts
	(90001, 39682, 7.4, 1, 1, 1, 2),    -- Overcharge Capacitor
	(90001, 39690, 7.4, 1, 1, 1, 1);    -- Volatile Blasting Trigger

-- Adding Skinloot to Creatures 
UPDATE `creature_template` SET `skinloot` = 90001 WHERE `entry` IN (
29724, -- Library Guardian
25793, -- 55-D Collect-a-tron
25758, -- Defendo-tank 66D
32500, -- Dirkee
25814, -- Fizzcrank Mechagnome
32358, -- Fumblub Gearwind
29389, -- Mechagnome Laborer
25766, -- Rig Hauler AC-9
25752, -- Scavenge-bot 004-A8
25792, -- Scavenge-bot 005-B6
25753, -- Sentry-bot 57-K
29861, -- Stormforged Eradicator
29382, -- Stormforged Reaver
29380); -- Stormforged War Golem