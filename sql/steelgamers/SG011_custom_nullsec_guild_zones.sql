/*
SQLyog Community v12.18 (64 bit)
MySQL - 5.7.10-log : Database - custom_characters
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `custom_nullsec_guild_zones` */

DROP TABLE IF EXISTS `custom_nullsec_guild_zones`;

CREATE TABLE `custom_nullsec_guild_zones` (
  `guild_zone_id` int(10) unsigned NOT NULL COMMENT 'Zone ID (As defined in SharedDefines.h)',
  `guild_zone_name` varchar(255) NOT NULL COMMENT 'Zone name',
  `zone_id` int(10) unsigned NOT NULL COMMENT 'Zone ID from DBC',
  `vital_area_id_1` int(10) unsigned NOT NULL COMMENT 'Area where the player must be to use .claim command and claim the conquerable zone.',
  `vital_area_id_2` int(10) unsigned NOT NULL,
  `vital_area_id_3` int(10) unsigned NOT NULL,
  `vital_area_1_status` int(1) unsigned zerofill NOT NULL COMMENT 'Status of each one of the capture points (0 - unconquested, 1 - under attack, 2 - conquested)',
  `vital_area_2_status` int(1) unsigned zerofill NOT NULL,
  `vital_area_3_status` int(1) unsigned zerofill NOT NULL,
  `standard_x_1` float NOT NULL COMMENT 'X coord where the Standard of Conquest will be placed.',
  `standard_x_2` float NOT NULL,
  `standard_x_3` float NOT NULL,
  `standard_y_1` float NOT NULL COMMENT 'Y coord where the Standard of Conquest will be placed.',
  `standard_y_2` float NOT NULL,
  `standard_y_3` float NOT NULL,
  `standard_z_1` float NOT NULL COMMENT 'Z coord where the Standard of Conquest will be placed.',
  `standard_z_2` float NOT NULL,
  `standard_z_3` float NOT NULL,
  `standard_o_1` float NOT NULL COMMENT 'Orientation of the Standard of Conquest.',
  `standard_o_2` float NOT NULL,
  `standard_o_3` float NOT NULL,
  `vital_area_owner_1` int(10) unsigned DEFAULT NULL COMMENT 'The owner''s ID (Guild)',
  `vital_area_owner_2` int(10) unsigned DEFAULT NULL,
  `vital_area_owner_3` int(10) unsigned DEFAULT NULL,
  `lowsec_respawn_x` float NOT NULL COMMENT 'X coord where players will respawn if they die in this zone (nearest lowsec)',
  `lowsec_respawn_y` float NOT NULL COMMENT 'Y coord where players will respawn if they die in this zone (nearest lowsec)',
  `lowsec_respawn_z` float NOT NULL COMMENT 'Z coord where players will respawn if they die in this zone (nearest lowsec)',
  `taxi_node_id_1` int(10) unsigned DEFAULT NULL COMMENT 'Taxi node ID of the zone (to allow fast travel)',
  `taxi_node_id_2` int(10) unsigned DEFAULT NULL COMMENT 'Some zones have to taxi nodes (one for the Alliance, one for the Horde)',
  `taxi_node_id_3` int(10) unsigned DEFAULT NULL,
  `taxi_node_id_4` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`guild_zone_id`),
  KEY `FK_ZONE_GUILD_GUID` (`vital_area_owner_1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores data about the ownership of the Null Sec zones.';

/*Data for the table `custom_nullsec_guild_zones` */

insert  into `custom_nullsec_guild_zones`(`guild_zone_id`,`guild_zone_name`,`zone_id`,`vital_area_id_1`,`vital_area_id_2`,`vital_area_id_3`,`vital_area_1_status`,`vital_area_2_status`,`vital_area_3_status`,`standard_x_1`,`standard_x_2`,`standard_x_3`,`standard_y_1`,`standard_y_2`,`standard_y_3`,`standard_z_1`,`standard_z_2`,`standard_z_3`,`standard_o_1`,`standard_o_2`,`standard_o_3`,`vital_area_owner_1`,`vital_area_owner_2`,`vital_area_owner_3`,`lowsec_respawn_x`,`lowsec_respawn_y`,`lowsec_respawn_z`,`taxi_node_id_1`,`taxi_node_id_2`,`taxi_node_id_3`,`taxi_node_id_4`) values 
(1,'Felwood',361,1998,1997,2479,0,0,0,6203.15,5162.58,3990.37,-1941.36,-313.65,-1293.37,570.61,353.11,251.61,5.96677,5.20578,3.09128,0,0,0,2741.33,-1981.18,159.16,65,48,166,NULL),
(2,'Desolace',405,608,2408,2405,0,0,0,136.87,-1703.2,-416.479,1233.02,3092.59,2504.39,164.43,33.37,121.435,3.31515,3.25232,4.04559,0,0,0,-459.686,-1769.87,93.6598,37,38,NULL,NULL),
(3,'Dustwallow Marsh',15,513,4010,504,0,0,0,-3678.41,-4583.65,-2885.72,-4387.99,-3173.41,-3427.31,10.53,34.15,39.3554,0.69386,0.02527,0.209279,0,0,0,-3480.91,-2052.28,96.4568,32,179,NULL,NULL),
(4,'Feralas',357,1116,1099,489,0,0,0,-4448.23,-4380.42,-4483.92,3260.15,233.581,-744.775,13.6617,25.4136,-27.4219,0.298893,3.49152,4.99163,0,0,1,-4656,-1765,-41.1732,41,42,31,NULL),
(5,'Azshara',16,1237,1220,1232,0,0,0,3605.13,4298.24,2464.37,-4388.24,-6287.86,-6877.29,115.283,95.7109,101.855,1.81381,0.452702,1.35826,0,0,0,2418.91,-2954.77,123.511,44,64,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
