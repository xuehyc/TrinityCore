-- Fix quest 10866 Zuluhed der Geschlagene, Zuluhed the Whacked, Befreien von Karynaku auf Gameobjectbenutzung umgeleitet
UPDATE `quest_template` SET `ReqCreatureOrGoId1` = -185156, `ReqSpellCast1` = 0 WHERE `entry` = 10866;


-- Fix a lot of quests - forgotten * 100 multiplier by TrinityDB
UPDATE `quest_template` SET `RewRepValue1` = `RewRepValue1` * 100 WHERE `entry` IN (8467, 8469, 9138, 9139, 9140, 9147, 9149, 9150, 9152, 9155, 9156, 9157, 9160, 9163, 9164, 9169, 9170, 9171, 9173, 9175, 9176, 9192, 9193, 9199, 9207, 9220, 9275, 9281, 9315, 10285, 10298, 10552, 12801, 12915, 12956, 13006, 13188, 13432, 13559, 13846, 24549) AND `RewRepValue1` <= 22000;
UPDATE `quest_template` SET `RewRepValue2` = `RewRepValue2` * 100 WHERE `entry` IN (9174) AND `RewRepValue2` <= 1000;


-- Boss Moorabi should be interruptable
UPDATE `creature_template` SET `mechanic_immune_mask` = 617298815 WHERE `entry` IN (29305, 30530);


-- Spawn creatures 29694 Drachenreiterin des Hildarthings, Hyldsmeet Drakerider for quest 12886, Der Drakkensryd, The Drakkensryd
DELETE FROM `creature` WHERE `id` = 29694;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(29694, 571, 1, 1, 0, 853, 7415.96, -476.242, 1897.5, 4.94811, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7393.25, -505.455, 1897.5, 4.55306, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7382.52, -548.787, 1897.5, 3.78965, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7396.96, -582.456, 1897.63, 6.07751, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7438.66, -591.248, 1897.5, 5.6534, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7476.5, -615.165, 1895.18, 1.0439, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7446.32, -621.511, 1895.12, 2.63826, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7400.61, -618.497, 1895.15, 1.9149, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7387.9, -600.896, 1895.66, 3.07965, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7359.45, -560.873, 1895.66, 2.3131, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7341.04, -542.913, 1895.18, 0.972432, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7346.58, -503.482, 1895.09, 6.23853, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7361.06, -499.659, 1895.66, 6.23853, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7398.69, -481.223, 1898.05, 5.65733, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7405.14, -461.833, 1896.57, 1.55598, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7416.64, -445.624, 1895.15, 0.474491, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7505.07, -579.368, 1894.84, 0.602511, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7515.82, -558.482, 1894.91, 3.13071, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7486.5, -560.762, 1898.05, 3.72133, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7457.66, -475.655, 1898.05, 1.46095, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7463.05, -450.244, 1895.12, 5.9927, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7488.2, -462.459, 1895.09, 5.79007, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7474.27, -488.514, 1898.05, 5.52696, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7487.58, -511.013, 1897.5, 6.20947, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7510.79, -495.373, 1894.8, 1.02349, 300, 5, 0, 8523, 0, 0, 1, 0, 0, 0),
(29694, 571, 1, 1, 0, 853, 7507.48, -510.9, 1895.66, 4.37713, 300, 5, 0, 8820, 0, 0, 1, 0, 0, 0);

-- Fix quest 12701, Massaker am Lichtgipfel, Massacre At Light's Point, delete wrong spawns of 28887, fix creature template of 28833, Scharlachrote Kanone, Scarlet Cannon
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 28887);
DELETE FROM `creature` WHERE `id` = 28887;
UPDATE `creature_template` SET `VehicleId` = 116 WHERE `entry` = 28833;

