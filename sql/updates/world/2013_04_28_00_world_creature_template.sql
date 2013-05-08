-- Unlock Halls of Origination
DELETE FROM `disables` WHERE `entry`=644;
-- Disable bug NPC Temple Swiftstalker
-- DELETE FROM `creature` WHERE `id`=48139;
-- DELETE FROM `creature` WHERE `id`=49307;
DELETE FROM `creature` WHERE `id`=48139;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(15453704, 48139, 644, 3, 1, 0, 0, -843.941, 493.849, 53.9279, 3.08318, 86400, 0, 0, 0, 0, 0, 0, 0, 0),
(15453703, 48139, 644, 3, 1, 0, 0, -733.621, 463.452, 67.1882, 0.00126791, 86400, 0, 0, 0, 0, 0, 0, 0, 0),
(15453702, 48139, 644, 3, 1, 0, 0, -476.949, 369.776, 95.7385, 3.09345, 86400, 0, 0, 0, 0, 0, 0, 0, 0);

-- Script + Loot Boss Ammunae
UPDATE `creature_loot_template` SET `lootmode`='1' WHERE `entry`='39731'; -- Nomal
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry`='39731';
UPDATE `creature_template` SET `ScriptName`='boss_ammunae' WHERE `entry`='39731';
UPDATE `creature_loot_template` SET `lootmode`='1' WHERE `entry`='48715'; -- HC
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry`='48715';

UPDATE `creature_template` SET `ScriptName`='mob_flore' WHERE `entry`='40592';


-- Script + Loot Boss Anraphet
UPDATE `creature_loot_template` SET `lootmode`='1' WHERE `entry`='39788'; -- Nomal
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry`='39788';
UPDATE `creature_template` SET `ScriptName`='boss_anraphet' WHERE `entry`='39788';
UPDATE `creature_loot_template` SET `lootmode`='1' WHERE `entry`='48902'; -- HC
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry`='48902';

UPDATE `creature_template` SET `ScriptName`='npc_alpha_beam' WHERE `entry`='41144';


-- Script + Loot Boss Temple Guardian Anhuur
UPDATE `creature_loot_template` SET `lootmode`='1' WHERE `entry`='39425'; -- Nomal
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry`='39425';
UPDATE `creature_template` SET `ScriptName`='boss_temple_guardian_anhuur' WHERE `entry`='39425';
UPDATE `creature_loot_template` SET `lootmode`='1' WHERE `entry`='49262'; -- HC
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry`='49262';

UPDATE `creature_template` SET `ScriptName`='mob_viper' WHERE `entry`='39444';
UPDATE `gameobject_template` SET `ScriptName`='go_beacon_of_light' WHERE `entry`='206506';


-- Script + Loot Boss Earthrager Ptah
UPDATE `creature_loot_template` SET `lootmode`='1' WHERE `entry`='39428'; -- Nomal
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry`='39428';
UPDATE `creature_template` SET `ScriptName`='boss_ptah' WHERE `entry`='39428';
UPDATE `creature_loot_template` SET `lootmode`='1' WHERE `entry`='48714'; -- HC
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry`='48714';


-- Script + Loot Boss Isiset
UPDATE `creature_loot_template` SET `lootmode`='1' WHERE `entry`='39587'; -- Nomal
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry`='39587';
UPDATE `creature_template` SET `ScriptName`='boss_isiset' WHERE `entry`='39587';
UPDATE `creature_loot_template` SET `lootmode`='1' WHERE `entry`='48710'; -- HC
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry`='48710';


-- Script + Loot Boss Rajh
UPDATE `creature_loot_template` SET `lootmode`='1' WHERE `entry`='39378'; -- Nomal
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry`='39378';
UPDATE `creature_template` SET `ScriptName`='boss_rajh' WHERE `entry`='39378';
UPDATE `creature_loot_template` SET `lootmode`='1' WHERE `entry`='48815'; -- HC
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry`='48815';

