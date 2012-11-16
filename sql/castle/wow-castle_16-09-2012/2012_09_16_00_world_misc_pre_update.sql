-- Fix quest 11093, Hungrige Netherrochen/Hungry Nether Rays, change kill requirement
UPDATE `quest_template` SET `RequiredNpcOrGo2` = 23219 WHERE `Id`= 11093;

-- Fix creature 26271 Abgemagerter Mammutbulle/Emaciated Mammoth Bull, set attackable
UPDATE `creature_template` SET `unit_flags` = 33536 - 256 WHERE `entry` = 26271; 

-- Remove object 192568 Gal'darah Door in instance / Instanz Gun'drak, caused line of sight issues
DELETE FROM `gameobject` WHERE `id` = 192568;

-- Fix item 21910 Pattern: Spellfire Robe / Muster: Zauberfeuerrobe being dropped
-- by NPC 21537 Pathaleon the Calculator / Pathaleon der Kalkulator
-- instead item 21907 Muster: Arkanostoffrobe / Pattern: Arcanoweave Robe should be dropped
UPDATE `creature_loot_template` SET `item` = 21907 WHERE `item` = 21910 AND `entry` = 21537;
UPDATE `conditions` SET `SourceEntry` = 21907 WHERE `SourceEntry` = 21910 AND `SourceGroup` = 21537 AND `SourceTypeOrReferenceId` = 1;

-- Fix quest 13758 Eine würdige Waffe / A Worthy Weapon should be available to all alliance races
UPDATE `quest_template` SET `RequiredRaces` = 1101 WHERE `id` = 13758;

-- Fix quest 10776, Dissension Amongst the Ranks / Zwietracht in den Rängen
-- Give killcredit
UPDATE `creature_template` SET `KillCredit1` = 22051 WHERE `entry` = 19823;

UPDATE creature_template SET difficulty_entry_1=21599 WHERE entry=20912;/* link the boss in hero to the heroid of the boss*/
UPDATE creature_template SET difficulty_entry_1=21601 WHERE entry=21467;/* link the boss in normal to normal id of the boss*/
UPDATE creature_template SET unit_flags=832 WHERE entry=21599;/*Fix a problem that he wasnt attackable*/

-- Fix quest 13549, Männchen oder Weibchen? / Tails Up, by Tollmer
-- Remove the evadescript which stand in conflict with friendly faction
DELETE FROM `smart_scripts` WHERE `entryorguid` = 2932700 AND `id` = 3 AND `action_type` = 24;
-- Reset the unit_flags from the icebear which prevent targetting by player
UPDATE `creature_template` set `unit_flags` = 0 WHERE `entry` = 29319;
-- correct the numeration from the ids
UPDATE `smart_scripts` SET `id` = 3 WHERE `entryorguid` = 2932700 AND id = 4;