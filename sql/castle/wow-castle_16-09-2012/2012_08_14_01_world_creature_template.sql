-- remove disease immunities for burning crusade dungeons. [by eli]
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` &~ 2097152 WHERE `entry` IN (
SELECT DISTINCT id FROM `creature` WHERE map IN
(557, -- Auchindoun: Mana-Tombs
 556, -- Auchindoun: Sethekk Halls
 555, -- Auchindoun: Shadow Labyrinth
 558, -- Auchindoun: Auchenai Crypts
 560, -- The Escape From Durnholde
 540, -- Hellfire Citadel: The Shattered Halls
 542, -- Hellfire Citadel: The Blood Furnace
 543, -- Hellfire Citadel: Ramparts
 545, -- Coilfang: The Steamvault
 546, -- Coilfang: The Underbog
 547, -- Coilfang: The Slave Pens
 552, -- Tempest Keep: The Arcatraz
 553, -- Tempest Keep: The Botanica
 554 -- Tempest Keep: The Mechanar
));