SET @Event:=54; -- Pilgrim`s bounty event id
SELECT MAX(`guid`) FROM `creature` INTO @GUID; -- Guid for creatures - Set by TDB

DELETE FROM `game_event` WHERE `entry`=@Event;
INSERT INTO `game_event` (`entry`,`start_time`,`end_time`,`occurence`,`length`,`holiday`,`description`,`world_event`) VALUES
(@Event,'2010-11-21 01:00:00','2020-12-31 05:00:00',525600,10020,404, 'Pilgrim''s Bounty',0);

-- Commoners spawns (Data taken from Midsummer Fire Festival - id 1)
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+68;
INSERT INTO `creature`(`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,
`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(@GUID+0,20102,1,1,1,16431,0,-924.656,-3715.91,9.13173,5.06145,300,0,0,42,0,0,0),
(@GUID+1,20102,1,1,1,16431,0,-924.099,-3718,9.18514,1.69297,300,0,0,42,0,0,0),
(@GUID+2,20102,1,1,1,16431,0,-898.024,-3765.59,11.868,1.25664,300,0,0,42,0,0,0),
(@GUID+3,20102,1,1,1,16431,0,-897.124,-3763.23,11.9882,4.32842,300,0,0,42,0,0,0),
(@GUID+4,20102,1,1,1,16431,0,-1030.97,-3678.41,23.2479,1.62316,300,0,0,42,0,0,0),
(@GUID+5,20102,1,1,1,16431,0,-1031.03,-3676.2,23.1851,4.69494,300,0,0,42,0,0,0),
(@GUID+6,20102,1,1,1,16431,0,-1031.03,-3676.2,23.1851,4.69494,300,0,0,42,0,0,0),
(@GUID+7,20102,1,1,1,16431,0,-898.024,-3765.59,11.868,1.25664,300,0,0,42,0,0,0),
(@GUID+8,20102,1,1,1,16431,0,-897.124,-3763.23,11.9882,4.32842,300,0,0,42,0,0,0),
(@GUID+9,20102,1,1,1,16431,0,-924.656,-3715.91,9.13173,5.06145,300,0,0,42,0,0,0),
(@GUID+10,20102,1,1,1,16431,0,-924.099,-3718,9.18514,1.69297,300,0,0,42,0,0,0),
(@GUID+11,20102,1,1,1,16431,0,6791.34,-4747.01,701.617,2.21657,300,0,0,42,0,0,0),
(@GUID+12,20102,1,1,1,16431,0,-7144.12,-3830.95,8.50543,3.26377,300,0,0,42,0,0,0),
(@GUID+13,20102,1,1,1,16431,0,-7147.06,-3830.22,8.51396,6.05629,300,0,0,42,0,0,0),
(@GUID+14,20102,1,1,1,16431,0,-7217.57,-3735.16,8.45314,2.28638,300,0,0,42,0,0,0),
(@GUID+15,20102,1,1,1,16431,0,-7219.66,-3731.91,8.4635,5.13127,300,0,0,42,0,0,0),
(@GUID+16,20102,1,1,1,16431,0,-7182.97,-3811.81,8.80395,2.3911,300,0,0,42,0,0,0),
(@GUID+17,20102,1,1,1,16431,0,-7185.2,-3809.25,9.01346,5.51524,300,0,0,42,0,0,0),
(@GUID+18,20102,1,1,1,16431,0,-7053.62,-3777.21,10.2047,5.25344,300,0,0,42,0,0,0),
(@GUID+19,20102,1,1,1,16431,0,-7053,-3779.9,10.1478,1.53589,300,0,0,42,0,0,0),
(@GUID+20,20102,1,1,1,16431,0,-7053,-3779.9,10.1478,1.53589,300,0,0,42,0,0,0),
(@GUID+21,20102,1,1,1,16431,0,-7217.57,-3735.16,8.45314,2.28638,300,0,0,42,0,0,0),
(@GUID+22,20102,1,1,1,16431,0,-7219.66,-3731.91,8.4635,5.13127,300,0,0,42,0,0,0),
(@GUID+23,20102,1,1,1,16431,0,-7144.12,-3830.95,8.50543,3.26377,300,0,0,42,0,0,0),
(@GUID+24,20102,1,1,1,16431,0,-7147.06,-3830.22,8.51396,6.05629,300,0,0,42,0,0,0),
(@GUID+25,20102,530,1,1,16431,0,-1818.99,5305.67,-12.3448,4.03171,300,0,0,42,0,0,0),
(@GUID+26,20102,530,1,1,16431,0,-1821.12,5303.35,-12.3448,0.767945,300,0,0,42,0,0,0),
(@GUID+27,20102,530,1,1,16431,0,-1748.08,5493.86,-12.3448,4.2586,300,0,0,42,0,0,0),
(@GUID+28,20102,530,1,1,16431,0,-1747.9,5492.11,-12.3448,1.3439,300,0,0,42,0,0,0),
(@GUID+29,20102,530,1,1,16431,0,-1978.82,5365.21,-12.3448,3.63029,300,0,0,42,0,0,0),
(@GUID+30,20102,530,1,1,16431,0,-1980.72,5364.88,-12.3225,0.226893,300,0,0,42,0,0,0),
(@GUID+31,20102,530,1,1,16431,0,-1875.93,5376.2,-12.3448,0.820305,300,0,0,42,0,0,0),
(@GUID+32,20102,530,1,1,16431,0,-1875.06,5378.04,-12.3448,4.36332,300,0,0,42,0,0,0),
(@GUID+33,20102,530,1,1,16431,0,-2175.76,5414.62,50.3112,5.60251,300,0,0,42,0,0,0),
(@GUID+34,20102,530,1,1,16431,0,-2174.14,5413.06,50.3112,2.56563,300,0,0,42,0,0,0),
(@GUID+35,20102,530,1,1,16431,0,-1809.92,5418.64,-12.3448,5.55015,300,0,0,42,0,0,0),
(@GUID+36,20102,530,1,1,16431,0,-1808.36,5417.01,-12.3448,2.32129,300,0,0,42,0,0,0),
(@GUID+37,20102,530,1,1,16431,0,-1917.81,5441.85,-12.3448,2.35619,300,0,0,42,0,0,0),
(@GUID+38,20102,530,1,1,16431,0,-1920.17,5443.52,-12.3448,5.86431,300,0,0,42,0,0,0),
(@GUID+39,20102,530,1,1,16431,0,-1883.61,5769.28,129.641,4.15388,300,0,0,42,0,0,0),
(@GUID+40,20102,530,1,1,16431,0,-1884.14,5766.55,129.641,1.309,300,0,0,42,0,0,0),
(@GUID+41,20102,0,1,1,16431,0,-14440.1,509.034,26.2717,1.3439,300,0,0,42,0,0,0),
(@GUID+42,20102,0,1,1,16431,0,-14440.2,510.301,26.2619,5.07891,300,0,0,42,0,0,0),
(@GUID+43,20102,0,1,1,16431,0,-14468.7,463.642,36.9241,4.13643,300,0,0,42,0,0,0),
(@GUID+44,20102,0,1,1,16431,0,-14469.6,462.223,36.9248,0.279253,300,0,0,42,0,0,0),
(@GUID+45,20102,0,1,1,16431,0,-14313.5,508.853,8.69121,4.27606,300,0,0,42,0,0,0),
(@GUID+46,20102,0,1,1,16431,0,-14314,507.109,8.68829,1.22173,300,0,0,42,0,0,0),
(@GUID+47,20102,0,1,1,16431,0,-14468.7,463.642,36.9241,4.13643,300,0,0,42,0,0,0),
(@GUID+48,20102,0,1,1,16431,0,-14469.6,462.223,36.9248,0.279253,300,0,0,42,0,0,0),
(@GUID+49,20102,0,1,1,16431,0,-14313.5,508.853,8.69121,4.27606,300,0,0,42,0,0,0),
(@GUID+50,20102,0,1,1,16431,0,-14314,507.109,8.68829,1.22173,300,0,0,42,0,0,0),
(@GUID+51,20102,0,1,1,16431,0,-14440.1,509.034,26.2717,1.3439,300,0,0,42,0,0,0),
(@GUID+52,20102,0,1,1,16431,0,-14440.2,510.301,26.2619,5.07891,300,0,0,42,0,0,0),
(@GUID+53,19148,0,1,1,16434,0,-4900.87,-957.314,501.541,4.17134,300,0,0,42,0,0,0),
(@GUID+54,19148,0,1,1,16434,0,-4901.8,-958.955,501.543,1.01229,300,0,0,42,0,0,0),
(@GUID+55,19173,1,1,1,16435,0,9921.56,2499.58,1317.77,5.61996,300,0,0,42,0,0,0),
(@GUID+56,19173,1,1,1,16414,0,9922.97,2498.76,1317.86,2.44346,300,0,0,42,0,0,0),
(@GUID+57,19175,1,1,1,16438,0,1623.41,-4402.24,12.7889,5.68977,300,0,0,42,0,0,0),
(@GUID+58,19175,1,1,1,16436,0,1625,-4402.88,13.1966,2.60054,300,0,0,42,0,0,0),
(@GUID+59,19176,1,1,1,16432,0,-1240.55,90.6357,129.002,4.83456,300,0,0,42,0,0,0),
(@GUID+60,19176,1,1,1,16432,0,-1240.74,88.4645,129.187,2.23402,300,0,0,42,0,0,0),
(@GUID+61,19178,0,1,1,16444,0,1627.8,224.57,-43.0193,4.15388,300,0,0,42,0,0,0),
(@GUID+62,19178,0,1,1,16444,0,1626.7,222.7,-43.0193,1.01229,300,0,0,42,0,0,0),
(@GUID+63,19178,0,1,1,16444,0,1573.04,265.955,-43.0193,0.593412,300,0,0,42,0,0,0),
(@GUID+64,19178,0,1,1,16444,0,1574.55,267.583,-43.0193,3.76991,300,0,0,42,0,0,0),
(@GUID+65,18927,0,1,1,16412,0,-8837.9,553.154,95.9797,0.15708,300,0,0,42,0,0,0),
(@GUID+66,18927,0,1,1,16433,0,-8837.23,554.917,95.7154,5.044,300,0,0,42,0,0,0),
(@GUID+67,18927,0,1,1,16433,0,-8854.78,649.83,96.7417,1.43117,300,0,0,42,0,0,0),
(@GUID+68,18927,0,1,1,16433,0,-8855.72,651.851,96.6895,5.70723,300,0,0,42,0,0,0);
-- Set them spawned only during Pilgrim`s bounty event
DELETE FROM `game_event_creature` WHERE `guid` BETWEEN @GUID+0 AND @GUID+68;
INSERT INTO `game_event_creature`(`guid`,`event`) VALUES
(@GUID+0,@Event),
(@GUID+1,@Event),
(@GUID+2,@Event),
(@GUID+3,@Event),
(@GUID+4,@Event),
(@GUID+5,@Event),
(@GUID+6,@Event),
(@GUID+7,@Event),
(@GUID+8,@Event),
(@GUID+9,@Event),
(@GUID+10,@Event),
(@GUID+11,@Event),
(@GUID+12,@Event),
(@GUID+13,@Event),
(@GUID+14,@Event),
(@GUID+15,@Event),
(@GUID+16,@Event),
(@GUID+17,@Event),
(@GUID+18,@Event),
(@GUID+19,@Event),
(@GUID+20,@Event),
(@GUID+21,@Event),
(@GUID+22,@Event),
(@GUID+23,@Event),
(@GUID+24,@Event),
(@GUID+25,@Event),
(@GUID+26,@Event),
(@GUID+27,@Event),
(@GUID+28,@Event),
(@GUID+29,@Event),
(@GUID+30,@Event),
(@GUID+31,@Event),
(@GUID+32,@Event),
(@GUID+33,@Event),
(@GUID+34,@Event),
(@GUID+35,@Event),
(@GUID+36,@Event),
(@GUID+37,@Event),
(@GUID+38,@Event),
(@GUID+39,@Event),
(@GUID+40,@Event),
(@GUID+41,@Event),
(@GUID+42,@Event),
(@GUID+43,@Event),
(@GUID+44,@Event),
(@GUID+45,@Event),
(@GUID+46,@Event),
(@GUID+47,@Event),
(@GUID+48,@Event),
(@GUID+49,@Event),
(@GUID+50,@Event),
(@GUID+51,@Event),
(@GUID+52,@Event),
(@GUID+53,@Event),
(@GUID+54,@Event),
(@GUID+55,@Event),
(@GUID+56,@Event),
(@GUID+57,@Event),
(@GUID+58,@Event),
(@GUID+59,@Event),
(@GUID+60,@Event),
(@GUID+61,@Event),
(@GUID+62,@Event),
(@GUID+63,@Event),
(@GUID+64,@Event),
(@GUID+65,@Event),
(@GUID+66,@Event),
(@GUID+67,@Event),
(@GUID+68,@Event);
-- Now quests they give
-- Quests offered only during the event
DELETE FROM `game_event_creature_quest` WHERE `quest` IN(14022,14036);
INSERT INTO `game_event_creature_quest` (`id`,`quest`,`event`) VALUES
(18927,14022,@Event), -- Aliance quest
(19148,14022,@Event),
(19171,14022,@Event),
(19173,14022,@Event),
(20102,14022,@Event),
(19169,14036,@Event), -- Horde quest
(19175,14036,@Event),
(19176,14036,@Event),
(19178,14036,@Event),
(20102,14036,@Event);
-- Sets the dailys from the event: "Pilgrim's Bounty" for Horde.
UPDATE `quest_template` SET `RequiredRaces`=690 WHERE `entry` IN (14059,14061,14062,14060,14058);
-- Sets the dailys from the event: "Pilgrim's Bounty" for Alliance.
UPDATE `quest_template` SET `RequiredRaces`=1101 WHERE `entry` IN (14053,14048,14051,14055,14054);
-- Sets all those NPC's that should have a quest giver and a trainer flag, A quest giver and a trainer flag.
UPDATE `creature_template` SET `npcflag`=`npcflag`|19 WHERE `entry` IN(
-- Horde
34712,
34713,
34714,
34768,
-- Alliance
34710,
34708,
34744,
34711);
-- Insert the creatures that starts and finish the dailys.
DELETE FROM `creature_involvedrelation` WHERE `id` IN (34712,34713,34714,34768,34710,34744,34708,34711);
INSERT INTO `creature_involvedrelation` (`id`,`quest`) VALUES 
-- Horde
(34712,14059),
(34713,14061),
(34713,14062),
(34714,14060),
(34768,14058),
-- Alliance
(34710,14053),
(34708,14048),
(34708,14051),
(34744,14055),
(34711,14054);
-- Insert the quests that they will be only available during the event.
DELETE FROM `game_event_creature_quest`WHERE  `id` IN (34712,34713,34714,34768,34710,34744,34708,34711);
INSERT INTO `game_event_creature_quest` (`id`,`quest`,`event`) VALUES
-- Horde
(34712,14059,@Event),
(34713,14061,@Event),
(34713,14062,@Event),
(34714,14060,@Event),
(34768,14058,@Event),
-- Alliance
(34710,14053,@Event),
(34708,14048,@Event),
(34708,14051,@Event),
(34744,14055,@Event),
(34711,14054,@Event);
-- Sets Wild Turkey and Lonely Turkey neutral.
UPDATE `creature_template` SET `faction_A`=31,`faction_H`=31 WHERE `entry` IN (32820,32956);
-- Adds the loot to those turkeys.
SET @turkey:=32820; -- Wild Turkey
SET @turkey2:=32956; -- Lonely Turkey
DELETE FROM `creature_loot_template` WHERE `entry` IN (32820,32956);
INSERT INTO `creature_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES 
(@turkey,44834,100,1,0,1,1),
(@turkey2,44834,100,1,0,1,1);
-- Sets loot id for those turkeys.
UPDATE `creature_template` SET `lootid`=32820 WHERE `entry`=32820;
UPDATE `creature_template` SET `lootid`=32956 WHERE `entry`=32956;
-- Set Bountiful Table untargetable flag.
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432 WHERE `entry`=32823;
-- Sets the chains from the event: "Pilgrim's Bounty" for Horde.
UPDATE `quest_template` SET `RequiredRaces`=690 WHERE `entry` IN (14037,14040,14041,14043,14044,14047);
-- Sets the chains from the event: "Pilgrim's Bounty" for Alliance.
UPDATE `quest_template` SET `RequiredRaces`=1101 WHERE `entry` IN (14023,14024,14028,14030,14033,14035);
-- Sets the quests in chain.
-- Alliance
UPDATE `quest_template` SET `PrevQuestId`=14023 WHERE `Entry`=14024;
UPDATE `quest_template` SET `PrevQuestId`=14024 WHERE `Entry`=14028;
UPDATE `quest_template` SET `PrevQuestId`=14028 WHERE `Entry`=14030;
UPDATE `quest_template` SET `PrevQuestId`=14030 WHERE `Entry`=14033;
UPDATE `quest_template` SET `PrevQuestId`=14033 WHERE `Entry`=14035;
-- Horde
UPDATE `quest_template` SET `PrevQuestId`=14037 WHERE `Entry`=14040;
UPDATE `quest_template` SET `PrevQuestId`=14040 WHERE `Entry`=14041;
UPDATE `quest_template` SET `PrevQuestId`=14041 WHERE `Entry`=14043;
UPDATE `quest_template` SET `PrevQuestId`=14043 WHERE `Entry`=14044;
UPDATE `quest_template` SET `PrevQuestId`=14044 WHERE `Entry`=14047;
-- Adds the creature involved for the Chain Quests of the event: "Pilgrim's Bounty".
DELETE FROM `creature_involvedrelation` WHERE `id` IN (34768,34677,34679,34678,34675,34744,34644,34676);
INSERT INTO `creature_involvedrelation` (`id`,`quest`) VALUES 
-- Horde
(34768,14037),
(34679,14040),
(34678,14041),
(34679,14043),
(34677,14047),
(34679,14047),
-- Alliance
(34744,14023),
(34644,14024),
(34744,14028),
(34676,14030),
(34675,14033),
(34676,14035);
 -- Insert the quest relation that are only available during the event
DELETE FROM `game_event_creature_quest` WHERE `id` IN (34768,34679,34678,34677,34644,34744,34675,34676);
INSERT INTO `game_event_creature_quest` (`id`,`quest`,`event`) VALUES
(34768,14037,@Event),
(34677,14037,@Event),
(34768,14040,@Event),
(34679,14040,@Event),
(34679,14041,@Event),
(34678,14041,@Event),
(34678,14043,@Event),
(34679,14043,@Event),
(34679,14044,@Event),
(34677,14044,@Event),
(34677,14047,@Event),
(34679,14047,@Event),
-- Alliance
(34675,14023,@Event),
(34744,14023,@Event),
(34744,14024,@Event),
(34644,14024,@Event),
(34644,14028,@Event),
(34744,14028,@Event),
(34744,14030,@Event),
(34676,14030,@Event),
(34676,14033,@Event),
(34675,14033,@Event),
(34675,14035,@Event),
(34676,14035,@Event);
-- Sets all those NPC's a quest giver flag.
-- Trainers and Quest-Givers.
UPDATE `creature_template` SET `npcflag`=`npcflag`|19 WHERE `entry` IN(
34708, -- Caitrin Ironkettle
34710, -- Ellen Moore
34714, -- Mahara Goldwheat
34711, -- Mary Allerton
34713, -- Ondani Greatmill
34712); -- Roberta Carter
-- Quest-Givers only.
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN(
-- Horde
34677,
34678,
34679,
34768,
-- Alliance
34675,
34733,
34644,
34744,
34676);
-- Sets vendor table for the vendors in the event: "Pilgrim's Bounty"
SET @Barrel:=35342; -- Bountiful Barrel <Pilgrim's Bounty Supplies>
SET @Barrel2:=35343;
SET @Barrel3:=35341;
SET @Barrel4:=35340;
SET @Barrel5:=35338;
SET @Barrel6:=35337;
DELETE FROM `npc_vendor` WHERE `entry` IN (35342,35343,35341,35340,35338,35337);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES 
-- Horde
(@Barrel,0,46810,0,0,0), -- Bountiful Cookbook
(@Barrel,0,44835,0,0,0), -- Autumnal Herbs
(@Barrel,0,46888,0,0,0), -- Bountiful Basket
(@Barrel,0,44853,0,0,0), -- Honey
(@Barrel,0,2678,0,0,0), -- Mild Spices
(@Barrel,0,159,0,0,0), -- Refreshing Spring Water
(@Barrel,0,30817,0,0,0), -- Simple Flour
(@Barrel,0,46793,0,0,0), -- Tangy Southfury Cranberries
(@Barrel2,0,46810,0,0,0), -- Bountiful Cookbook
(@Barrel2,0,44835,0,0,0), -- Autumnal Herbs
(@Barrel2,0,46888,0,0,0), -- Bountiful Basket
(@Barrel2,0,44853,0,0,0), -- Honey
(@Barrel2,0,2678,0,0,0), -- Mild Spices
(@Barrel2,0,159,0,0,0), -- Refreshing Spring Water
(@Barrel2,0,30817,0,0,0), -- Simple Flour
(@Barrel2,0,46797,0,0,0), -- Mulgore Sweet Potato
(@Barrel3,0,46810,0,0,0), -- Bountiful Cookbook
(@Barrel3,0,44835,0,0,0), -- Autumnal Herbs
(@Barrel3,0,46888,0,0,0), -- Bountiful Basket
(@Barrel3,0,44853,0,0,0), -- Honey
(@Barrel3,0,2678,0,0,0), -- Mild Spices
(@Barrel3,0,159,0,0,0), -- Refreshing Spring Water
(@Barrel3,0,30817,0,0,0), -- Simple Flour
(@Barrel3,0,46796,0,0,0), -- Ripe Tirisfal Pumpkin
-- Alliance
(@Barrel4,0,46809,0,0,0), -- Bountiful Cookbook
(@Barrel4,0,44835,0,0,0), -- Autumnal Herbs
(@Barrel4,0,46888,0,0,0), -- Bountiful Basket
(@Barrel4,0,44853,0,0,0), -- Honey
(@Barrel4,0,2678,0,0,0), -- Mild Spices
(@Barrel4,0,159,0,0,0), -- Refreshing Spring Water
(@Barrel4,0,30817,0,0,0), -- Simple Flour
(@Barrel4,0,44854,0,0,0), -- Tangy Wetlands Cranberries
(@Barrel5,0,46809,0,0,0), -- Bountiful Cookbook
(@Barrel5,0,44835,0,0,0), -- Autumnal Herbs
(@Barrel5,0,46888,0,0,0), -- Bountiful Basket
(@Barrel5,0,44853,0,0,0), -- Honey
(@Barrel5,0,2678,0,0,0), -- Mild Spices
(@Barrel5,0,159,0,0,0), -- Refreshing Spring Water
(@Barrel5,0,30817,0,0,0), -- Simple Flour
(@Barrel5,0,44855,0,0,0), -- Teldrassil Sweet Potato
(@Barrel6,0,46809,0,0,0), -- Bountiful Cookbook
(@Barrel6,0,44835,0,0,0), -- Autumnal Herbs
(@Barrel6,0,46888,0,0,0), -- Bountiful Basket
(@Barrel6,0,44853,0,0,0), -- Honey
(@Barrel6,0,2678,0,0,0), -- Mild Spices
(@Barrel6,0,159,0,0,0), -- Refreshing Spring Water
(@Barrel6,0,30817,0,0,0), -- Simple Flour
(@Barrel6,0,46784,0,0,0); -- Ripe Elwynn Pumpkin

-- Vendors:
SET @Dalni:=34685; -- Dalni Tallgrass
SET @Elizabeth:=34645; -- Elizabeth Barker Winslow
SET @Ikaneba:=34681; -- Ikaneba Summerset
SET @John:=34787; -- John Rigsdale
SET @Laha:=34684; -- Laha Farplain
SET @Ranisa:=34783; -- Ranisa Whitebough
SET @Rose:=34683; -- Rose Standish
SET @Wilmina:=34682; -- Wilmina Holbeck
DELETE FROM `npc_vendor` WHERE `entry` IN (34685,34645,34681,34787,34684,34783,34683,34682);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`) VALUES 
-- Horde
(@Dalni,0,46810,0,0,0), -- Bountiful Cookbook
(@Dalni,0,44835,0,0,0), -- Autumnal Herbs
(@Dalni,0,46888,0,0,0), -- Bountiful Basket
(@Dalni,0,44853,0,0,0), -- Honey
(@Dalni,0,2678,0,0,0), -- Mild Spices
(@Dalni,0,159,0,0,0), -- Refreshing Spring Water
(@Dalni,0,30817,0,0,0), -- Simple Flour
(@Dalni,0,46793,0,0,0), -- Tangy Southfury Cranberries
(@John,0,46810,0,0,0), -- Bountiful Cookbook
(@John,0,44835,0,0,0), -- Autumnal Herbs
(@John,0,46888,0,0,0), -- Bountiful Basket
(@John,0,44853,0,0,0), -- Honey
(@John,0,2678,0,0,0), -- Mild Spices
(@John,0,159,0,0,0), -- Refreshing Spring Water
(@John,0,30817,0,0,0), -- Simple Flour
(@Laha,0,46810,0,0,0), -- Bountiful Cookbook
(@Laha,0,44835,0,0,0), -- Autumnal Herbs
(@Laha,0,46888,0,0,0), -- Bountiful Basket
(@Laha,0,44853,0,0,0), -- Honey
(@Laha,0,2678,0,0,0), -- Mild Spices
(@Laha,0,159,0,0,0), -- Refreshing Spring Water
(@Laha,0,30817,0,0,0), -- Simple Flour
(@Laha,0,46797,0,0,0), -- Mulgore Sweet Potato
(@Rose,0,46810,0,0,0), -- Bountiful Cookbook
(@Rose,0,44835,0,0,0), -- Autumnal Herbs
(@Rose,0,46888,0,0,0), -- Bountiful Basket
(@Rose,0,44853,0,0,0), -- Honey
(@Rose,0,2678,0,0,0), -- Mild Spices
(@Rose,0,159,0,0,0), -- Refreshing Spring Water
(@Rose,0,30817,0,0,0), -- Simple Flour
(@Rose,0,46796,0,0,0), -- Ripe Tirisfal Pumpkin
-- Alliance
(@Elizabeth,0,46809,0,0,0), -- Bountiful Cookbook
(@Elizabeth,0,44835,0,0,0), -- Autumnal Herbs
(@Elizabeth,0,46888,0,0,0), -- Bountiful Basket
(@Elizabeth,0,44853,0,0,0), -- Honey
(@Elizabeth,0,2678,0,0,0), -- Mild Spices
(@Elizabeth,0,159,0,0,0), -- Refreshing Spring Water
(@Elizabeth,0,30817,0,0,0), -- Simple Flour
(@Elizabeth,0,44854,0,0,0), -- Tangy Wetlands Cranberries
(@Ikaneba,0,46809,0,0,0), -- Bountiful Cookbook
(@Ikaneba,0,44835,0,0,0), -- Autumnal Herbs
(@Ikaneba,0,46888,0,0,0), -- Bountiful Basket
(@Ikaneba,0,44853,0,0,0), -- Honey
(@Ikaneba,0,2678,0,0,0), -- Mild Spices
(@Ikaneba,0,159,0,0,0), -- Refreshing Spring Water
(@Ikaneba,0,30817,0,0,0), -- Simple Flour
(@Ikaneba,0,44855,0,0,0), -- Teldrassil Sweet Potato
(@Ranisa,0,46810,0,0,0), -- Bountiful Cookbook
(@Ranisa,0,44835,0,0,0), -- Autumnal Herbs
(@Ranisa,0,46888,0,0,0), -- Bountiful Basket
(@Ranisa,0,44853,0,0,0), -- Honey
(@Ranisa,0,2678,0,0,0), -- Mild Spices
(@Ranisa,0,159,0,0,0), -- Refreshing Spring Water
(@Ranisa,0,30817,0,0,0), -- Simple Flour
(@Wilmina,0,46809,0,0,0), -- Bountiful Cookbook
(@Wilmina,0,44835,0,0,0), -- Autumnal Herbs
(@Wilmina,0,46888,0,0,0), -- Bountiful Basket
(@Wilmina,0,44853,0,0,0), -- Honey
(@Wilmina,0,2678,0,0,0), -- Mild Spices
(@Wilmina,0,159,0,0,0), -- Refreshing Spring Water
(@Wilmina,0,30817,0,0,0), -- Simple Flour
(@Wilmina,0,46784,0,0,0); -- Ripe Elwynn Pumpkin

