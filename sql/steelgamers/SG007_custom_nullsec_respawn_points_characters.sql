ALTER TABLE `custom_characters`.`custom_nullsec_guild_zones`   
  ADD COLUMN `lowsec_respawn_x` FLOAT NOT NULL   COMMENT 'X coord where players will respawn if they die in this zone (nearest lowsec)' AFTER `owner`,
  ADD COLUMN `lowsec_respawn_y` FLOAT NOT NULL   COMMENT 'Y coord where players will respawn if they die in this zone (nearest lowsec)' AFTER `lowsec_respawn_x`,
  ADD COLUMN `lowsec_respawn_z` FLOAT NOT NULL   COMMENT 'Z coord where players will respawn if they die in this zone (nearest lowsec)' AFTER `lowsec_respawn_y`;

-- Respawn - North zones / Ashenvale
UPDATE `custom_nullsec_guild_zones` SET lowsec_respawn_x = 2741.333008, lowsec_respawn_y = -1981.178223, lowsec_respawn_z = 159.159515 WHERE guild_zone_id IN (1, 2, 3, 4, 5);
-- Respawn - West zones / The Barrens (North)
UPDATE `custom_nullsec_guild_zones` SET lowsec_respawn_x = -459.686218, lowsec_respawn_y = -1769.867065, lowsec_respawn_z = 93.659828 WHERE guild_zone_id IN (6, 7, 8, 9);
-- Respaen - East Zones / The barrens (South)
UPDATE `custom_nullsec_guild_zones` SET lowsec_respawn_x = -3480.905762, lowsec_respawn_y = -2052.28418, lowsec_respawn_z = 96.45681 WHERE guild_zone_id IN (10, 11);