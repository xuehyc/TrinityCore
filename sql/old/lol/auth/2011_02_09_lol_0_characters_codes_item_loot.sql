CREATE TABLE `codes_item_loot` (
	`group_id` MEDIUMINT(10) NOT NULL DEFAULT '0' COMMENT 'Group that the items belong to',
	`item_id` MEDIUMINT(10) NOT NULL DEFAULT '0' COMMENT 'GUID of item',
	`name` VARCHAR(25) NULL DEFAULT NULL COMMENT 'Name of Item',
	PRIMARY KEY (`group_id`, `item_id`)
)
COLLATE='latin1_swedish_ci'
ENGINE=MyISAM
ROW_FORMAT=DEFAULT