-- Add missing npcflag for vendors
UPDATE `creature_template` SET `npcflag`=131 WHERE `entry` IN  (4217, 4730);
UPDATE `creature_template` SET `npcflag`=129 WHERE `entry` IN  (87049, 87052, 87057, 87062, 87065);
UPDATE `creature_template` SET `npcflag`=130 WHERE `entry` = 92185;
UPDATE `creature_template` SET `npcflag`=147 WHERE `entry` = 93527;