-- Fix creature 19527, Schwingender Leerrufer, Vacillating Voidcaller, was unattackable
UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 19527;

-- Sperre Instanzen ueber disable Funktion - 9.12.2010
DELETE FROM `disables` WHERE `sourceType` = 2;
INSERT INTO `disables` (sourceType, entry, flags, comment) VALUES
(2, 575, 3, 'Utgarde Pinnacle (entrance)'),
(2, 578, 3, 'The Oculus (entrance)'),
(2, 580, 1, 'Sunwell Plateau (Entrance)'),
(2, 600, 3, 'Drak\'Tharon Keep (entrance)'),
(2, 601, 3, 'Azjol-Nerub (entrance)'),
(2, 603, 3, 'Ulduar Raid entrance'),
(2, 616, 3, 'The Eye of Eternity (entrance)'),
(2, 619, 3, 'Ahn\'Kahet (entrance)'),
(2, 631, 15, 'IceCrown Citadel (Entrance)'),
(2, 658, 3, 'Pit of Saron (Entrance)'),
(2, 668, 3, 'Halls of Reflection (Entrance)'),
(2, 724, 15, 'The Ruby Sanctum (Entrance)');

-- Fix quest 7429, Rettet Knot! Free Knot!, fix reputation gain amount
UPDATE `quest_template` SET `RewRepFaction1` = 169, `RewRepFaction2` = 0, `RewRepFaction3` = 0, `RewRepFaction4` = 0, `RewRepValueId1` = 0, `RewRepValueId2` = 0, `RewRepValueId3` = 0, `RewRepValueId4` = 0, `RewRepValue1` = 35000, `RewRepValue2` = 0, `RewRepValue3` = 0, `RewRepValue4` = 0 WHERE `entry` = 7429;

