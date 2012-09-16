DELETE FROM `creature` WHERE `id` = 32446;
UPDATE `creature_template` SET `exp` = 2, `mindmg` = 422, `maxdmg` = 586, `attackpower` = 642, `minrangedmg` = 345, `maxrangedmg` = 509, `rangedattackpower` = 103 WHERE `entry` IN (37531, 37532, 38139, 38151);
UPDATE `creature_template` SET `lootid` = 37532, `dmg_multiplier` = 2 WHERE `entry` = 38151;
UPDATE `creature_template` SET `dmg_multiplier` = 7.5 WHERE `entry` = 37531;
UPDATE `creature_template` SET `dmg_multiplier` = 13 WHERE `entry` = 38139;
UPDATE `creature` SET `spawntimesecs` = 604800 WHERE `id` IN (37531, 37532, 37533, 37534);
UPDATE `creature_template` SET `mechanic_immune_mask` = 617298815, `flags_extra` = 1, `unit_flags` = 320 WHERE `entry` IN (37533, 38220);
UPDATE `creature_template` SET `mechanic_immune_mask` = 617298815, `flags_extra` = 1, `unit_flags` = 66 WHERE `entry` IN (37534, 38219);
UPDATE `creature_template` SET `dmg_multiplier` = 30 WHERE `entry` IN (37533, 37534);
UPDATE `creature_template` SET `mindmg` = 509, `maxdmg` = 683, `attackpower` = 805, `dmg_multiplier` = 35, `rangeattacktime` = 2000, `minrangedmg` = 371, `maxrangedmg` = 535, `rangedattackpower` = 135 WHERE `entry` = 36853;
UPDATE `creature_template` SET `unit_flags` = 33554946 WHERE `entry` = 37186;
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_sindragosa_mystic_buffet';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(70127,'spell_sindragosa_mystic_buffet'),
(72528,'spell_sindragosa_mystic_buffet'),
(72529,'spell_sindragosa_mystic_buffet'),
(72530,'spell_sindragosa_mystic_buffet');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 70157 AND `spell_effect` = 69700;