UPDATE `creature_template` SET `ScriptName`='mob_solar_wind' WHERE `entry`='39634';
UPDATE `creature_template` SET `ScriptName`='mob_solar_wind' WHERE `entry`='39635';
UPDATE `creature_template` SET `ScriptName`='mob_solar_wind' WHERE `entry`='47922';
UPDATE `creature_template` SET `ScriptName`='mob_solar_wind' WHERE `entry`='48788';


-- Script + Loot Boss Setesh
UPDATE `creature_loot_template` SET `lootmode`='1' WHERE `entry`='39732'; -- Nomal
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry`='39732';
UPDATE `creature_template` SET `ScriptName`='boss_setesh' WHERE `entry`='39732';
UPDATE `creature_loot_template` SET `lootmode`='1' WHERE `entry`='48776'; -- HC
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry`='48776';


-- Script Element Boss
UPDATE `creature_template` SET `ScriptName`='mob_gardien_dair' WHERE `entry`='39803';

UPDATE `creature_template` SET `ScriptName`='mob_gardien_de_flammes' WHERE `entry`='39800';

UPDATE `creature_template` SET `ScriptName`='mob_gardien_de_terre' WHERE `entry`='39801';



-- NPC 
UPDATE `creature_template` SET `ScriptName`='mob_lancelombre_du_temple' WHERE `entry`='48141';

UPDATE `creature_template` SET `ScriptName`='mob_traqueur_veloce_du_temple' WHERE `entry`='48139';

UPDATE `creature_template` SET `ScriptName`='mob_lanceur_de_runes_du_temple' WHERE `entry`='48140';

UPDATE `creature_template` SET `ScriptName`='mob_sculptefeu_du_temple' WHERE `entry`='48143';

UPDATE `creature_template` SET `ScriptName`='mob_scarabee_caustique' WHERE `entry`='40310';

UPDATE `creature_template` SET `ScriptName`='mob_glisseur_venimeux' WHERE `entry`='39440';

UPDATE `creature_template` SET `ScriptName`='mob_horreur_os_poussiere' WHERE `entry`='40808';

UPDATE `creature_template` SET `ScriptName`='mob_horreur_os_poussiere' WHERE `entry`='40787';

UPDATE `creature_template` SET `ScriptName`='mob_horreur_os_poussiere' WHERE `entry`='40450';

UPDATE `creature_template` SET `ScriptName`='mob_tourmenteur_os_poussiere' WHERE `entry`='40311';

UPDATE `creature_template` SET `ScriptName`='mob_chercheur_du_vide' WHERE `entry`='41371';

UPDATE `creature_template` SET `ScriptName`='mob_chercheur_du_vide' WHERE `entry`='41148';

UPDATE `creature_template` SET `ScriptName`='mob_seigneur_du_vide' WHERE `entry`='41364';

UPDATE `creature_template` SET `ScriptName`='mob_anomalie_spatiale' WHERE `entry`='40170';

UPDATE `creature_template` SET `ScriptName`='mob_animateur_de_flux' WHERE `entry`='40033';

UPDATE `creature_template` SET `ScriptName`='mob_serviteur_solegrace' WHERE `entry`='39366';

UPDATE `creature_template` SET `ScriptName`='mob_fee_solegrace' WHERE `entry`='39369';

UPDATE `creature_template` SET `ScriptName`='mob_petite_fee_solegrace' WHERE `entry`='39370';

UPDATE `creature_template` SET `ScriptName`='mob_porte_parole_solegrace' WHERE `entry`='39373';

UPDATE `creature_template` SET `ScriptName`='mob_nymphe_gardienne' WHERE `entry`='40715';

UPDATE `creature_template` SET `ScriptName`='mob_liane_vivante' WHERE `entry`='40668';

UPDATE `creature_template` SET `ScriptName`='mob_spore_en_bourgeon' WHERE `entry`='40669';
