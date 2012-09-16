-- Remove duplicated loot entry for "Reign of the Unliving" dropped by Anub'arak.
DELETE FROM `creature_loot_template` WHERE `entry`=35616 AND `item`=47188;