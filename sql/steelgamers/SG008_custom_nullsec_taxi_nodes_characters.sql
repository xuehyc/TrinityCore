ALTER TABLE `custom_characters`.`custom_nullsec_guild_zones`   
  ADD COLUMN `taxi_node_id` INT(10) UNSIGNED NULL   COMMENT 'Taxi node ID of the zone (to allow fast travel)' AFTER `lowsec_respawn_z`,
  ADD COLUMN `taxi_node_2_id` INT(10) UNSIGNED NULL   COMMENT 'Some zones have to taxi nodes (one for the Alliance, one for the Horde)' AFTER `taxi_node_id`;

UPDATE `custom_nullsec_guild_zones` SET `taxi_node_id` = NULL, `taxi_node_2_id` = NULL WHERE `guild_zone_id` = 1;
UPDATE `custom_nullsec_guild_zones` SET `taxi_node_id` = 52, `taxi_node_2_id` = 53 WHERE `guild_zone_id` = 2;
UPDATE `custom_nullsec_guild_zones` SET `taxi_node_id` = 65, `taxi_node_2_id` = NULL WHERE `guild_zone_id` = 3;
UPDATE `custom_nullsec_guild_zones` SET `taxi_node_id` = 48, `taxi_node_2_id` = NULL WHERE `guild_zone_id` = 4;
UPDATE `custom_nullsec_guild_zones` SET `taxi_node_id` = 166, `taxi_node_2_id` = NULL WHERE `guild_zone_id` = 5;
UPDATE `custom_nullsec_guild_zones` SET `taxi_node_id` = 29, `taxi_node_2_id` = NULL WHERE `guild_zone_id` = 6;
UPDATE `custom_nullsec_guild_zones` SET `taxi_node_id` = 33, `taxi_node_2_id` = NULL WHERE `guild_zone_id` = 7;
UPDATE `custom_nullsec_guild_zones` SET `taxi_node_id` = 37, `taxi_node_2_id` = NULL WHERE `guild_zone_id` = 8;
UPDATE `custom_nullsec_guild_zones` SET `taxi_node_id` = 38, `taxi_node_2_id` = NULL WHERE `guild_zone_id` = 9;
UPDATE `custom_nullsec_guild_zones` SET `taxi_node_id` = 32, `taxi_node_2_id` = NULL WHERE `guild_zone_id` = 10;
UPDATE `custom_nullsec_guild_zones` SET `taxi_node_id` = 179, `taxi_node_2_id` = NULL WHERE `guild_zone_id` = 11;