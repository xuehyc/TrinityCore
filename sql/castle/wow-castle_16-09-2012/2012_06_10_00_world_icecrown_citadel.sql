-- Fix creature Ice Tomb / Eisgrab in Sindragosa encounter in instance / Instanz ICC Icecrown Citadel Eiskronenzitadelle
-- Add immunities to avoid being moved away (knockback in script)
UPDATE `creature_template` SET `mechanic_immune_mask` = 650853247 WHERE `entry` IN (36980, 38320, 38321, 38322);

-- Fix spell 69762 Unchained Magic / Entfesselte Magie debuff in Sindragosa encounter in instance / Instanz ICC Icecrown Citadel Eiskronenzitadelle
-- Add internal cooldown with 1 seconds, so multi-spell spells will only apply one stack of triggered spell 69766 (i.e. Chain Heal)
DELETE FROM `spell_proc_event` WHERE `entry` = 69762;
INSERT INTO `spell_proc_event` (entry, SchoolMask, SpellFamilyName, SpellFamilyMask0, SpellFamilyMask1, SpellFamilyMask2, procFlags, procEx, ppmRate, CustomChance, Cooldown) VALUES
(69762, 0, 0, 0, 0, 0, 81920, 0, 0, 0, 1);