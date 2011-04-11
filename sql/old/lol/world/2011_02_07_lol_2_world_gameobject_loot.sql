-- Adjust Truesilver Droprate in Truesilver Veins (2-4)
SET @go_loot_template = (SELECT `data1` FROM `gameobject_template` WHERE `entry` = 2047);
UPDATE `gameobject_loot_template` SET `mincountOrRef` = 2, `maxcount` = 4 WHERE `entry` = @go_loot_template;