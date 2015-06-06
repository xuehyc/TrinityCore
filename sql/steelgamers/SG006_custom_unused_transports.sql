DROP TABLE IF EXISTS `transports`;

CREATE TABLE `transports` (
  `guid` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `entry` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `name` TEXT,
  `ScriptName` CHAR(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`guid`),
  UNIQUE KEY `idx_entry` (`entry`)
) ENGINE=MYISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Transports';

/*Data for the table `transports` */

INSERT  INTO `transports`(`guid`,`entry`,`name`,`ScriptName`) VALUES 
(1,176310,'Stormwind Harbor and Auberdine, Darkshore (\"Ship (The Bravery)\")',''),
(2,176244,'Rut\'theran Village, Teldrassil and Auberdine, Darkshore (\"The Moonspray\")',''),
(3,164871,'Orgrimmar, Durotar and Undercity, Tirisfal Glades (\"The Thundercaller\")',''),
(4,177233,'The Forgotten Coast, Feralas and Feathermoon Stronghold, Sardor Isle, Feralas (\"Feathermoon Ferry\")',''),
(5,181688,'Menethil Harbor, Wetlands and Valgarde, Howling Fjord (\"Northspear\")',''),
(6,186371,'Westguard Keep in Howling Fjord to bombard pirate (\"Zeppelin\")',''),
(7,187038,'Not Boardable - Cyrcling in Howling Fjord (\"Sister Mercy\")',''),
(8,187568,'Unu\'pe, Borean Tundra and Moa\'ki Harbor, Dragonblight (\"Turtle (Walker of Waves)\")',''),
(9,188511,'Moa\'ki Harbor and Kamagua (\"Turtle (Green Island)\")',''),
(10,192241,'Horde gunship patrolling above Icecrown (\"Orgrim\'s Hammer\")',''),
(11,192242,'Alliance gunship patrolling above Icecrown (\"The Skybreaker\")',''),
(12,190549,'Orgrimmar and Thunder Bluff','');