DELETE FROM `trinity_string` WHERE entry IN (756,757,758,759,760,761,762,763,764,765,766,767,768,769,770,771,772,780,781);
REPLACE INTO `trinity_string` VALUES ('756', 'Battle begins!', '', '', '', '', '', '', '', 'Битва началась');
REPLACE INTO `trinity_string` VALUES ('757', '%s has successfully defended the fortress!', '', '', '', '', '', '', '', '');
REPLACE INTO `trinity_string` VALUES ('758', '%s has taken over the fortress!', '', '', '', '', '', '', '', '');
REPLACE INTO `trinity_string` VALUES ('759', 'The %s siege workshop has been damaged by the %s!', '', '', '', '', '', '', '', '');
REPLACE INTO `trinity_string` VALUES ('760', 'The %s siege workshop has been destroyed by the %s!', '', '', '', '', '', '', '', '');
REPLACE INTO `trinity_string` VALUES ('761', 'The %s tower has been damaged!', '', '', '', '', '', '', '', '%s башня повреждена');
REPLACE INTO `trinity_string` VALUES ('762', 'The %s tower has been destroyed!', '', '', '', '', '', '', '', '%s башня уничтожена!');
REPLACE INTO `trinity_string` VALUES ('763', 'Wintergrasp fortress is under attack!', '', '', '', '', '', '', '', '');
REPLACE INTO `trinity_string` VALUES ('764', 'Wintergrasp is now under the control of the %s.', '', '', '', '', '', '', '', '');
REPLACE INTO `trinity_string` VALUES ('765', 'Wintergrasp timer set to %s.', '', '', '', '', '', '', '', '');
REPLACE INTO `trinity_string` VALUES ('766', 'Wintergrasp battle started.', '', '', '', '', '', '', '', '');
REPLACE INTO `trinity_string` VALUES ('767', 'Wintergrasp battle finished.', '', '', '', '', '', '', '', '');
REPLACE INTO `trinity_string` VALUES ('768', 'Wintergrasp info: %s controlled. Timer: %s. Wartime: %s. Number of Players: (Horde: %u, Alliance: %u)', '', '', '', '', '', '', '', '');
REPLACE INTO `trinity_string` VALUES ('769', 'Wintergrasp outdoorPvP is disabled.', '', '', '', '', '', '', '', '');
REPLACE INTO `trinity_string` VALUES ('770', 'Wintergrasp outdoorPvP is enabled.', '', '', '', '', '', '', '', '');
REPLACE INTO `trinity_string` VALUES ('771', 'You have reached Rank 1: Corporal', '', '', '', '', '', '', '', 'Вы достигли Ранга 1: Капрал');
REPLACE INTO `trinity_string` VALUES ('772', 'You have reached Rank 2: First Lieutenant', '', '', '', '', '', '', '', 'Вы достигли Ранга 2: Лейтенант');
REPLACE INTO `trinity_string` VALUES ('780', 'Before the Battle of  Wintergrasp left 30 minutes!', '', '', '', '', '', '', '', 'До битвы на  Озере Ледяных Оков осталось 30 минут!');
REPLACE INTO `trinity_string` VALUES ('781', 'Before the Battle of  Wintergrasp left 10 minutes!', '', '', '', '', '', '', '', 'До битвы на  Озере Ледяных Оков осталось 10 минут!');
REPLACE INTO `trinity_string` VALUES ('782', 'The battle for Wintergrasp  has stopped! Not enough defenders. Wintergrasp Fortress remains  Attackers.', '', '', '', '', '', '', '', 'Битва за Озеро Ледяных Оков Остановлена. Не хватает защитников. Крепость переходит атакующей  стороне.');
REPLACE INTO `trinity_string` VALUES ('783', 'The battle for Wintergrasp  has stopped! Not enough attackers. Wintergrasp Fortress remains  Defenders.', '', '', '', '', '', '', '', 'Битва за Озеро Ледяных Оков Остановлена. Не хватает нападающих. Крепость остается защитникам.');

DELETE FROM `command` WHERE name IN ('wg','wg enable','wg start','wg status','wg stop','wg switch','wg timer');
REPLACE INTO `command` VALUES ('wg', '3', 'Syntax: .wg $subcommand.');
REPLACE INTO `command` VALUES ('wg enable', '3', 'Syntax: .wg enable [on/off] Enable/Disable Wintergrasp outdoorPvP.');
REPLACE INTO `command` VALUES ('wg start', '3', 'Syntax: .wg start\r\nForce Wintergrasp battle start.');
REPLACE INTO `command` VALUES ('wg status', '3', 'Syntax: .wg status\r\nWintergrasp info, defender, timer, wartime.');
REPLACE INTO `command` VALUES ('wg stop', '3', 'Syntax: .wg stop\r\nForce Wintergrasp battle stop (No rewards).');
REPLACE INTO `command` VALUES ('wg switch', '3', 'Syntax: .wg switch\r\nSwitchs Wintergrasp defender team.');
REPLACE INTO `command` VALUES ('wg timer', '3', 'Syntax: .wg timer $minutes\r\nChange the current timer. Min value = 1, Max value 60 (Wartime), 1440 (Not Wartime)');


