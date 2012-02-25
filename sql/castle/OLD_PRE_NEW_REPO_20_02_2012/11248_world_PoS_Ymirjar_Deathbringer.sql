-- remove UNIT_FLAG_OOC_NOT_ATTACKABLE for pit of saron npc "Ymirjar Deathbringer"
UPDATE `creature_template` SET `unit_flags` = `unit_flags`&~256 WHERE `entry` = 36892;