-- Updates for the various NPCs in Yogg-Saron encounter.
UPDATE `creature_template` SET `minlevel`=83, `maxlevel`=83, `faction_A`=14, `faction_H`=14, `mindmg`=104, `maxdmg`=138, `attackpower`=252, `dmg_multiplier`=7.5, `unit_flags`=33554432|4|2, `InhabitType`=7, `ScriptName`='npc_yogg_saron_encounter_controller' WHERE `entry`=29224;
DELETE FROM `creature` WHERE `id`=29224;
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES (29224, 603, 1, 1, 0, 0, 1980.28, -25.5868, 329.397, 2.91365, 300, 0, 0, 7841, 0, 0, 0, 0, 0);
UPDATE `creature_template` SET `faction_A`=35, `faction_H`=35 WHERE `entry` IN (33134, 34332);
UPDATE `creature_template` SET `faction_A`=14, `faction_H`=14 WHERE `entry` IN (33288, 33955);
UPDATE `creature_template` SET `InhabitType`=4 WHERE `entry`=33134;
UPDATE `creature_template` SET `ScriptName`='npc_ominous_cloud' WHERE `entry`=33292;
UPDATE `creature_template` SET `ScriptName`='npc_guardian_of_yogg_saron' WHERE `entry`=33136;
UPDATE `creature_template` SET `ScriptName`='npc_yogg_saron_tentacle' WHERE `entry` IN (33966,33985,33983);
UPDATE `creature_template` SET `ScriptName`='npc_descend_into_madness' WHERE `entry`=34072;
UPDATE `creature_template` SET `ScriptName`='boss_brain_of_yogg_saron' WHERE `entry`=33890;
UPDATE `creature_template` SET `ScriptName`='boss_yogg_saron' WHERE `entry`=33288;
UPDATE `creature_template` SET `ScriptName`='npc_influence_tentacle' WHERE `entry` IN (33716,33720,33719,33717,33433,33567);
UPDATE `creature_template` SET `ScriptName`='boss_sara' WHERE `entry`=33134;
UPDATE `creature_template` SET `ScriptName`='npc_immortal_guardian' WHERE `entry`=33988;
UPDATE `creature_template` SET `ScriptName`='npc_support_keeper' WHERE `entry` in (33410,33411,33412,33413);
UPDATE `creature_template` SET `modelid1`=11686, `modelid2`=11686, `ScriptName`='npc_sanity_well' WHERE `entry`=33991;
UPDATE `creature_template` SET `modelid1`=16946, `modelid2`=16946, `ScriptName`='npc_death_orb' WHERE `entry`=33882;
UPDATE `creature_template` SET `modelid1`=17612, `modelid2`=17612, `ScriptName`='npc_death_ray' WHERE `entry`=33881;
UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80, `ScriptName`='npc_laughting_skull' WHERE entry=33990;
UPDATE `creature_template` SET `modelid1`=15880, `modelid2`=15880 WHERE `entry`=33990;
-- Keeper helpers
UPDATE `creature_template` SET `npcflag`=`npcflag`|1, `ScriptName`='npc_keeper_help' WHERE `entry` IN (33241,33244,33242,33213);
DELETE FROM `creature` WHERE `id` IN (33213,33241,33242,33244);
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(33213, 603, 2, 1, 0, 0, 1939.94, -90.49, 338.46, 1.04118, 300, 0, 0, 14433076, 0, 0, 0, 0, 0),
(33241, 603, 2, 1, 0, 0, 2037.31, 25.6417, 338.415, 3.90552, 300, 0, 0, 14433076, 0, 0, 0, 0, 0),
(33242, 603, 2, 1, 0, 0, 2037.27, -73.9782, 338.415, 2.45097, 300, 0, 0, 14433076, 0, 0, 0, 0, 0),
(33244, 603, 2, 1, 0, 0, 1938.16, 43.9725, 338.46, 5.30923, 300, 0, 0, 14433076, 0, 0, 0, 0, 0);

UPDATE `creature_template` SET `minlevel`=80, `maxlevel`=80 WHERE `entry`=33943;
UPDATE `gameobject_template` SET `ScriptName`='go_flee_to_surface' WHERE `entry`=194625;
UPDATE `item_template` SET `ScriptName`='item_unbound_fragments_of_valanyr' WHERE `entry`=45896;
UPDATE `creature_template` SET `RegenHealth`=0 WHERE `entry` IN (33134,34332,33890,33954); -- No health regeneration - tentacles.

DELETE FROM `gameobject` WHERE `id`=194625;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES 
(194625, 603, 3, 1, 2001.4, -59.66, 245.07, 0, 0, 0, 0, 0, 60, 100, 1),
(194625, 603, 3, 1, 1941.61, -25.88, 244.98, 0, 0, 0, 0, 0, 60, 100, 1),
(194625, 603, 3, 1, 2001.18, 9.409, 245.24, 0, 0, 0, 0, 0, 60, 100, 1);

