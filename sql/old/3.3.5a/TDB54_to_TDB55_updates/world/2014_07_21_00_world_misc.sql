--
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 19768); -- guid auto created from script
UPDATE creature_template_addon SET `bytes1`=0, `bytes2`=0 WHERE `entry` IN (19762, 19768, 19784);
