-- Icecrown Citadel / ICC / Eiskronenzitadelle - Lich King
-- Fix NPC 37695, 37698 Drudge Ghouls / Ghoulsklave Shambling Horror / Torkelnder Schrecken, do not aggro on summon, since UNIT_FLAG_IMMUNE_TO_NPC is set
UPDATE `creature_template` SET `unit_flags` = 33344 WHERE `entry` IN (37695, 39309, 39310, 39311, 37698, 39299, 39300, 39301);
-- Fix NPC 36824, Spirit Warden / Geisteraufseher, should be tauntable
UPDATE `creature_template` SET `flags_extra` = 0 WHERE `entry` IN (36824, 39296);