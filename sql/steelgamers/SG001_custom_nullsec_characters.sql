CREATE TABLE `custom_nullsec_guild_zones` (
	`guild_zone_id` INT(10) UNSIGNED NOT NULL COMMENT 'Zone ID (As defined in SharedDefines.h)',
	`guild_zone_name` VARCHAR(255) NOT NULL COMMENT 'Zone name',
	`vital_area_id` INT(10) UNSIGNED NOT NULL COMMENT 'Area where the player must be to use .reclamar command and claim the conquerable zone.',
	`standard_x` FLOAT NOT NULL COMMENT 'X coord where the Standard of Conquest will be placed.',
	`standard_y` FLOAT NOT NULL COMMENT 'Y coord where the Standard of Conquest will be placed.',
	`standard_z` FLOAT NOT NULL COMMENT 'Z coord where the Standard of Conquest will be placed.',
	`standard_o` FLOAT NOT NULL COMMENT 'Orientation of the Standard of Conquest.',
	`owner` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'The owner\'s ID (Guild)',
	PRIMARY KEY (`guild_zone_id`),
	INDEX `FK_ZONE_GUILD_GUID` (`owner`),
	CONSTRAINT `FK_ZONE_GUILD_GUID` FOREIGN KEY (`owner`) REFERENCES `guild` (`guildid`)
)
COMMENT='Stores data about the ownership of the Null Sec zones.'
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

REPLACE INTO custom_nullsec_guild_zones (guild_zone_id, guild_zone_name, owner) VALUES
(1, 'Cuna del Invierno Norte', NULL),
(2, 'Cuna del Invierno Sur', NULL),
(3, 'Frondavil Norte', NULL),
(4, 'Frondavil Centro', NULL),
(5, 'Frondavil Sur', NULL),
(6, 'Sierra Espolón Este', NULL),
(7, 'Sierra Espolón Oeste', NULL),
(8, 'Desolace Norte', NULL),
(9, 'Desolace Sur', NULL),
(10, 'Marjal Revolcafango Norte', NULL),
(11, 'Marjal Revolcafango Sur', NULL);

CREATE TABLE `custom_nullsec_guild_areas` (
	`guild_zone_id` INT(10) UNSIGNED NOT NULL,
	`zone_id` MEDIUMINT(8) UNSIGNED NOT NULL,
	`area_id` MEDIUMINT(8) UNSIGNED NOT NULL,
	INDEX `FK_GUILD_ZONE_ID` (`guild_zone_id`),
	CONSTRAINT `FK_GUILD_ZONE_ID` FOREIGN KEY (`guild_zone_id`) REFERENCES `custom_nullsec_guild_zones` (`guild_zone_id`)
)
COMMENT='Stores what areas delimit each of the player controllable zones.'
COLLATE='utf8_general_ci'
ENGINE=InnoDB;

DELETE FROM `custom_nullsec_guild_areas`;
INSERT INTO `custom_nullsec_guild_areas` (`guild_zone_id`, `zone_id`, `area_id`) VALUES
-- Winterspring North
(1, 618, 2241),
(1, 618, 2242),
(1, 618, 2253),
(1, 618, 3139),
(1, 618, 2251),
(1, 618, 2246),
(1, 618, 2243),
-- Winterspring South
(2, 618, 2255),
(2, 618, 2256),
(2, 618, 2254),
(2, 618, 2252),
(2, 618, 2250),
(2, 618, 2249),
(2, 618, 2248),
(2, 618, 2247),
(2, 618, 2245),
(2, 618, 2244),
-- Felwod North
(3, 361, 2618),
(3, 361, 1767),
(3, 361, 1768),
(3, 361, 1998),
(3, 361, 1762),
(3, 361, 1769),
-- Felwood Center
(4, 361, 1763),
(4, 361, 1997),
(4, 361, 1764),
(4, 361, 1765),
(4, 361, 1766),
(4, 361, 1771),
(4, 361, 1770),
-- Felwood South
(5, 361, 2478),
(5, 361, 1761),
(5, 361, 2479),
(5, 361, 2480),
(5, 361, 2481),
-- Stonetalon Mountains East
(6, 406, 469),
(6, 406, 460),
(6, 406, 463),
(6, 406, 461),
(6, 406, 2541),
(6, 406, 2539),
(6, 406, 2538),
(6, 406, 2537),
(6, 406, 2160),
(6, 406, 1076),
(6, 406, 1277),
(6, 406, 636),
(6, 406, 2540),
(6, 406, 3157),
-- Stonetalon Mountains West
(7, 406, 464),
(7, 406, 465),
(7, 406, 467),
(7, 406, 468),
-- Desolace North
(8, 405, 608),
(8, 405, 599),
(8, 405, 603),
(8, 405, 2404),
(8, 405, 604),
(8, 405, 2407),
(8, 405, 609),
(8, 405, 2198),
-- Desolace South
(9, 405, 596),
(9, 405, 597),
(9, 405, 598),
(9, 405, 600),
(9, 405, 602),
(9, 405, 606),
(9, 405, 607),
(9, 405, 2217),
(9, 405, 2408),
(9, 405, 2406),
(9, 405, 2405),
(9, 405, 2617),
(9, 405, 2617),
-- Dustwallow Marsh North
(10, 15, 496),
(10, 15, 497),
(10, 15, 499),
(10, 15, 500),
(10, 15, 502),
(10, 15, 503),
(10, 15, 504),
(10, 15, 505),
(10, 15, 507),
(10, 15, 512),
(10, 15, 513),
(10, 15, 514),
(10, 15, 515),
(10, 15, 518),
(10, 15, 2079),
-- Dustwallow Marsh South
(11, 15, 403),
(11, 15, 498),
(11, 15, 501),
(11, 15, 506),
(11, 15, 508),
(11, 15, 509),
(11, 15, 510),
(11, 15, 511),
(11, 15, 517),
(11, 15, 2158),
(11, 15, 2302),
(11, 15, 4010),
(11, 15, 4047),
(11, 15, 4049),
(11, 15, 4046);
