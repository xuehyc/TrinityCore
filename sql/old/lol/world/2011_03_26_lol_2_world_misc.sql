UPDATE `creature_template` SET `dmg_multiplier`=40 WHERE `entry`=28859;
UPDATE `creature_template` SET `dmg_multiplier`=70 WHERE `entry`=31734;
UPDATE `creature_template` SET `dmg_multiplier`=20 WHERE `entry`=30245;
UPDATE `creature_template` SET `dmg_multiplier`=30 WHERE `entry`=31750;

UPDATE `gameobject_loot_template` SET `item`=40753 WHERE `entry`=26097 AND `item`=47241;

UPDATE `npc_spellclick_spells` SET `spell_id`=46598 WHERE `npc_entry`=31748;
