ALTER TABLE `game_event` CHANGE `eventEntry` `eventEntry` smallint unsigned NOT NULL COMMENT 'Entry of the game event';

UPDATE `game_event` SET `start_time`='2022-07-04 10:00:00', `end_time`='2037-07-05 04:00:00', `length`=1080  						WHERE `eventEntry`=72;  --  62 - Fireworks Spectacular
UPDATE `game_event` SET `start_time`='2022-12-16 10:00:00', `end_time`='2037-01-02 06:00:00', `description`='Feast of Winter Veil' 	WHERE `eventEntry`=2; 	-- 141 - Feast of Winter Veil
UPDATE `game_event` SET `start_time`='2023-04-10 10:00:00', `end_time`='2037-04-17 10:00:00', `occurence`=525600					WHERE `eventEntry`=9; 	-- 181 - Noblegarden
UPDATE `game_event` SET `start_time`='2023-05-01 10:00:00', `end_time`='2037-05-08 10:00:00', `description`='Children\'s Week' 		WHERE `eventEntry`=10;	-- 201 - Children's Week
UPDATE `game_event` SET `start_time`='2022-09-06 10:00:00', `end_time`='2037-09-13 10:00:00'										WHERE `eventEntry`=11; 	-- 321 - Harvest Festival
UPDATE `game_event` SET `start_time`='2022-10-18 10:00:00', `end_time`='2037-11-01 11:00:00', `length`=20220 						WHERE `eventEntry`=12; 	-- 324 - Hallow's End
UPDATE `game_event` SET `start_time`='2023-01-20 10:00:00', `end_time`='2037-02-03 10:00:00'									   	WHERE `eventEntry`=7; 	-- 327 - Lunar Festival
UPDATE `game_event` SET `start_time`='2022-06-21 10:00:00', `end_time`='2037-07-05 10:00:00'                 					   	WHERE `eventEntry`=1;	-- 341 - Midsummer Fire Festival
UPDATE `game_event` SET `start_time`='2022-09-20 10:00:00', `end_time`='2037-10-06 10:00:00', `length`=23040 						WHERE `eventEntry`=24;  -- 372 - Brewfest
UPDATE `game_event` SET `start_time`='2022-09-19 10:00:00', `end_time`='2037-09-20 10:00:00'										WHERE `eventEntry`=50; 	-- 398 - Pirates' Day
UPDATE `game_event` SET `start_time`='2022-11-22 10:00:00', `end_time`='2037-11-29 09:00:00'				 						WHERE `eventEntry`=26; 	-- 404 - Pilgrim's Bounty
UPDATE `game_event` SET `start_time`='2022-11-01 10:00:00', `end_time`='2037-11-03 10:00:00', `length`=2880 						WHERE `eventEntry`=51; 	-- 409 - Day of the Dead
UPDATE `game_event` SET `start_time`='2023-02-06 10:00:00', `end_time`='2037-02-20 10:00:00'									   	WHERE `eventEntry`=8; 	-- 423 - Love is in the Air
UPDATE `game_event` SET `start_time`=NULL, `end_time`=NULL, `description`='Kalu\'ak Fishing Derby'  								WHERE `eventEntry`=64; 	-- 424 - Kalu'ak Fishing Derby
UPDATE `game_event` SET `start_time`='2022-07-03 00:01:00', `end_time`='2037-07-09 23:59:00', `occurence`=40320, `length`=8640 		WHERE `eventEntry`=3; 	-- 479 - Darkmoon Faire
UPDATE `game_event` SET `start_time`=NULL, `end_time`=NULL   																		WHERE `eventEntry`=18; 	-- 490 - Call to Arms: Alterac Valley!
UPDATE `game_event` SET `start_time`=NULL, `end_time`=NULL 																			WHERE `eventEntry`=20; 	-- 491 - Call to Arms: Arathi Basin!
UPDATE `game_event` SET `start_time`=NULL, `end_time`=NULL  																		WHERE `eventEntry`=21; 	-- 492 - Call to Arms: Eye of the Storm!
UPDATE `game_event` SET `start_time`=NULL, `end_time`=NULL 																			WHERE `eventEntry`=54; 	-- 493 - Call to Arms: Isle of Conquest!
UPDATE `game_event` SET `start_time`=NULL, `end_time`=NULL  																		WHERE `eventEntry`=53; 	-- 495 - Call to Arms: Strand of the Ancients!
UPDATE `game_event` SET `start_time`=NULL, `end_time`=NULL 																			WHERE `eventEntry`=19; 	-- 499 - Call to Arms: Warsong Gulch!

