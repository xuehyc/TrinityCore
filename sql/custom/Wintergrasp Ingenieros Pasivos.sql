-- Set Workshops Engineers "passive"
UPDATE `creature_template` SET `flags_extra`=2 WHERE `entry` IN (30400, 30499);