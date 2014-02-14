-- Unlock Grim Batol
-- DELETE FROM `disables` WHERE `entry`=670;

-- Script Boss High Priestess Azil
UPDATE `creature_template` SET `mingold`='20027', `maxgold`='20027', `Health_mod`='45', `npcflag`='0', `unit_flags`='0', `difficulty_entry_1`='49624', `ScriptName`='npc_gravity_well', `mechanic_immune_mask`='613097436' WHERE `entry`='42333';

UPDATE `creature_template` SET `mingold`='20027', `maxgold`='20027', `Health_mod`='45', `npcflag`='0', `unit_flags`='0', `difficulty_entry_1`='49624', `ScriptName`='npc_gravity_well', `mechanic_immune_mask`='613097436' WHERE `entry`='49624';


UPDATE `creature_template` SET `ScriptName`='npc_gravity_well' WHERE `entry`='42499';


-- Script Boss Corborus
UPDATE `creature_template` SET `ScriptName`='boss_corborus' WHERE `entry`='43438';


-- Script Boss Ozruk
UPDATE `creature_template` SET `ScriptName`='boss_ozruk' WHERE `entry`='42188';

-- Script Boss Ozruk
UPDATE `creature_template` SET `ScriptName`='boss_slabhide' WHERE `entry`='43214';

UPDATE `creature_template` SET `ScriptName`='npc_stalactite_trigger' WHERE `entry`='43159';
UPDATE `creature_template` SET `ScriptName`='npc_lava_trigger' WHERE `entry`='43242';



-- NPC 
UPDATE `creature_template` SET `ScriptName`='mob_unbound_earth_rager' WHERE `entry`='43662';

UPDATE `creature_template` SET `ScriptName`='mob_stonecore_rift_conjurer' WHERE `entry`='42691';

UPDATE `creature_template` SET `ScriptName`='mob_stonecore_berserker' WHERE `entry`='43430';

UPDATE `creature_template` SET `ScriptName`='mob_stonecore_bruiser' WHERE `entry`='42692';

UPDATE `creature_template` SET `ScriptName`='mob_stonecore_flayer' WHERE `entry`='42808';

UPDATE `creature_template` SET `ScriptName`='mob_stonecore_warbringer' WHERE `entry`='42696';

UPDATE `creature_template` SET `ScriptName`='mob_stonecore_earthshaper' WHERE `entry`='43537';

UPDATE `creature_template` SET `ScriptName`='mob_stonecore_magmalord' WHERE `entry`='42789';
