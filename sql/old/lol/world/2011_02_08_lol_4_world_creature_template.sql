-- remove UNIT_FLAG_OOC_NOT_ATTACKABLE on Vakkiz the Windrager (23162)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ 256 WHERE `entry` = 23162;