DELETE FROM `game_event` WHERE `eventEntry` BETWEEN 200 AND 312;
INSERT INTO `game_event`(`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `holidayStage`, `description`, `world_event`, `announce`) VALUES 
(200,                  NULL,                  NULL, 9999999,   720,  406, 1, 'Wrath of the Lich King Launch', 0, 2),
(201,                  NULL,                  NULL, 9999999, 10080,  442, 1, 'Rated BG: 15v15', 0, 2),
(202,                  NULL,                  NULL, 9999999, 10080,  443, 1, 'Rated BG: 25v25', 0, 2),
(203,                  NULL,                  NULL, 9999999, 30240,  467, 1, 'WoW\'s 7th Anniversary', 0, 2),
(204,                  NULL,                  NULL, 9999999, 30240,  484, 1, 'WoW\'s 8th Anniversary', 0, 2),
(205,                  NULL,                  NULL, 9999999, 10080,  494, 1, 'Call to Arms: Silvershard Mines', 0, 2),
(206,                  NULL,                  NULL, 9999999, 10080,  496, 1, 'Call to Arms: Temple of Kotmogu', 0, 2),
(207,                  NULL,                  NULL, 9999999, 10080,  497, 1, 'Call to Arms: The Battle for Gilneas', 0, 2),
(208,                  NULL,                  NULL, 9999999, 10080,  498, 1, 'Call to Arms: Twin Peaks', 0, 2),
(209,                  NULL,                  NULL, 9999999, 30240,  509, 1, 'WoW\'s 9th Anniversary', 0, 2),
(210,                  NULL,                  NULL, 9999999, 30240,  514, 1, 'WoW\'s 10th Anniversary', 0, 2),
(211,                  NULL,                  NULL, 9999999, 10080,  516, 1, 'Call to Arms: Deepwind Gorge', 0, 2),
(212, '2022-09-06 08:00:00', '2037-09-13 05:00:00',  181440, 10080,  559, 1, 'Timewalking Dungeon Event', 0, 2), -- Burning Crusade Timewalking
(213,                  NULL,                  NULL,   70560, 10080,  560, 1, 'Apexis Bonus Event', 0, 2),
(214, '2022-07-12 08:00:00', '2037-07-19 05:00:00',  151200, 10080,  561, 1, 'Arena Skirmish Bonus Event', 0, 2),
(215, '2022-09-27 08:00:00', '2037-10-04 05:00:00',  181440, 10080,  562, 1, 'Timewalking Dungeon Event', 0, 2), -- Wrath of the Lich King Timewalking
(216, '2022-08-02 08:00:00', '2037-08-09 05:00:00',   70560, 10080,  563, 1, 'Battleground Bonus Event', 0, 2),
(217,                  NULL,                  NULL, 9999999,  9900,  564, 1, 'Draenor Dungeon Event', 0, 2),
(218, '2022-06-28 08:00:00', '2037-07-05 05:00:00',   80640, 10080,  565, 1, 'Pet Battle Bonus Event', 0, 2),
(219,                  NULL,                  NULL, 9999999, 30240,  566, 1, 'WoW\'s 11th Anniversary', 0, 2),
(220, '2022-10-18 08:00:00', '2037-10-25 05:00:00',  181440, 10080,  587, 1, 'Timewalking Dungeon Event', 0, 2), -- Cataclysm Timewalking
(221,                  NULL,                  NULL, 9999999, 30240,  589, 1, 'WoW\'s 12th Anniversary', 0, 2),
(222,                  NULL,                  NULL, 9999999, 30240,  590, 1, 'WoW\'s Anniversary', 0, 2),
(223,                  NULL,                  NULL, 9999999,  9900,  591, 1, 'Legion Dungeon Event', 0, 2),
(224, '2022-07-19 08:00:00', '2037-07-26 05:00:00',   80640, 10080,  592, 1, 'World Quest Bonus Event', 0, 2),
(225, '2023-02-23 00:00:00', '2037-02-24 00:00:00',  525600,  1440,  634, 1, 'Hatching of the Hippogryphs', 0, 2),
(226, '2023-04-28 00:00:00', '2037-04-29 00:00:00',  525600,  1440,  635, 1, 'Volunteer Guard Day', 0, 2),
(227, '2023-01-21 00:01:00', '2037-01-23 23:59:00',  525600,  2880,  638, 1, 'Call of the Scarab', 0, 2),
(228, '2023-06-06 00:01:00', '2037-06-08 23:59:00',  525600,  2880,  642, 1, 'Thousand Boat Bash', 0, 2),
(229, '2022-07-05 08:00:00', '2037-07-12 05:00:00',  181440, 10080,  643, 1, 'Timewalking Dungeon Event', 0, 2), -- Mists of Pandaria Timewalking
(230, '2023-03-17 00:01:00', '2037-03-19 23:59:00',  525600,  2880,  644, 1, 'Un\'Goro Madness', 0, 2),
(231, '2023-05-10 00:01:00', '2037-05-12 23:59:00',  525600,  2880,  645, 1, 'Spring Balloon Festival', 0, 2),
(232,                  NULL,                  NULL,  525600,  2880,  646, 1, 'Kirin Tor Tavern Crawl', 0, 2),
(233, '2023-04-05 01:00:00', '2037-04-06 01:00:00',  525600,  1440,  647, 1, 'March of the Tadpoles', 0, 2),
(234, '2023-05-27 00:00:00', '2037-05-28 00:00:00',  525600,  1440,  648, 1, 'Glowcap Festival', 0, 2),
(235, '2022-12-31 18:00:00', '2037-01-01 06:00:00',  525600,   720,  658, 1, 'Fireworks Celebration', 0, 2),
(236, '2022-08-23 08:00:00', '2037-08-30 08:00:00',  110880, 10080,  662, 1, 'PvP Brawl: Southshore vs. Tarren Mill', 0, 2),
(237, '2022-07-12 08:00:00', '2037-07-19 08:00:00',  110880, 10080,  663, 1, 'PvP Brawl: Gravity Lapse', 0, 2),
(238, '2022-08-02 08:00:00', '2037-08-09 08:00:00',  110880, 10080,  664, 1, 'PvP Brawl: Warsong Scramble', 0, 2),
(239, '2022-07-05 08:00:00', '2037-07-12 08:00:00',  110880, 10080,  666, 1, 'PvP Brawl: Arathi Blizzard', 0, 2),
(240, '2022-09-06 08:00:00', '2037-09-13 08:00:00',  110880, 10080,  667, 1, 'PvP Brawl: Packed House', 0, 2),
(241, '2022-08-31 00:01:00', '2037-09-04 23:59:00',  289440,  5760,  691, 1, 'Trial of Style', 0, 2),
(242, '2022-07-22 00:00:00', '2037-07-23 00:00:00',  525600,  1440,  692, 1, 'Auction House Dance Party', 0, 2),
(243,                  NULL,                  NULL, 9999999, 30240,  693, 1, 'WoW\'s 13th Anniversary', 0, 2),
(244, '2022-11-12 00:00:00', '2037-11-13 00:00:00',  525600,  1440,  694, 1, 'Moonkin Festival', 0, 2),
(245, '2022-10-08 00:00:00', '2037-10-09 00:00:00',  525600,  1440,  696, 1, 'The Great Gnomeregan Run', 0, 2),
(246, '2022-06-28 08:00:00', '2037-07-05 08:00:00',  110880, 10080,  702, 1, 'PvP Brawl: Deep Six', 0, 2),
(247,                  NULL,                  NULL, 9999999,  1440,  759, 1, 'Antorus, the Burning Throne', 0, 2), -- Antorus, the Burning Throne: Forbidden Descent
(248,                  NULL,                  NULL, 9999999,  1440,  763, 1, 'Antorus, the Burning Throne', 0, 2), -- Antorus, the Burning Throne: Hope's End.
(249,                  NULL,                  NULL, 9999999,  1440,  767, 1, 'Antorus, the Burning Throne', 0, 2), -- Antorus, the Burning Throne: Seat of the Pantheon
(250,                  NULL,                  NULL, 9999999,  1440,  771, 1, 'Antorus, the Burning Throne', 0, 2), -- Mythic difficulty of the Antorus, the Burning Throne: Light's Breach
(251,                  NULL,                  NULL, 9999999,  1440,  775, 1, 'Antorus, the Burning Throne', 0, 2), -- Enter Antorus, the Burning Throne raid on Normal or Heroic difficulty - Argus awaits!
(252,                  NULL,                  NULL, 9999999, 30240,  807, 1, 'WoW\'s 14th Anniversary', 0, 2),
(253,                  NULL,                  NULL, 9999999, 30240,  808, 1, 'WoW\'s 15th Anniversary', 0, 2),
(254,                  NULL,                  NULL, 9999999,  1440,  921, 1, 'Uldir', 0, 2), -- Enter Uldir raid on Normal or Heroic difficulty - G'huun awaits!
(255,                  NULL,                  NULL, 9999999,  1440,  925, 1, 'Uldir', 0, 2), -- Mythic difficulty of the Uldir raid: Halls of Containment
(256,                  NULL,                  NULL, 9999999,  1440,  929, 1, 'Uldir', 0, 2), -- Uldir: Crimson Descent
(257,                  NULL,                  NULL, 9999999,  1440,  933, 1, 'Uldir', 0, 2), -- Uldir: Heart of Corruption
(258,                  NULL,                  NULL, 9999999,  9900,  941, 1, 'Battle for Azeroth Dungeon Event', 0, 2),
(259,                  NULL,                  NULL, 9999999, 30240,  965, 1, 'War of the Thorns', 0, 2),
(260,                  NULL,                  NULL, 9999999,  1440, 1025, 1, 'Battle of Dazar\'alor', 0, 2), -- As the Kul Tiran navy bears down on Zandalar, superpowers clash in the Battle of Dazar'alor raid, now available on Normal or Heroic difficulty
(261,                  NULL,                  NULL, 9999999,  1440, 1030, 1, 'Battle of Dazar\'alor', 0, 2), -- Mythic difficulty of the Battle of Dazar'alor raid
(262,                  NULL,                  NULL, 9999999,  1440, 1034, 1, 'Battle of Dazar\'alor', 0, 2), -- Battle of Dazar'alor: Empire's Fall
(263,                  NULL,                  NULL, 9999999,  1440, 1038, 1, 'Battle of Dazar\'alor', 0, 2), -- Battle of Dazar'alor: Might of the Alliance for Alliance players, and Victory or Death for Horde players
(264, '2022-08-09 08:00:00', '2037-08-16 08:00:00',  110880, 10080, 1047, 1, 'PvP Brawl: Cooking Impossible', 0, 2),
(265, '2022-12-07 00:00:00', '2037-12-08 00:00:00',  525600,  1440, 1052, 1, 'Wanderer\'s Festival', 0, 2),
(266, '2022-08-16 00:00:00', '2037-08-17 00:00:00',  525600,  1440, 1053, 1, 'Free T-Shirt Day', 0, 2),
(267, '2022-07-13 00:00:00', '2037-07-14 00:00:00',  525600,  1440, 1054, 1, 'Luminous Luminaries', 0, 2),
(268, '2022-07-26 08:00:00', '2037-08-02 05:00:00',  181440, 10080, 1056, 1, 'Timewalking Dungeon Event', 0, 2), -- Warlords of Draenor Timewalking
(269,                  NULL,                  NULL, 9999999,  8640, 1069, 1, 'Crucible of Storms', 0, 2), -- Delve into the chambers beneath Stormsong Valley to uncover the source of the shadow spreading across the land, now available on Normal or Heroic difficulty
(270,                  NULL,                  NULL, 9999999,  8640, 1074, 1, 'Crucible of Storms', 0, 2), -- Mythic difficulty of the Crucible of Storms raid
(271,                  NULL,                  NULL, 9999999,  1440, 1098, 1, 'The Eternal Palace', 0, 2), -- Breach the palace gates and descend into Azshara's deadly domain
(272,                  NULL,                  NULL, 9999999,  1440, 1102, 1, 'The Eternal Palace', 0, 2), -- Mythic difficulty of The Eternal Palace raid
(273,                  NULL,                  NULL, 9999999,  1440, 1108, 1, 'The Eternal Palace', 0, 2), -- The Eternal Palace: The Circle of Stars
(274,                  NULL,                  NULL, 9999999,  1440, 1113, 1, 'The Eternal Palace', 0, 2), -- The Eternal Palace: Depths of the Devoted
(275, '2022-08-30 08:00:00', '2037-09-06 08:00:00',  110880, 10080, 1120, 1, 'PvP Brawl: Classic Ashran', 0, 2),
(276,                  NULL,                  NULL, 9999999,  1440, 1140, 1, 'Ny\'alotha, the Waking City', 0, 2), -- Descend into Ny'alotha, the Waking City and face N'Zoth in his own realm
(277,                  NULL,                  NULL, 9999999,  1440, 1144, 1, 'Ny\'alotha, the Waking City', 0, 2), -- Mythic difficulty of Ny'alotha, the Waking City raid
(278,                  NULL,                  NULL, 9999999,  1440, 1148, 1, 'Ny\'alotha, the Waking City', 0, 2), -- Ny'alotha, the Waking City: Halls of Devotion
(279,                  NULL,                  NULL, 9999999,  1440, 1152, 1, 'Ny\'alotha, the Waking City', 0, 2), -- Ny'alotha, the Waking City: Gift of Flesh
(280,                  NULL,                  NULL, 9999999,  1440, 1156, 1, 'Ny\'alotha, the Waking City', 0, 2), -- Ny'alotha, the Waking City: The Waking Dream
(281, '2022-08-16 08:00:00', '2037-08-23 08:00:00',  110880, 10080, 1170, 1, 'PvP Brawl: Temple of Hotmogu', 0, 2),
(282,                  NULL,                  NULL, 9999999, 30240, 1181, 1, 'WoW\'s 16th Anniversary', 0, 2),
(283,                  NULL,                  NULL, 9999999,  1440, 1194, 1, 'Castle Nathria', 0, 2), -- Enter Castle Nathria and confront Sire Denathrius in his citadel
(284,                  NULL,                  NULL, 9999999,  1440, 1195, 1, 'Castle Nathria', 0, 2), -- Mythic difficulty of Castle Nathria: The Leeching Vaults
(285,                  NULL,                  NULL, 9999999,  1440, 1196, 1, 'Castle Nathria', 0, 2), -- Castle Nathria: Reliquary of Opulence
(286,                  NULL,                  NULL, 9999999,  1440, 1197, 1, 'Castle Nathria', 0, 2), -- Castle Nathria: Blood from Stone
(287,                  NULL,                  NULL, 9999999,  1440, 1210, 1, 'Castle Nathria', 0, 2), -- Castle Nathria: An Audience with Arrogance
(288, '2022-07-12 00:01:00', '2022-07-18 23:59:00',  120960,  8640, 1214, 1, 'Torghast: Beasts of Prodigum', 0, 2),
(289, '2022-09-06 00:01:00', '2022-09-12 23:59:00',  120960,  8640, 1215, 1, 'Torghast: Unbridled Darkness', 0, 2),
(290, '2022-08-09 00:01:00', '2022-08-15 23:59:00',  120960,  8640, 1216, 1, 'Torghast: Chorus of Dead Souls', 0, 2),
(291, '2022-08-09 08:00:00', '2037-08-16 05:00:00',   80640, 10080, 1217, 1, 'Shadowlands Dungeon Event', 0, 2),
(292,                  NULL,                  NULL, 9999999, 30240, 1225, 1, 'WoW\'s 17th Anniversary', 0, 2),
(293,                  NULL,                  NULL, 9999999,  1440, 1226, 1, 'Sanctum of Domination', 0, 2), -- Ascend to the top of Torghast and enter the Sanctum of Domination to stop the Jailer's machinations
(294,                  NULL,                  NULL, 9999999,  1440, 1227, 1, 'Sanctum of Domination', 0, 2), -- Mythic difficulty of the Sanctum of Domination raid
(295,                  NULL,                  NULL, 9999999,  1440, 1228, 1, 'Sanctum of Domination', 0, 2), -- Sanctum of Domination: The Dark Bastille
(296,                  NULL,                  NULL, 9999999,  1440, 1229, 1, 'Sanctum of Domination', 0, 2), -- Sanctum of Domination: Shackles of Fate
(297,                  NULL,                  NULL, 9999999,  1440, 1230, 1, 'Sanctum of Domination', 0, 2), -- Sanctum of Domination: The Reckoning
(298,                  NULL,                  NULL,  110880, 10080, 1233, 1, 'PvP Brawl: Shado-Pan Showdown', 0, 2),
(299, '2022-07-19 08:00:00', '2037-07-26 08:00:00',  110880, 10080, 1235, 1, 'PvP Brawl: Comp Stomp', 0, 2),
(300, '2022-07-26 08:00:00', '2037-08-02 08:00:00',  110880, 10080, 1240, 1, 'PvP Brawl: Deepwind Dunk', 0, 2),
(301, '2022-11-15 10:00:00', '2022-12-06 10:00:00', 9999999, 30240, 1262, 1, 'WoW\'s 18th Anniversary', 0, 2),
(302, '2022-08-16 08:00:00', '2037-08-23 05:00:00',  181440, 10080, 1263, 1, 'Timewalking Dungeon Event', 0, 2), -- Legion Timewalking
(303,                  NULL,                  NULL,  181440, 10080, 1271, 1, 'Timewalking Dungeon Event', 0, 2),
(304,                  NULL,                  NULL, 9999999,  1440, 1287, 1, 'Sepulcher of the First Ones', 0, 2), -- Delve into the Sepulcher of the First Ones and thwart Zovaal's plot to dominate reality
(305,                  NULL,                  NULL, 9999999,  1440, 1291, 1, 'Sepulcher of the First Ones', 0, 2), -- Mythic difficulty of the Sepulcher of the First Ones raid
(306,                  NULL,                  NULL, 9999999,  1440, 1295, 1, 'Sepulcher of the First Ones', 0, 2), -- Sepulcher of the First Ones: The Cornerstone of Creation
(307,                  NULL,                  NULL, 9999999,  1440, 1299, 1, 'Sepulcher of the First Ones', 0, 2), -- Sepulcher of the First Ones: Domination's Grasp
(308,                  NULL,                  NULL, 9999999,  1440, 1303, 1, 'Sepulcher of the First Ones', 0, 2), -- Sepulcher of the First Ones: The Grand Design
(309,                  NULL,                  NULL,  110880, 10080, 1311, 1, 'PvP Brawl: Solo Shuffle', 0, 2),
(310,                  NULL,                  NULL, 9999999, 10080, 1315, 1, 'Fated Raids: Castle Nathria', 0, 2),
(311,                  NULL,                  NULL, 9999999, 10080, 1316, 1, 'Fated Raids: Sanctum of Domination', 0, 2),
(312,                  NULL,                  NULL, 9999999, 10080, 1317, 1, 'Fated Raids: Sepulcher of the First Ones', 0, 2);

/*
These events do not exist in holidays.db2
157 - 301 - Stranglethorn Fishing Extravaganza Fishing Pools
23 - 374 - Darkmoon Faire Building
62 - 376 - Stranglethorn Fishing Extravaganza Turn-ins
*/
DELETE FROM `game_event` WHERE `eventEntry` IN (15,23,62);
DELETE FROM `game_event_arena_seasons` WHERE `eventEntry` IN (15,23,62);
DELETE FROM `game_event_creature` WHERE `eventEntry` IN (15,23,62);
DELETE FROM `game_event_creature_quest` WHERE `eventEntry` IN (15,23,62);
DELETE FROM `game_event_gameobject` WHERE `eventEntry` IN (15,23);
DELETE FROM `game_event_gameobject_quest` WHERE `eventEntry` IN (15,23,62);
DELETE FROM `game_event_model_equip` WHERE `eventEntry` IN (15,23,62);
DELETE FROM `game_event_npc_vendor` WHERE `eventEntry` IN (15,23,62);
DELETE FROM `game_event_pool` WHERE `eventEntry` IN (15,23,62);
DELETE FROM `game_event_seasonal_questrelation` WHERE `eventEntry` IN (15,23,62);
