UPDATE `creature_template` SET `faction_A`=1720  , `faction_H`=1720 WHERE `entry` in (30961,31488);
UPDATE `creature_template` SET `faction_A`=1720  , `faction_H`=1720 WHERE `entry` in (30661,31487);
UPDATE `creature_template` SET `faction_A`=1720  , `faction_H`=1720 WHERE `entry` in (31079,31492);
UPDATE `creature_template` SET `faction_A`=1720  , `faction_H`=1720 WHERE `entry` in (31498);
UPDATE `creature_template` SET `faction_A`=1720  , `faction_H`=1720 WHERE `entry` in (31499);
UPDATE `creature_template` SET `faction_A`=1720  , `faction_H`=1720 WHERE `entry` in (30962,31495);
UPDATE `creature_template` SET `faction_A`=1720  , `faction_H`=1720 WHERE `entry` in (30963,31496);
UPDATE `creature_template` SET `faction_A`=1720  , `faction_H`=1720 WHERE `entry` in (30664,31497);
UPDATE `creature_template` SET `faction_A`=1720  , `faction_H`=1720 WHERE `entry` in (30663,31483);
UPDATE `creature_template` SET `faction_A`=1720  , `faction_H`=1720 WHERE `entry` in (30918,31484);
UPDATE `creature_template` SET `faction_A`=35    , `faction_H`=35   WHERE `entry` IN (31079,31492);
UPDATE `creature_template` SET `modelid1`=11172  , `faction_A`=16 , `faction_H`=16 WHERE `entry` IN (29321,31515);
UPDATE `creature_template` SET `faction_A`=16, `faction_H`=16 WHERE `entry` IN (29364,31518);

-- Heroic Loot Fix
UPDATE creature_loot_template SET item = 40752 WHERE item = 47241 AND entry IN (31506,31507,31508,31509,31510,31511,31512);