-- Make gifts really lootable
UPDATE `item_template` SET `Flags` = 516 WHERE `entry` IN (5043, 5044, 17302, 17305, 17308);

-- Delete invisible attacking mobs in tausendwinter / 1kw / wintergrasp, ID 27869, Wintergrasp Detection Unit
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 27869);
DELETE FROM `creature` WHERE `id` = 27869;

-- Fix spirit guides in 1kw / Tausendwinter / Wintergrasp : Taunka Spirit Guide (31841) / Alliance Spirit Guide (31842)
UPDATE `creature_template` SET `unit_flags` = 2147484482, `flags_extra` = 2 WHERE `entry` IN (31841, 31842);
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN (31841, 31842));
DELETE FROM `creature` WHERE `id` IN (31841, 31842);
DELETE FROM `creature_template_addon` WHERE `entry` IN (31841, 31842);
INSERT INTO `creature_template_addon` (entry, path_id, mount, bytes1, bytes2, emote, auras) VALUES
(31841, 0, 0, 0, 1, 0, '58729 0'),
(31842, 0, 0, 0, 1, 0, '58729 0');
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(31841, 571, 1, 1, 0, 0, 5538, 2895.81, 517.055, 1.58009, 180, 0, 0, 126000, 7988, 0, 0, 0, 0, 0),
(31841, 571, 1, 1, 0, 0, 5099.03, 3469.67, 368.485, 5.09316, 180, 0, 0, 126000, 7988, 0, 0, 0, 0, 0),
(31841, 571, 1, 1, 0, 0, 4331.75, 3235.64, 390.251, 5.96887, 180, 0, 0, 126000, 7988, 0, 0, 0, 0, 0),
(31841, 571, 1, 1, 0, 0, 4315.11, 2409.94, 392.64, 5.59188, 180, 0, 0, 126000, 7988, 0, 0, 0, 0, 0),
(31841, 571, 1, 1, 0, 0, 5097.25, 2299.2, 368.485, 0.259043, 180, 0, 0, 126000, 7988, 0, 0, 0, 0, 0),
(31841, 571, 1, 1, 0, 0, 5031.83, 3711.34, 372.43, 3.84281, 180, 0, 0, 126000, 7988, 0, 0, 0, 0, 0),
(31842, 571, 1, 1, 0, 0, 5031.83, 3711.34, 372.43, 3.84281, 180, 0, 0, 126000, 7988, 0, 0, 0, 0, 0);

-- All Training Dummies should not give a weapon skill gain
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 262144 WHERE `ScriptName` = 'npc_training_dummy';

-- Missing spawn Geistheiler / Spirit Healer 6491 in Grizzly Hills / Grizzlyhügel
DELETE FROM `creature` WHERE `id` = 6491 AND `map` = 571 AND `position_x` BETWEEN 4100 AND 4130 AND `position_y` BETWEEN -4830 AND -4800 AND `position_z` BETWEEN 65 AND 90;
INSERT INTO `creature` (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, npcflag, unit_flags, dynamicflags) VALUES
(6491, 571, 1, 1, 0, 0, 4113.77, -4816.64, 76.0587, 0.0547746, 300, 0, 0, 4120, 0, 0, 0, 0, 0, 0);