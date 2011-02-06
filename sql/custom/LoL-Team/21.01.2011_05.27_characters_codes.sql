DROP TABLE IF EXISTS `codes`;
CREATE TABLE `codes` (
  `npc_id` MEDIUMINT(10) NOT NULL,
  `code` VARCHAR(25) NOT NULL,
  `uses` TINYINT(3) NOT NULL,
  `item_id` MEDIUMINT(10) NOT NULL,
  `account_id` BIGINT(20) NOT NULL,
  `quantity` INT(20) NOT NULL,
  `char_guid` BIGINT(20) NOT NULL,
  `new_level` TINYINT(3) NOT NULL,
  PRIMARY KEY (`npc_id`,`code`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;