/* Temp removed gameobject stopping you getting to the relic
* 60070 - [Wintergrasp Keep Collision Wall X:5396.209961 Y:2840.010010 Z:432.268005 MapId:571
* 60476 - [Doodad_WG_Keep_Door01_collision01 X:5397.109863 Y:2841.540039 Z:425.901001 MapId:571]*/
DELETE FROM gameobject WHERE id IN ('194323', '194162');

/* Titan Relic remove */
DELETE FROM `gameobject` WHERE `id`=192829;

-- Wintergrasp Turrets template and spawns
UPDATE creature_template SET faction_a=1732, faction_h=1735,`VehicleId`=116,spell1=51421, speed_walk = 0, speed_run = 0, RegenHealth = 0 WHERE entry=28366;
DELETE FROM `creature` WHERE `id` = 28366;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES
(28366, 571, 1, 1, 0, 0, 5149.2, 2820.29, 421.621, 3.18597, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5148.19, 2861.97, 421.63, 3.09957, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5132.23, 2748.04, 413.492, 3.15456, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5164.28, 2716.11, 413.492, 4.72535, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5131.63, 2934.92, 413.495, 3.20168, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5164.01, 2966.85, 413.718, 1.4609, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5248.92, 3047.62, 412.148, 3.18597, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5352.24, 3060.98, 421.102, 1.57983, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5281.62, 3079.25, 412.956, 1.4609, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5391.29, 3060.92, 419.616, 1.60732, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5266.42, 2976.64, 421.066, 3.1624, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5234.87, 2947.88, 420.881, 1.56412, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5236.14, 2733.26, 421.65, 4.69, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5266.15, 2704.83, 421.7, 3.17811, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5247.04, 2632.57, 413.403, 3.19774, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5278.36, 2600.29, 413.403, 4.68215, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5350.96, 2616.36, 421.243, 4.69392, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5391, 2616.18, 421.126, 4.65073, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5363.79, 2757.65, 421.629, 4.72927, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5322.03, 2757.13, 421.646, 4.72141, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5323.03, 2923.08, 421.646, 1.56018, 1800, 0, 0, 50000, 0, 0, 0),
(28366, 571, 1, 1, 0, 0, 5363.98, 2923.82, 421.708, 1.61516, 1800, 0, 0, 50000, 0, 0, 0);

-- Re-add removed wintergrasp doors
DELETE FROM `world`.`gameobject` WHERE `id` IN (191810, 190375);
INSERT INTO `world`.`gameobject` VALUES
(67135, 191810, 571, 1, 1, 5397.11, 2841.54, 425.901, 3.14159, 0, 0, 0, 1, 180, 0, 1),
(67259, 190375, 571, 1, 1, 5162.99, 2841.23, 410.162, -3.13286, 0, 0, 0, 1, 180, 0, 1);

/* Towers */
UPDATE `gameobject_template` SET `faction` = 0, `flags` = flags|6553600 WHERE `entry` IN (190356,190357,190358);

/* Teleport WG SPELLs*/
REPLACE INTO `spell_target_position` VALUES ('59096', '571', '5325.06', '2843.36', '409.285', '3.20278');
REPLACE INTO `spell_target_position` VALUES ('58632', '571', '5097.79', '2180.29', '365.61', '2.41');
REPLACE INTO `spell_target_position` VALUES ('58633', '571', '5026.80', '3676.69', '362.58', '3.94');

/* Defender's Portal Activate Proper Spell */
REPLACE INTO `spell_linked_spell` VALUES ('54640','54643','0','Defender\'s Portal Activate Proper Spell');

/*For wg antifly */
REPLACE INTO `spell_area` VALUES ('58730', '4197', '0', '0', '0', '0', '0', '2', '1');

/*Spirit healer FIX */
UPDATE creature_template SET npcflag=npcflag|32768 WHERE entry   IN (31841,31842);

/* Creature template */
UPDATE creature_template SET faction_A = '1802', faction_H = '1802' WHERE entry IN (30499,28312,28319);
UPDATE creature_template SET faction_A = '1801', faction_H = '1801' WHERE entry IN (30400,32629,32627);
UPDATE creature_template SET npcflag=npcflag|32768 WHERE entry   IN (31841,31842);

/* WG scriptname */
REPLACE INTO `outdoorpvp_template` VALUES ('7', 'outdoorpvp_wg', 'Wintergrasp');
UPDATE `creature_template` SET `ScriptName` = 'npc_demolisher_engineerer' WHERE `entry` IN (30400,30499);

/* spell target for build vehicles */
REPLACE INTO `conditions` VALUES ('13', '0', '56663', '0', '18', '1', '27852', '0', '0', '', null);
REPLACE INTO `conditions` VALUES ('13', '0', '56575', '0', '18', '1', '27852', '0', '0', '', null);
REPLACE INTO `conditions` VALUES ('13', '0', '61408', '0', '18', '1', '27852', '0', '0', '', null);
REPLACE INTO `conditions` VALUES ('13', '0', '56661', '0', '18', '1', '27852', '0', '0', '', null);