-- [Ulduar]{Flame Leviathan}
-- Scripts update/register for NPCs, areatriggers and spells.

-- Part 1: Creatures. I've renamed them, since they are no bosses, as named before.
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~33554432 WHERE `entry`=33067;
UPDATE `creature_template` SET `ScriptName`='npc_flame_leviathan_seat' WHERE `entry`=33114;
UPDATE `creature_template` SET `ScriptName`='npc_flame_leviathan_defense_turret' WHERE `entry`=33142;
UPDATE `creature_template` SET `ScriptName`='npc_flame_leviathan_defense_cannon' WHERE `entry`=33139;
UPDATE `creature_template` SET `ScriptName`='npc_flame_leviathan_overload_device' WHERE `entry`=33143;
UPDATE `creature_template` SET `ScriptName`='npc_flame_leviathan_safety_container' WHERE `entry`=33218; 
UPDATE `creature_template` SET `ScriptName`='npc_liquid_pyrite' WHERE `entry`=33189;
UPDATE `creature_template` SET `ScriptName`='npc_freya_ward_of_life' WHERE `entry`=34275;
-- Part 1.1: Mimirons Inferno Bunny - it should walk around.
DELETE FROM `waypoints` WHERE `entry`=33370;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(33370, 1, 266.689, -33.391, 409.99, 'Mimirons Inferno - Waypoint of dummy'), 
(33370, 2, 379.158, -33.318, 409.81, 'Mimirons Inferno - Waypoint of dummy 2'), 
(33370, 3, 266.611, -133.387, 409.81, 'Mimirons Inferno - Waypoint of dummy 3'), 
(33370, 4, 158.411, -33.311, 409.81, 'Mimirons Inferno - Waypoint of dummy 4'), 
(33370, 5, 266.699, 66.632, 409.81, 'Mimirons Inferno - Waypoint of dummy 5');

-- Part 2: Areatrigger. These are the triggers at the repair stations (194261,194262).
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5369, 5423);
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (5369, 'at_RX_214_repair_o_matic_station');
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (5423, 'at_RX_214_repair_o_matic_station');

-- Part 3: Updates for achievement criterias... to avoid DISTINCT-selection during load :s
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_unbroken_25' WHERE `criteria_id`=10045 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_shutout_25' WHERE  `criteria_id`=10055 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_three_car_garage_chopper_25' WHERE `criteria_id`=10049 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_three_car_garage_siege_25' WHERE `criteria_id`=10050 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_three_car_garage_demolisher_25' WHERE  `criteria_id`=10051 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_orbital_bombardment_25' WHERE `criteria_id`=10059 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_orbital_devastation_25' WHERE `criteria_id`=10060 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_nuked_from_orbit_25' WHERE `criteria_id`=10061 AND `type`=11;
UPDATE `achievement_criteria_data` SET `ScriptName`='achievement_orbit_uary_25' WHERE `criteria_id`=10219 AND `type`=11;

-- Part 4: Spells
DELETE FROM `spell_script_names` WHERE `spell_id` IN (64979, 65044, 62907, 63847, 64677);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(64979, 'spell_anti_air_rocket'),
(65044, 'spell_leviathan_blaze_flames_effect'),
(62907, 'spell_freyas_ward_summon'),
(63847, 'spell_leviathan_flame_vents'),
(64677, 'spell_shield_generator');
-- Part 4.1: Renamed - the resulting effect is called "Pursued", not "Pursue". Period.
UPDATE `spell_script_names` SET `ScriptName`='spell_pursued' WHERE `spell_id`=62374;

-- Part 5: Game-objects: Replaced them if position is incorrect.
DELETE FROM `gameobject` WHERE `id` IN (194261, 194262);
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES 
(194261, 603, 3, 1, 130.553, -128.063, 409.804, 2.87979, 0, 0, 0, 1, 180, 255, 1),
(194261, 603, 3, 1, 138.516, 56.1078, 409.804, 2.87979, 0, 0, 0, 1, 180, 255, 1),
(194262, 603, 3, 1, 131.895, -128.264, 409.804, 0, 0, 0, 0, 1, 180, 255, 1),
(194262, 603, 3, 1, 139.857, 55.9064, 409.804, 0, 0, 0, 0, 1, 180, 255, 1);

-- Part 6: The salvaged vehicles should not regenerate health.
UPDATE `creature_template` SET `RegenHealth`=0 WHERE `entry` IN (33060, 33062, 34045, 33109);