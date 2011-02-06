#### Taunt Fix multiple Bosses ####

###  Karazhan ###
##   Attumen the Huntsman   ##
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '15550';
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '16151';
##   Moroes   ##
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '15687';
##   Maiden of Virtue   ##
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '16457';
##   Opera Event - Red Riding Hood - The Big Bad Wolf   ##
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '17521';
##   Opera Event - Romulo and Julianne   ##
-- No info
##   Opera Event - The Wizard of Oz   ##
-- No info
##   The Curator   ##
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '15691';
##   Terestian Illhoof   ##
-- not immune to taunt effects
##   Shade of Aran   ##
-- no info
##   Netherspite   ##
-- no info
##   Prince Malchezaar   ##
-- no info
##   Nightbane   ##
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '17225';
##   Trashmobs   ##
-- Skeletal Usher
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '16471';
-- Ethereal Thief
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '16544';


###  Magtheridon's Lair  ###
##   Magtheridon   ##
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '17257';
##   Trash Mobs
-- nothing


###  Gruul's Lair  ###
##   Highking Maulgar   ##
-- not immune to taunt effects
##   Gruul the Dragonkiller   ##
-- not immune to taunt effects
##   Trash Mobs   ##
-- nothing


###  Serpentshrine Caverns  ###
##   Hydross the Unstable   ##
-- + 32 	CREATURE_FLAG_EXTRA_NO_CRUSH 	Prohibits creature from dealing crushing blows
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256'|'32' WHERE `creature_template`.`entry` = '21216';
##   The Lurker Below   ##
-- not immune to taunt effects
##   Morogrim Tidewalker   ##
-- no info
##   Fathom-Lord Karathress   ##
-- no info
##   Leotheras the Blind   ##
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '21215';
##   Lady Vashj   ##
-- not immune to taunt effects
##   Trash Mobs   ##
-- nothing


###  Tempest Keep: The Eye  ###
##   Void Reaver   ##
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '19516';
##   High Astromancer Solarian   ##
-- no info
##   Al'ar   ##
-- not immune to taunt effects
##   Kael'thas Sunstrider Encounter   ##
--   Kael'thas
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '19622';
--   Lord Sanguinar
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '20060';
--   Grand Astromancer Capernian
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '20062';
--   Master Engineer Telonicus
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '20063';
--   Thaladred the Darkener
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '20064';
--   Phoenix
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '21362';
##   Trash Mobs   ##
-- nothing



###  Caverns of Time: Battle for Mount Hyjal  ###
##   Rage Winterchill   ##
-- no info
##   Anetheron   ##
-- Towering Infernal
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '17818';
-- no info for Anetheron
##   Kaz'rogal   ##
-- no info
##   Azgalor   ##
-- + 32 	CREATURE_FLAG_EXTRA_NO_CRUSH 	Prohibits creature from dealing crushing blows
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'32' WHERE `creature_template`.`entry` = '17842';
-- no info for taunt
##   Archimonde   ##
-- + 32 	CREATURE_FLAG_EXTRA_NO_CRUSH 	Prohibits creature from dealing crushing blows
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'32' WHERE `creature_template`.`entry` = '17968';
-- no info for taunt
##   Trash Mobs   ##
-- nothing


###  Black Temple  ###
##   High Warlord Naj'entus   ##
-- no info
##   Supremus   ##
-- + 32 	CREATURE_FLAG_EXTRA_NO_CRUSH 	Prohibits creature from dealing crushing blows
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'32' WHERE `creature_template`.`entry` = '22871';
-- no info for taunt
##   Shade of Akama   ##
-- no info
##   Teron Gorefiend   ##
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '22871';
##   Gurtogg Bloodboil   ##
-- no info
##   Reliquary of Souls   ##
-- no info
##   Mother Shahraz   ##
-- no info
##   Illidari Council   ##
-- no info
##   Illidan Stormrage   ##
-- no info
##   Trash Mobs   ##
-- Aqueous Lord
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '22878';
-- Dragonmaw Wyrmcaller
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '22960';
-- Draginmaw Sky Stalker
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '23030';
-- Dragonmaw Wind Reaver
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '23330';
-- Illidari Fearbringer
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '22954';
-- Wrathbone Flayer
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '22953';


###  Sunwell Plateau  ###
##   Kalecgos   ##
-- not immune to taunt
##   Brutallus   ##
-- not immune to taunt
##   Felmyst   ##
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|'256' WHERE `creature_template`.`entry` = '25038';
##   Eredar Twins   ##
-- no info
##   M'uru   ##
-- no info
##   Kil'jaeden   ##
-- no info
##   Trash Mobs   ##
-- nothing