DELETE FROM `spell_script_names` WHERE `spell_id` IN (64466,64139,64143,64133,63120,64174,64172,63802,64164,64168,62670,62671,62702,62650);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(64466,'spell_empowering_shadows'),             -- Heal Trigger for Empowering Shadows
(64139,'spell_summon_tentacle_position'),       -- Correct Summon Position of Tentacle
(64143,'spell_summon_tentacle_position'),
(64133,'spell_summon_tentacle_position'),
(63120,'spell_insane_death_effekt'),            -- Insane Death trigger on Remove
(64174,'spell_hodir_protective_gaze'),          -- Hodir Secound Aura Script
(64172,'spell_titanic_storm_targeting'),        -- Needed for Titanic Storm, Script for Target have Weakened Aura
(63802,'spell_brain_link_periodic_dummy'),      -- Trigger Effekt on Near Player with Brain Link
(64164,'spell_lunatic_gaze_targeting'),
(64168,'spell_lunatic_gaze_targeting'),         -- Script for Target Faces Caster
(62670,'spell_keeper_support_aura_targeting'),  -- Auras shouldn't hit other friendly NPCs
(62671,'spell_keeper_support_aura_targeting'),
(62702,'spell_keeper_support_aura_targeting'),
(62650,'spell_keeper_support_aura_targeting');

DELETE FROM `conditions` WHERE SourceEntry IN (64184, 63882, 63886, 64172, 64465, 65209);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(13, 0, 64184, 0, 0, 18, 0, 1, 33288, 0, 0, 0, '', 'Effekt on YoggSaron'), -- Create Val'anyr on Yogg-Saron
(13, 0, 63882, 0, 0, 18, 0, 1, 33882, 0, 0, 0, '', 'Effekt on Death Orb'), -- Deathray Effekt on Death Orb
(13, 0, 63886, 0, 0, 18, 0, 1, 33882, 0, 0, 0, '', 'Effekt on Death Orb'),
(13, 0, 64172, 0, 0, 18, 0, 1, 33988, 0, 0, 0, '', 'Effekt only for Immortal Guardians'), -- Condition because NPCs need this else no hit
(13, 0, 64465, 0, 0, 18, 0, 1, 33988, 0, 0, 0, '', 'Effekt only for Immortal Guardians'),
(13, 0, 65209, 0, 0, 18, 0, 1, 33136, 0, 0, 0, '', 'Effekt only for Guardian of YoggSaron'), -- Second Damage Effekt of ShadowNova only on other Guardians or Sara
(13, 0, 65209, 0, 0, 18, 0, 1, 33134, 0, 0, 0, '', 'Effekt only for Sara');

-- Missing Says Vision
UPDATE `script_texts` SET `npc_entry`=33134 WHERE `npc_entry`=33288 AND `entry` IN (-1603330,-1603331,-1603332,-1603333);
UPDATE `script_texts` SET `content_default`='Help me! Please get them off me!' WHERE `npc_entry`=33134 AND `entry`=-1603310;
UPDATE `script_texts` SET `content_default`='What do you want from me? Leave me alone!' WHERE `npc_entry`=33134 AND `entry`=-1603311;
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1603360 AND -1603342;
INSERT INTO `script_texts` VALUES 
(33535, -1603359, 'It is a weapon like no other. It must be like no other.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15610, 0, 0, 0, 'Malygos DragonSoulVision_Say'),
(33523, -1603356, 'It is done... All have been given that which must be given. I now seal the Dragon Soul forever...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15631, 0, 0, 0, 'Neltharion DragonSoulVision_Say1'),
(33495, -1603357, 'That terrible glow... should that be?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15702, 0, 0, 0, 'Ysera DragonSoulVision_Say'),
(33523, -1603358, 'For it to be as it must, yes.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15632, 0, 0, 0, 'Neltharion DragonSoulVision_Say2'),
(33288, -1603355, 'He will learn... no king rules forever, only death is eternal!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15767, 0, 0, 0, 'YoggSaron LichKingVision_Say2'),
(33288, -1603354, 'Yrr n\'lyeth... shuul anagg!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15766, 0, 0, 0, 'YoggSaron LichKingVision_Say1'),
(33441, -1603353, 'I will break you as I broke him.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15599, 0, 0, 0, 'TheLichKing LichKingVision_Say2'),
(33442, -1603351, 'Arrrrrrgh!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15470, 1, 0, 0, 'ImmolatedChampion LichKingVision_Say1'),
(33442, -1603352, 'I\'m not afraid of you!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15471, 0, 0, 0, 'ImmolatedChampion LichKingVision_Say2'),
(33436, -1603348, 'The orc leaders agree with your assessment.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15541, 0, 0, 0, 'Garona KingLlaneVision_Say4'),
(33288, -1603349, 'Your petty quarrels only make me stronger!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15764, 0, 0, 0, 'YoggSaron KingLlaneVision_Say3'),
(33288, -1603360, 'His brood learned their lesson before too long, you shall soon learn yours!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15765, 0, 0, 0, 'YoggSaron DragonSoulVision_Say1'),
(33441, -1603350, 'Your resilience is admirable.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15598, 0, 0, 0, 'TheLichKing LichKingVision_Say1'),
(33288, -1603346, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15763, 0, 0, 0, 'YoggSaron KingLlianeVision_Say2'),
(33437, -1603347, 'We will hold until the reinforcements come. As long as men with stout hearts are manning the walls and throne Stormwind will hold.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15585, 0, 0, 0, 'KingLlane KingLlaneVision_Say'),
(33436, -1603344, 'Gul\'dan is bringing up his warlocks by nightfall. Until then, the Blackrock clan will be trying to take the Eastern Wall.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15540, 0, 0, 0, 'Garona KingLlaneVision_Say3'),
(33288, -1603345, 'A thousand deaths... or one murder.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15762, 0, 0, 0, 'YoggSaron KingLlaneVision_Say1'),
(33436, -1603342, 'Bad news sire.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15538, 0, 0, 0, 'Garona KingLlaneVision_Say1'),
(33436, -1603343, 'The clans are united under Blackhand in this assault. They will stand together until Stormwind has fallen.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15539, 0, 0, 0, 'Garona KingLlaneVision_Say2');
